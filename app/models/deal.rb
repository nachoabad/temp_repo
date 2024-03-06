class Deal < ApplicationRecord
  # counter_cache might not be safe for a write-intensive application/backgroubd jobs
  belongs_to :company, counter_cache: true
end
