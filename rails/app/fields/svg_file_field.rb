require "administrate/field/base"

class SvgFileField < Administrate::Field::Base
  def to_s
    data
  end
end
