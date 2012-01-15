class UserStory < ActiveRecord::Base
  belongs_to :kanban
  belongs_to :column
  has_and_belongs_to_many :user_story_tags
  has_many :user_story_tasks
  
  before_destroy { |user_story|
    user_story.user_story_tasks.destroy_all
  }
end
