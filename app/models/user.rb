class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :doctor
  has_one :patient
  validates :name, presence: true
  validates :email, presence: true
  validates :first_last_name, presence: true
  validates :second_last_name, presence: true
  validates :sex, presence: true
  validates :dob, presence: true
  validates :curp, presence: true
  validates :phone_number, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable#, :confirmable #, :validatable

  def full_name    
    self.name + " " + self.first_last_name + " " + self.second_last_name
  end
      
  def is_doctor?
    self.role == 'doctor'
  end

  def is_patient?
    self.role == "patient"
  end

  def has_office? 
    if self.is_doctor?
      self.doctor.office.present?
    else
      false
    end
  end
      
end
