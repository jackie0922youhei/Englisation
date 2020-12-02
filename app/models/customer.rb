class Customer < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  #after_create :assign_teacher_role
  #after_create :assign_default_role
  
  # is_teacher : boolean
  after_create :assign_role
  
  def assign_role
    if self.is_teacher?
      self.add_role(:teacher) 
    else
      self.add_role(:guest)
    end
  end
  

  # def assign_default_role
  #   self.add_role(:guest) if self.roles.blank?
  # end

  # def assign_teacher_role
  #   self.add_role(:teacher) if self.username == 'teacher'
  # end

end
