class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  
  has_many :contributors
  has_many :projects, :through => :contributors
end
