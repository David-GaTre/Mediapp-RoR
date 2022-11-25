class Patient < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :offices
  has_many :entries
  has_many :meetings
  has_many :prescriptions

  def full_name    
    self.user.name + " " + self.user.first_last_name + " " + self.user.second_last_name
  end
end
