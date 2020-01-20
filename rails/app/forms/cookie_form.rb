class CookieForm < ActiveType::Object

  attribute :analytics, :string
  attribute :hotjar, :string

  validates :analytics, presence: true
  validates :hotjar, presence: true

end
