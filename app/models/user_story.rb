class UserStory < ActiveRecord::Base
  belongs_to :kanban
  belongs_to :column
  has_many :user_story_tags
  has_many :user_story_tasks
end
