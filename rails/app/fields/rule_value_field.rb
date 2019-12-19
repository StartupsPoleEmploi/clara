require "administrate/field/base"

class RuleValueField < Administrate::Field::Base
  def to_s
    data
  end
end
