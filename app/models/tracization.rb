class Tracization < ApplicationRecord
  belongs_to :aid, dependent: :destroy
  belongs_to :tracing, dependent: :destroy
end
