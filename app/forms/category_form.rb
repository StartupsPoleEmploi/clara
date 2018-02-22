class CategoryForm < ActiveType::Object

  attribute :value, :string
  validates :value, presence: true
  
end
