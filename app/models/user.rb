class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: {with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "E-Mail invalid"}
  has_secure_password
  
  has_many :contributors
  has_many :projects, :through => :contributors
end
