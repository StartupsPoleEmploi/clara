require "google/apis/analyticsreporting_v4"
require "csv"
require "rake"

module Admin
  class PagesController < Admin::ApplicationController

    before_action :require_superadmin, except: [:get_hidden_admin, :get_cache, :post_cache]

    def post_broken
      DetectBrokenLinksJob.perform_later
      render json: {
        status: "ok, tâche démarrée, durée 3 min. environ. Vous pouvez allez voir sous /sidekiq/scheduled.",
      }
    end

    def get_relink

     res = Broken.all.map do |e| 
        h = {}
        h[:url] = e[:url]
        h[:new_url] = e[:new_url]
        h[:aids_slug] = JSON.parse(e[:aids_slug])
        h[:code] = e[:code]
        h
     end

     last_broken = Broken.last

     last_time = last_broken ? Broken.last.created_at.strftime('%d %b %Y') : ''

      render locals: {
        broken_links: res.sort_by { |e| e[:aids_slug].size  },
        last_time: last_time
      }
      
    end

    def post_delete_trace
      Trace.destroy_all
      render json: {status: "ok"}
    end

    def get_switch_peconnect
      render locals: {
        is_activated: PeconnectActivation.new.get_value
      }
    end

    def post_switch_peconnect
      PeconnectActivation.new.switch_value
      redirect_to admin_get_switch_peconnect_path
    end

    def get_switch_answer
      render locals: {
        is_activated: AnswerActivation.new.get_value
      }
    end

    def post_switch_answer
      AnswerActivation.new.switch_value
      redirect_to admin_get_switch_answer_path
    end

    # load clock
    def get_clock
      first_diff = Clockdiff.first
      unless first_diff
        first_diff = Clockdiff.new(value: 0)
        first_diff.save
      end
      render locals: {
        current_diff_value: first_diff.value
      }
    end

    def post_clock
      current_clockdiff = Clockdiff.first
      current_clockdiff.value = params[:clock_delta].to_i
      current_clockdiff.save
      render locals: {
        current_diff_value: current_clockdiff.value
      }
    end

    # load zrr
    def get_zrr
    end

    def post_zrr
      deleted_zrrs_cache = Rails.cache.delete("zrrs")
      Zrr.create unless Zrr.first
      z = Zrr.first
      z.value = _csv_data
      z.save
      render json: {
        deleted_zrrs_cache: deleted_zrrs_cache,
        status: "ok",
      }
    end

    def _csv_data
      params.extract!(:csv_data).permit(:csv_data).to_h["csv_data"]
    end

    # cache
    def get_cache
    end

    def post_cache
      ExpireCache.new.call
      render json: {status: "ok"}
    end

    # cache
    def get_session
    end

    def post_session
      Mae::Application.load_tasks
      Rake::Task["db:sessions:clear"].invoke

      # Rake::Task['db:schema:cache:clear'].invoke
      # ap ActiveRecord::SessionStore::Session.count
      # ActiveRecord::SessionStore::Session.delete_all
      render json: {status: "ok"}
    end

    # reset pwd
    def get_resetpwd
    end

    def post_resetpwd
      email = params.extract!(:email).permit(:email).to_h["email"]
      new_pwd = params.extract!(:new_pwd).permit(:new_pwd).to_h["new_pwd"]
      user = User.find_by(email: email)
      msg = 'not found'
      if user
        user.update(password: new_pwd)
        msg = 'ok'        
      end
      render json: {status: msg}
    end

    # reset all answers
    def get_reset_answers
    end
    def post_reset_answers
      Answer.destroy_all
      render json: {status: "ok"}
    end

    # refdata
    def get_ref_data
    end

    def post_ref_data
      Rails.application.load_seed
      render json: {status: "ok"}
    end

    # transfer anything
    def get_transfer_descr
    end

    def post_transfer_descr
      HelloWorldJob.set(wait: 5.seconds).perform_later
      render json: {status: "ok"}
    end
  end
end
