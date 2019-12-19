
class DetailConditionList < ViewObject

  def after_init(args)
    @ability_tree = hash_for(args[:ability_tree])
  end

  def html_output
    res = ""
    if @ability_tree.is_a?(Hash) && !@ability_tree.blank?
      if @ability_tree[:slave_rules].size == 0
        res = "il faut remplir la condition suivante : " + "<ul><li>" + _and_or(@ability_tree) + _eligibility(@ability_tree) + @ability_tree[:description] + "</li></ul>"
      else
        res = "il faut réunir " + _node_for(@ability_tree, {}, 0, true)
      end
    else
      res = "Le champ d'application n'existe pas, ou n'est pas encore visible. Si vous venez de le créer, il apparaîtra d'ici quelques instants."
    end
    raw(res)
  end


  def _node_for(ability, parent_ability, i, skip_img=false)
    _and_or(parent_ability, i) + _eligibility(ability, skip_img)  + _all_or_at_least(ability) +
    "<ul>" +
      ability[:slave_rules].map.with_index do |sub_ability, indx|
        if sub_ability[:composition_type].blank?
          "<li>" + _and_or(ability, indx).to_s  + _eligibility(sub_ability).to_s + sub_ability[:description].to_s  + "</li>"
        else
          "<li>" + _node_for(sub_ability, ability, indx) +  "</li>"
        end
      end.join +
    "</ul>"
  end


  def _all_or_at_least(ability)
    res = ""
    if ability[:composition_type] == "and_rule"
      res = "l'ensemble des #{ability[:slave_rules].size} conditions suivantes"
    elsif ability[:composition_type] == "or_rule"
      res = "au moins une des conditions suivantes"
    end
    res
  end

  def _and_or(ability, number=-1)
    res = ""
    if ability[:composition_type] == "and_rule"
      res = "<strong> </strong>"
    elsif ability[:composition_type] == "or_rule"
      res = "<strong>soit </strong>"
    end
    res
  end

  def _eligibility(ability, skip_img=false)
    res = ""
    unless skip_img
      if ability[:ability] == "eligible"
        res = '<svg width="18px" height="18px" id="Calque_134" class="c-detail-condition__svg-success" data-name="Calque 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><defs><style>.clsoksmall-1{fill:#167432;}</style></defs><title>ic-ok</title><path id="path1_fill" data-name="path1 fill" class="clsoksmall-1" d="M8.52,18.14,4.2,13.82l1.08-1.07L8.52,16,18.71,5.79,19.8,6.86Z"/><path id="path0_fill" data-name="path0 fill" class="clsoksmall-1" d="M12,24a11.93,11.93,0,0,1-8.48-3.51A12.21,12.21,0,0,1,.94,16.67a12,12,0,0,1,17.15-15L17.31,3A10.47,10.47,0,0,0,4.6,19.41a10.48,10.48,0,0,0,16.8-12l1.37-.68A11.89,11.89,0,0,1,24,12,12,12,0,0,1,12,24Z"/></svg> '
      elsif ability[:ability] == "uncertain"
        res = '<svg width="18px" height="18px" id="Calque_10" version="1.1"  class="c-detail-condition__svg-question" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 24 30" style="enable-background:new 0 0 24 30;" xml:space="preserve"> <style type="text/css">.sticincertaine0{fill:#FF7800;}</style><path id="path0_fill" class="sticincertaine0" d="M19.5,22c-3.1,3.1-7.6,4-11.5,2.3l2.6-1.5l-0.7-1.3l-4.7,2.7l2.7,4.8l1.2-0.7l-1.5-2.6 c1.4,0.6,2.9,0.8,4.4,0.8c3.1,0,6.2-1.2,8.5-3.6c3.9-3.9,4.7-10,1.9-14.7L21.2,9C23.6,13.2,22.9,18.6,19.5,22z"/><path id="path1_fill" class="sticincertaine0" d="M2.9,19.9c-2.4-4.2-1.8-9.6,1.6-13c3.2-3.2,7.9-4,11.9-2.2l-2.8,1.6l0.7,1.3l4.7-2.7L16.4,0 l-1.2,0.7l1.3,2.4C12.1,1.3,7,2.3,3.5,5.8c-3.9,3.9-4.6,10-1.8,14.8L2.9,19.9z"/><path id="path2_fill" class="sticincertaine0" d="M10.8,16.8c0-0.6,0.1-1.1,0.2-1.5c0.1-0.4,0.4-0.8,0.8-1.2l1-1.1c0.4-0.5,0.7-1,0.7-1.6 c0-0.5-0.1-1-0.4-1.3c-0.3-0.3-0.7-0.5-1.3-0.5c-0.5,0-1,0.1-1.3,0.4c-0.3,0.3-0.5,0.7-0.5,1.1H8.6c0-0.8,0.3-1.5,0.9-2 c0.6-0.5,1.4-0.8,2.3-0.8c1,0,1.8,0.3,2.3,0.8c0.6,0.5,0.8,1.3,0.8,2.2c0,0.9-0.4,1.8-1.3,2.7L12.8,15c-0.4,0.4-0.6,1-0.6,1.8H10.8z M10.7,19.3c0-0.2,0.1-0.4,0.2-0.6c0.1-0.2,0.4-0.2,0.6-0.2c0.3,0,0.5,0.1,0.6,0.2c0.1,0.2,0.2,0.4,0.2,0.6c0,0.2-0.1,0.4-0.2,0.6 c-0.1,0.2-0.4,0.2-0.6,0.2c-0.3,0-0.5-0.1-0.6-0.2C10.8,19.7,10.7,19.5,10.7,19.3z"/></svg> '
      elsif ability[:ability] == "ineligible"
        res = '<svg width="18px" height="18px" id="Calque_1111" class="c-detail-condition__svg-error" data-name="Calque 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><defs><style>.clskosmall-1{fill:#d80027;}</style></defs><title>ic-ko</title><path id="path0_fill" data-name="path0 fill" class="clskosmall-1" d="M12,0A12,12,0,1,0,24,12,12.1,12.1,0,0,0,12,0Zm0,22.4A10.45,10.45,0,1,1,22.5,12,10.61,10.61,0,0,1,12,22.4Z"/><path id="path1_fill" data-name="path1 fill" class="clskosmall-1" d="M17.3,6.5a.67.67,0,0,0-1,0L12,10.9,7.7,6.5a.71.71,0,0,0-1,1L11,12,6.7,16.5a.67.67,0,0,0,0,1,.72.72,0,0,0,1,0L12,13l4.3,4.4a.72.72,0,0,0,1,0,.67.67,0,0,0,0-1L13,12l4.3-4.5A.91.91,0,0,0,17.3,6.5Z"/></svg> '
      end
    end
    res
  end

end
