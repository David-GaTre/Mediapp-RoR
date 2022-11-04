class Doctor < ApplicationRecord
  belongs_to :user
  has_one :office


end
