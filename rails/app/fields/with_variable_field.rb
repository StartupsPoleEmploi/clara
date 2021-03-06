require "administrate/field/associative"

class WithVariableField < Administrate::Field::Associative
  def self.permitted_attribute(attr, _options = nil)
    :"#{attr}_id"
  end

  def permitted_attribute
    foreign_key
  end

  def associated_resource_options
    res = [nil] + candidate_resources.map do |resource|
      [display_candidate_resource(resource), resource.send(primary_key), {"data-name" => resource.send(:name), "data-visible" => resource.send(:is_visible)}]
    end
    res
  end

  def selected_option
    data && data.send(primary_key)
  end

  def to_s
    data
  end

  private

  def candidate_resources
    scope = options[:scope] ? options[:scope].call : associated_class.all

    order = options.delete(:order)
    order ? scope.reorder(order) : scope
  end

  def display_candidate_resource(resource)
    associated_dashboard.display_resource(resource)
  end

end
