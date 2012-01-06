class Project < ActiveRecord::Base
  has_many :contributors
  has_many :users, :through => :contributors
  
  has_one :kanban
  validates_presence_of :title
end
