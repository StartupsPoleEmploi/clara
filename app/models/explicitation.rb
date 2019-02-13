class Explicitation < ApplicationRecord
  extend FriendlyId  
  include Operable

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank?
  end

end
