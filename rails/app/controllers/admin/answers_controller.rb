module Admin
  class AnswersController < Admin::ApplicationController

    def valid_action?(name, resource = resource_class)
      %w[new edit].exclude?(name.to_s) && super
    end
    
  end
end
