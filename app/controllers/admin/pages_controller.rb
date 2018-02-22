module Admin
  class PagesController < Admin::ApplicationController

    def rename
    end

    def archive
    end

    def loadrefdata
    end

    def load_ref_data
      Rails.application.load_seed
    end

    def archive_all_aids
      d  = Date.parse("2014-1-17")
      Aid.all.update_all("archived_at = '#{d}'")
      return
    end

    def unarchive_all_aids
      Aid.all.update_all("archived_at = null")
      return
    end

    def rename_eligible_value
      
      a = params.extract!(:initial_value).permit(:initial_value).to_h
      b = params.extract!(:final_value).permit(:final_value).to_h


      initial_value = a[:initial_value]

      
      final_value = b[:final_value]

      CustomRuleCheck.where(result: initial_value).update_all("result = '#{final_value}'")
    end
  end
end
