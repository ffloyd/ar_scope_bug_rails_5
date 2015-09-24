class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name

  has_many :users_roles, dependent: :destroy
  has_many :roles, -> { distinct }, through: :users_roles

  scope :with_role, lambda { |role_name|
    joins(:roles).where(roles: { name: role_name })
  }

  scope :unscope_via_all, -> { User.all }

  class << self
    def unscope_via_all_as_class_method
      User.all
    end
  end
end
