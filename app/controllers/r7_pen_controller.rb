class R7PenController < ApplicationController

  def index
  end


    def get_r7_info
      target_object = params[:target_object]
      target_id = params[:target_id]
      b = nil
      if target_object == "contract_type"
        b = ContractType.new 
      elsif target_object == "api_user"
        b = ApiUser.new 
      else
        b = target_object.capitalize.constantize.new
      end  
      c = b.class

      res = c.find_by(id: target_id)
      if res == nil
        res = c.find_by(slug: target_id) if c.column_names.include? "slug"
      end
      render json: {
        actual_object: res
      }
    end

    def delete_r7_data
      Rule.where("name LIKE :prefix", prefix: "#{'r_fake'}%").destroy_all
      ContractType.where("name LIKE :prefix", prefix: "#{'r_fake'}%").destroy_all
      Convention.where("name LIKE :prefix", prefix: "#{'r_fake'}%").destroy_all
      Filter.where("name LIKE :prefix", prefix: "#{'r_fake'}%").destroy_all
      Variable.where("name LIKE :prefix", prefix: "#{'r_fake'}%").destroy_all
      Aid.where("name LIKE :prefix", prefix: "#{'r_fake'}%").destroy_all
      Explicitation.where("name LIKE :prefix", prefix: "#{'r_fake'}%").destroy_all
      Trace.where("url LIKE :prefix", prefix: "#{'r_fake'}%").destroy_all
      Tracing.where("name LIKE :prefix", prefix: "#{'r_fake'}%").destroy_all
      User.where("email LIKE :prefix", prefix: "#{'r_fake'}%").destroy_all
      ApiUser.where("email LIKE :prefix", prefix: "#{'r_fake'}%").destroy_all
      render json: {
        ok: "done"
      }
    end

    def post_r7_data
      r = Rule.new(name: "r_fake_" + rand(36**8).to_s(36), kind: "simple", variable_id: 1, operator_kind: "more_than", description: "age...", value_eligible: "42")
      r.save

      c = ContractType.new(name: 'r_fake_' + rand(36**8).to_s(36), ordre_affichage: 42)
      c.save

      cv = Convention.new(name: 'r_fake_' + rand(36**8).to_s(36))
      cv.save

      f = Filter.new(name: 'r_fake_' + rand(36**8).to_s(36))
      f.save
      
      v = Variable.new(name: 'r_fake_' + rand(36**8).to_s(36), variable_kind: "integer")
      v.save
      
      aid = Aid.new(name: 'r_fake_' + rand(36**8).to_s(36), ordre_affichage: 43, contract_type_id: 1 )
      aid.save
      
      e = Explicitation.new(name: 'r_fake_' + rand(36**8).to_s(36), template: "t", variable_id: 1)
      e.save
      
      trace = Trace.new(url: 'r_fake_' + rand(36**8).to_s(36))
      trace.save
      
      tracing = Tracing.new(name: 'r_fake_' + rand(36**8).to_s(36), rule_id: 362)
      tracing.save

      user = User.new(email:"r_fake#{rand(36**8).to_s(36)}@clara.com", password: "bar", role: "contributeur")  
      user.save
      
      api_user = ApiUser.new(email:"r_fake#{rand(36**8).to_s(36)}@apiuser.com", password: "bar")  
      api_user.save

      render json: {
        rule_id: r.id,
        contract_type_id: c.slug,
        convention_id: cv.id,
        filter_id: f.id,
        aid_id: aid.slug,
        variable_id: v.id,
        explicitation_id: e.slug,
        trace_id: trace.id,
        tracing_id: tracing.id,
        user_id: user.id,
        api_user_id: api_user.id,
      }
    end
end
