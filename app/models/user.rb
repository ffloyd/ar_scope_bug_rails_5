class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name

  has_many :users_roles, dependent: :destroy
  has_many :roles, -> { distinct }, through: :users_roles

  scope :with_role, lambda { |role_name|
    joins(:roles).where(roles: { name: role_name })
  }

  scope :useless_join, lambda {
    subquery_sql = User.select('users.id AS user_id').to_sql
    joins("INNER JOIN (#{subquery_sql}) subquery ON subquery.user_id = users.id")
  }
end
