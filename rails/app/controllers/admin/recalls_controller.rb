module Admin
  class RecallsController < Admin::ApplicationController

    def create
      resource = resource_class.new(resource_params)
      authorize_resource(resource)

      if resource.save
        _plan_job_for_recall(resource, request)
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

    def valid_action?(name, resource = resource_class)
      %w[edit].exclude?(name.to_s) && super
    end

    def _plan_job_for_recall(the_resource, the_request)
      the_day = the_resource.trigger_at
      the_hourmin = the_resource.hourmin
      the_date_day = the_day.to_date.strftime('%y/%m/%d')
      deadline = DateTime.parse("#{the_date_day} #{the_hourmin}")
      actual_now = DateTime.now.strftime("%d %b %Y %H:%M:%S")
      delta = Clockdiff.first.value
      delta_deadline = deadline.change(hour: deadline.hour - delta, min: deadline.minute)
      SendRecallJob.set(wait_until: delta_deadline).perform_later(the_resource.id, the_request.try(:original_url))
    end

  end
end
