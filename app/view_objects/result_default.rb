class ResultDefault < ViewObject

  def after_init(args)
    @all_data = hash_for(args).with_indifferent_access
    @contract_types = @all_data["flat_all_contract"]
    @filters = @all_data["flat_all_filter"]
  end

  def eligible_size
    @all_data["flat_all_eligible"].size
  end

  def sort_and_order(prop)
    (@all_data[prop] || {})
      .group_by{|e| e['contract_type_id']}
      .transform_values{|v| v.sort_by{|e| e['ordre_affichage']}}
      .values
      .sort_by{ |e| @contract_types.detect{|c| c["id"] == e.sample['contract_type_id']}["ordre_affichage"]}
  end

  def title_for(aids_per_contract)
    str_title = @contract_types.detect{|e| e["id"] == aids_per_contract[0]["contract_type_id"]}["name"]
    str_nb = aids_per_contract.size
    "#{str_nb} #{str_title}"
  end

  def descr_for(aids_per_contract)
    @contract_types.detect{|e| e["id"] == aids_per_contract[0]["contract_type_id"]}["description"]
  end

  def slug_for(aids_per_contract)
    @contract_types.detect{|e| e["id"] == aids_per_contract[0]["contract_type_id"]}["slug"]
  end

  def icon_for(aids_per_contract)
    icon = @contract_types.detect{|e| e["id"] == aids_per_contract[0]["contract_type_id"]}["icon"]
    icon.blank? ? default_svg.html_safe : icon.html_safe
  end

  def filters_of(aid)
    aid["filters"].map{|f| @filters.detect{|e| e["id"] == f["id"] }}
  end

  def default_svg
    '<svg width="60" height="60" class="default-svg" version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" xmlns:xlink="http://www.w3.org/1999/xlink" enable-background="new 0 0 512 512"><g><g><path d="m197.2,311.2c6.2-4.2 12.5-6.2 19.8-6.2 7.3,0 13.5,1 18.7,3.1 5.2,2.1 10.4,6.2 15.6,12.5l13.5-16.6c-11.4-14.7-28.1-22-47.8-22-13.5,0-26,4.2-36.4,12.5-10.4,8.3-17.7,18.7-21.8,32.3h-19.8v16.6 1h15.6c-0.2,8.1 1,12.5 1,15.6h-16.6v16.6h20.8c4.2,12.5 11.4,22.9 21.8,30.2 10.4,7.3 21.8,11.4 35.4,11.4 19.8,0 35.4-7.3 46.8-21.8l-13.5-16.6c-5.2,6.2-10.4,10.4-15.6,12.5-5.2,3.1-10.4,4.2-17.7,4.2-14.6,0-23.9-6.2-31.2-19.8h43.7v-16.6h-48.9c-1-2.1-1.7-11-1-15.6h48.9v-16.6h-44.7c3-7.4 7.2-12.6 13.4-16.7z"/><path d="M325.2,11.5H70.3v489h370.4l0-373.5L325.2,11.5z M406.3,121.8h-74.9V46.9L406.3,121.8z M90,479.7V32.3h220.6v98.8 c0,6.2,5.2,10.4,10.4,10.4h99.9v338.1H90z"/></g></g></svg>'
  end

end

