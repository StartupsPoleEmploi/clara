module Prefixable
  extend ActiveSupport::Concern

  included do
    before_validation :sanitize_name
  end

  def sanitize_name 
    return if name.blank?
    self.name = prefix + self.name unless name[0..1] == prefix
  end

  def prefix
    self.class.name[0].downcase+"_"
  end

end