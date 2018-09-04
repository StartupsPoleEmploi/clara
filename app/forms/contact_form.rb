class ContactForm < ActiveType::Object

  attribute :first_name, :string
  attribute :last_name, :string
  attribute :email, :string
  attribute :region, :string
  attribute :youare, :string
  attribute :askfor, :string
  attribute :question, :string

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :region, presence: true
  validates :youare, presence: true
  validates :askfor, presence: true
  validates :question, presence: true
  
end
