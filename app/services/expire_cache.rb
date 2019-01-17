# deprecated
class ExpireCache < ClaraService

  is_callable

  def call
    Rails.cache.clear
    ActivatedModelsGeneratorService.new.regenerate
    # activated_models_deleted     = Rails.cache.delete("activated_models")
    # nb_of_detailed_aids_deleted = 0
    # cache_hash = Rails.cache.instance_variable_get(:@data)
    # if cache_hash.is_a?(Hash)
    #   cache_hash.keys.each do |k|  
    #     if k.start_with? "aids["
    #       Rails.cache.delete(k)
    #       nb_of_detailed_aids_deleted += 1
    #     end
    #   end
    # end
    # welcome_page                      = Rails.cache.delete("view_data_for_welcome_page")
    # all_need_filters_deleted          = Rails.cache.delete("need_filters")
    # all_custom_filters_deleted        = Rails.cache.delete("custom_filters")
    # all_custom_parent_filters_deleted = Rails.cache.delete("custom_parent_filters")
    # all_filters_deleted               = Rails.cache.delete("filters")
    # all_contract_types_deleted        = Rails.cache.delete("contract_types")
    # regenerated_activated_models      = !ActivatedModelsGeneratorService.new.regenerate.empty?
    
    # activated_models_singleton_reinitialized  = ActivatedModelsService.instance.regenerate

    # {
    #   welcome_page: welcome_page,
    #   activated_models_deleted: activated_models_deleted,
    #   nb_of_detailed_aids_deleted: nb_of_detailed_aids_deleted,
    #   all_need_filters_deleted: all_need_filters_deleted,
    #   all_custom_filters_deleted: all_custom_filters_deleted,
    #   all_custom_parent_filters_deleted: all_custom_parent_filters_deleted,
    #   all_filters_deleted: all_filters_deleted,
    #   all_contract_types_deleted: all_contract_types_deleted,
    #   regenerated_activated_models: regenerated_activated_models,
    #   activated_models_singleton_reinitialized: activated_models_singleton_reinitialized,
    # }
  end

end
