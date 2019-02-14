module Admin
  class RulesController < Admin::ApplicationController

    before_action :set_global_state, only: [:new, :edit, :create, :update]

    def set_global_state
      gon.global_state = {
        explicitations: _all_explicitations,
        operator_kinds: _all_operator_kinds,        
        variables: _all_variables,        
      }
    end

    def show 
      @asker = Asker.new
      @custom_rule_checks = Rule.find(params[:id]).custom_rule_checks
      super
    end

    def _all_explicitations
      JSON.parse(Explicitation.all.to_json(:only => [ :id, :value_eligible, :operator_kind, :template ], :include => {variable: {only:[:name]}})).map{|e| e["variable_name"] = e["variable"]["name"];e.delete("variable");e}
    end

    def _all_operator_kinds
      ListOperatorKind.new.call
    end

    def _all_variables
      JSON.parse(Variable.all.to_json(:only => [ :id, :name, :variable_kind, :elements, :elements_translation ]))
    end

    def new
      # See https://github.com/thoughtbot/administrate/blob/master/app/controllers/administrate/application_controller.rb
      resource = resource_class.new
      authorize_resource(resource)

      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
      }
    end

    def edit
      # p '- - - - - - - - - - - - - - requested_resource- - - - - - - - - - - - - - - -' 
      # pp requested_resource
      # p ''
      render locals: {
        page: Administrate::Page::Form.new(dashboard, requested_resource),
      }
    end

    def create
      resource = resource_class.new(resource_params)
      authorize_resource(resource)

      if resource.save
        redirect_to(
          [namespace, resource],
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    def update
      if requested_resource.update(resource_params)
        redirect_to(
          [namespace, requested_resource],
          notice: translate_with_resource("update.success"),
        )
      else
        render :edit, locals: {
          page: Administrate::Page::Form.new(dashboard, requested_resource), 
        }
      end
    end

    def save_simulation
      current_rule = Rule.find(params[:id])
      asker_params_cleaned = _asker_params.reject{|_, v| v.blank?}
      asker_hash = Asker.new(asker_params_cleaned).attributes
      custom_rule_check = CustomRuleCheck.new
      custom_rule_check.rule = current_rule
      custom_rule_check.name = _simulation_params[:name]
      custom_rule_check.result = _simulation_params[:result]
      custom_rule_check.hsh = asker_hash
      if custom_rule_check.save
        render json: ['ok'], status: :created
      else
        render json: ['error'], status: :unprocessable_entity
      end
    end

    def delete_simulation
      c = CustomRuleCheck.find(params[:id])
      c.destroy
      head :no_content
    end

    def resolve
      asker_params_cleaned = _asker_params.reject{|_, v| v.blank?}
      @asker = Asker.new(asker_params_cleaned)
      @rule = Rule.find(params[:id])
      render json: (RuletreeService.new.resolve(@rule.id, @asker.attributes)).to_json
    end

    def _asker_params(stubbed_params=nil)
      internal_params = stubbed_params == nil ? params : stubbed_params
      internal_params.require(:asker).permit(:v_handicap, :v_spectacle, :v_diplome, :v_cadre,
        :v_category, :v_duree_d_inscription, :v_allocation_value_min, :v_allocation_type,
        :v_location_label, :v_qpv, :v_zrr, :v_age, :v_location_city, :v_location_citycode, :v_location_country, :v_location_label, :v_location_route, :v_location_state, :v_location_street_number, :v_location_zipcode)
    end

    def _simulation_params
      params.require(:simulation).permit(:result, :name)
    end

  end
end
