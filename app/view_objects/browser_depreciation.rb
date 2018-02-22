class BrowserDepreciation < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @browser = locals[:browser]
  end

  def show_depreciation_warning?
    BrowserDepreciationService.get_instance(@browser).deprecated?
  end

end
