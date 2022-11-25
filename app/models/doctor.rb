class Doctor < ApplicationRecord
  belongs_to :user
  has_one :office
  has_many :prescriptions

  def full_name    
    self.user.name + " " + self.user.first_last_name + " " + self.user.second_last_name
  end
end
