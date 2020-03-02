require 'uri'

class QuestionManager
   include Rails.application.routes.url_helpers

  def getPreviousPath(referer, asker)  
    self.public_send('before_' + referer, asker)
  end

  def getNextPath(*args)
  
    if args.empty?
      after_default[:path]
    else
      referer = args[0]
      form = args[1]
      self.public_send('after_' + referer, form)[:path]
    end
  
  end

  def getCurrentWeight(*args)
    res = 0
    if args.empty?
      res = after_default[:weight]
    else
      referer = args[0]
      form = args[1]
      res = self.public_send('after_' + referer, nil)[:weight]
    end
    res 
  end

  def after_default
    path = new_inscription_question_path
    {
      weight: 0,
      path: path
    }
  end

  def after_inscription(inscriptionForm)
    path = ""
    if inscriptionForm
      if inscriptionForm.value != 'non_inscrit'
        path = new_category_question_path
      else
        path = new_allocation_question_path
      end
    end
    {
      weight: 1.0/10,
      path: path
    }
  end

  def after_category(categoryForm)
    path = new_allocation_question_path
    {
      weight: 2.0/10,
      path: path
    }
  end

  def after_allocation(allocationForm)
    path = ""
    if allocationForm 
      if allocationForm.type == 'ASS_AER_APS_AS-FNE' || allocationForm.type == 'ARE_ASP'
        path = new_are_question_path
      else
        path = new_age_question_path
      end
    end
    {
      weight: 3.0/10,
      path: path
    }
  end

  def after_are(areForm)
    path = new_age_question_path
    {
      weight: 4.0/10,
      path: path
    }
  end

  def after_age(ageForm)
    path = new_grade_question_path
    {
      weight: 5.0/10,
      path: path
    }
  end  

  def after_grade(ageForm)
    path = new_address_question_path
    {
      weight: 6.0/10,
      path: path
    }
  end  
  
  def after_address(addressForm)
    path = new_other_question_path
    {
      weight: 7.0/10,
      path: path
    }
  end

  def after_other(asker_id)
    path = new_filter_question_path
    {
      weight: 7.0/10,
      path: path
    }
  end 

  def after_filter(asker_id)
    path = ""
    if asker_id
      path = aides_path + '?for_id=' + asker_id
    end
    {
      weight: 9.0/10,
      path: path
    }
  end 

  def before_other(asker)
    new_address_question_path
  end 

  def before_address(asker)
    new_grade_question_path
  end

  def before_grade(asker)
    new_age_question_path
  end 

  def before_age(asker)
    if asker && asker[:v_allocation_value_min].is_a?(String) && asker.v_allocation_value_min.match(/^(\d)+$/)
      new_are_question_path
    else
      new_allocation_question_path
    end
  end

  def before_inscription(asker)
    root_path
  end

  def before_category(asker)
    new_inscription_question_path
  end

  def before_allocation(asker)
    asker.v_category === "not_applicable" ? new_inscription_question_path : new_category_question_path
  end

  def before_are(asker)
    new_allocation_question_path
  end

end
