class EligibleView < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract = hash_for(locals[:contract])
    @aids = array_for(locals[:aids])
  end

  def contract_type
    @contract
  end

  def title_pertype
    intro = ""
    intro = "Inéligible" if @context.params[:action] == "ineligible"
    intro = "Éligible" if @context.params[:action] == "eligible"
    intro = "Peut-être éligible" if @context.params[:action] == "uncertain"

    "#{intro} : #{@aids.size} #{@contract[:description]}"
  end

  def clazz
    "c-eligible-title--#{@context.params[:action]}"
  end

  def line
    FilterRawAidsService.new(@aids).go[0]
  end

  def title_of_tab
    "#{@contract[:name]}"
  end

end
