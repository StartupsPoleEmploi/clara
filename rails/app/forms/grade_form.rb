class GradeForm < ActiveType::Object

  attribute :value, :string
  validates :value, presence: true
    
end
