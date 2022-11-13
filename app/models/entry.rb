class Entry < ApplicationRecord
  belongs_to :patient
  belongs_to :office
end
