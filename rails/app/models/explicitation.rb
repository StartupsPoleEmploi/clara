# == Schema Information
#
# Table name: explicitations
#
#  id             :integer(8)      not null, primary key
#  name           :string
#  slug           :string
#  template       :text
#  variable_id    :integer(8)
#  operator_kind  :string
#  value_eligible :string
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

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
