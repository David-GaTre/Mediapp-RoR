class Office < ApplicationRecord
  belongs_to :doctor
  has_and_belongs_to_many :patients
end
