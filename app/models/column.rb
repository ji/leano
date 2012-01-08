class Column < ActiveRecord::Base
  belongs_to :kanban
  has_many :user_stories
end
