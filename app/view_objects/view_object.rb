class ViewObject

  attr_reader :context

  include Rails.application.routes.url_helpers
  include ActionView::Helpers
  include ActionView::Context

  def initialize(context, args = {})
    @context = context
    after_init(args)
  end

  def after_init(args = {})
    # implemented by child classes
  end

  def integer_for(arg)
    arg.is_a?(Integer) ? arg : 0
  end
  def hash_for(arg)
    arg.is_a?(Hash) ? arg.symbolize_keys : {}
  end
  def array_of_hash_for(arg)
    arg.is_a?(Array) && arg.all?{|e| e.is_a?(Hash)} ? arg.map{|e| e.symbolize_keys} : []
  end
  def boolean_for(arg)
    arg.is_a?(FalseClass) || arg.is_a?(TrueClass) ? arg : false
  end
  def array_for(arg)
    arg.is_a?(Array) ? arg : []
  end
  def string_for(arg)
    arg.is_a?(String) ? arg : ''
  end
end
