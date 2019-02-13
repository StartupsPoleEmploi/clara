module Operable
  extend ActiveSupport::Concern

  included do
    enum operator_kind: {
        equal: "equal", 
        not_equal: "not_equal", 
        more_than: "more_than", 
        less_than: "less_than", 
        more_or_equal_than: "more_or_equal_than", 
        less_or_equal_than: "less_or_equal_than", 
        starts_with: "starts_with", 
        not_starts_with: "not_starts_with", 
        amongst: "amongst", 
        not_amongst: "not_amongst"
    }
  end


end
