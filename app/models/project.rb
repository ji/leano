class Project < ActiveRecord::Base
  has_one :kanban
  validates_presence_of :title
end
