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
      p '- - - - - - - - - - - - - - the_day- - - - - - - - - - - - - - - -' 
      ap the_day
      p ''
      the_hourmin = the_resource.hourmin
      p '- - - - - - - - - - - - - - the_hourmin- - - - - - - - - - - - - - - -' 
      ap the_hourmin
      p ''
      the_date_day = the_day.to_date.strftime('%y/%m/%d')
      p '- - - - - - - - - - - - - - the_date_day- - - - - - - - - - - - - - - -' 
      ap the_date_day
      p ''
      deadline = DateTime.parse("#{the_date_day} #{the_hourmin}")
      p '- - - - - - - - - - - - - - deadline- - - - - - - - - - - - - - - -' 
      ap deadline
      p ''
      actual_now = DateTime.now.strftime("%d %b %Y %H:%M:%S")
      p '- - - - - - - - - - - - - - actual_now- - - - - - - - - - - - - - - -' 
      ap actual_now
      p ''
      delta = Clockdiff.first.value
      p '- - - - - - - - - - - - - - delta- - - - - - - - - - - - - - - -' 
      ap delta
      p ''
      delta_deadline = deadline.change(hour: deadline.hour - delta, min: deadline.minute)
      p '- - - - - - - - - - - - - - delta_deadline- - - - - - - - - - - - - - - -' 
      ap delta_deadline
      p ''
      SendRecallJob.set(wait_until: delta_deadline).perform_later(the_resource.id, the_request.try(:original_url))
    end

  end
end
