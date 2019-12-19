class AllocationForm < ActiveType::Object

  attribute :type, :string
  validates :type, presence: true

end
