class Explicitation < ApplicationRecord
  extend FriendlyId  


  enum operator_kind: ListOperatorKind.new.call
  friendly_id :name, use: :slugged

  belongs_to :variable, optional: false

  validates :name, presence: true
  validates :template, presence: true
  validates :variable, presence: true


  def should_generate_new_friendly_id?
    slug.blank?
  end

end
