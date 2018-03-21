class Variable < ApplicationRecord
  include Prefixable
  has_paper_trail ignore: [:updated_at]

  enum variable_type: [:integer, :string]
  has_many :rule
  validates :variable_type, presence: true

end

# == Schema Information
#
# Table name: variables
#
#  id            :integer         not null, primary key
#  name          :string
#  variable_type :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  description   :text
#

