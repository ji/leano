class UserStory < ActiveRecord::Base
  belongs_to :kanban
  has_many :user_story_tags
  has_many :user_story_tasks
end
