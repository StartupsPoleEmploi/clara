class Breadcrumb < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @where = string_for(locals[:where])
    @context = locals[:context] if locals[:context]
  end

  def current_path(options = {})
    options = @context.request.params.symbolize_keys.merge(options)
    @context.url_for(Rails.application.routes.recognize_path(@context.request.path).merge(options))
  end

  def display_form?
    # @where == "question"
    # p '- - - - - - - - - - - - - - @context.request.path- - - - - - - - - - - - - - - -' 
    # p @context.request.path.inspect
    # p ''
    # questions = RoutesList.get_questions.keys
    # p '- - - - - - - - - - - - - - questions- - - - - - - - - - - - - - - -' 
    # p questions => ["new_age_question_path", "new_address_question_path", "new_allocation_question_path", "new_category_question_path", "new_grade_question_path", "new_inscription_question_path", "new_are_question_path", "new_other_question_path"]
    # p ''

    p '- - - - - - - - - - - - - - truc- - - - - - - - - - - - - - - -' 
    p current_path
    p ''


    # aaa = Rails.application.routes.recognized_request_for(@context.request.path)

    # aaa = url_for(@context.request.fullpath).inspect
    # p '- - - - - - - - - - - - - - aaa- - - - - - - - - - - - - - - -' 
    # p aaa => Donne "\"/inscription_questions/new\""
    # p ''

    # bbb = Rails.application.routes.recognize_path(aaa)
    # p '- - - - - - - - - - - - - - bbb- - - - - - - - - - - - - - - -' 
    # p bbb.inspect => Donne {controller:"machin" action:"truc"}
    # p ''
    # StringToRoute.
    # c = StringToRoute.new(@context.request).path
    # p '- - - - - - - - - - - - - - c- - - - - - - - - - - - - - - -' 
    # p c.inspect
    # p ''
    # current@context.current_page?(my_path)

    # current_named_route = RoutesList.all_pathes.select{|p| @context.current_page?(p)}
    # p '- - - - - - - - - - - - - - current_named_route- - - - - - - - - - - - - - - -' 
    # p current_named_route.inspect
    # p ''

    return false
  end

  def display_result?
    @context.request.path == aides_path && @context.params[:for_id]
  end

  def display_detail?
  end

end
