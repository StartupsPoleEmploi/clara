begin
  ActivatedModelsGeneratorService.new.regenerate
rescue Exception => error
  ap "Unable to load cache #{error.to_s}"
end

