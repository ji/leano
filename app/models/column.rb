class Column < ActiveRecord::Base
  belongs_to :kanban
  has_many :user_stories
  
  before_destroy { |column|
    column.user_stories.destroy_all
  }
end
