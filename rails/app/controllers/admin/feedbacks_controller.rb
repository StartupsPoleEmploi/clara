module Admin
  class FeedbacksController < Admin::ApplicationController

    def valid_action?(name, resource = resource_class)
      %w[new destroy edit].exclude?(name.to_s) && super
    end

  end
end
