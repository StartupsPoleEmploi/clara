module Admin
  class AidsController < Admin::ApplicationController
    def find_resource(param)
      Aid.find_by!(slug: param)
    end

    def show 
      @asker = Asker.new
      super
    end

  end
end
