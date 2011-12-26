class Kanban < ActiveRecord::Base
  belongs_to :project
  has_many :columns
end
