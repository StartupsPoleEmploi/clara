class CookieForm < ActiveType::Object

  attribute :authorize_statistic, :string
  attribute :forbid_statistic, :string
  attribute :authorize_navigation, :string
  attribute :forbid_navigation, :string
  attribute :authorized, :string
  attribute :forbidden, :string
  #attribute :value, :string


end
