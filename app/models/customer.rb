class Customer < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  after_create :assign_teacher_role
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:guest) if self.roles.blank?
  end

  def assign_teacher_role
    self.add_role(:teacher) if self.username == 'teacher'
  end

end
