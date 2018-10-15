class ActivatedModelsGeneratorService

  def regenerate
    activated_models = {}
    activated_models["all_activated_aids"] = JsonModelsService.aids
    activated_models["all_filters"]        = JsonModelsService.filters
    activated_models["all_level3_filters"] = JsonModelsService.level3_filters
    activated_models["all_rules"]          = JsonModelsService.rules
    activated_models["all_variables"]      = JsonModelsService.variables
    activated_models["all_contracts"]      = JsonModelsService.contracts

    # Icky, but works in a reasonable concurrent env
    File.open(Rails.root.join('public','activated_models.txt'), 'w:UTF-8') do |file| 
      file.write(activated_models.to_json) 
    end
    activated_models
  end

end
