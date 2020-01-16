class Trace < ApplicationRecord
  belongs_to :tracing, optional: true
end
