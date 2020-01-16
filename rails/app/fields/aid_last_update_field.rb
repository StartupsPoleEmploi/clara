require "administrate/field/base"

class AidLastUpdateField < Administrate::Field::Base
  def to_s
    I18n.localize(data, :format => "%B %Y").camelize
  end
end
