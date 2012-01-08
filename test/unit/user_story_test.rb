require 'test_helper'

class UserStoryTest < ActiveSupport::TestCase
  test "should auto destroy associated objects" do
    user_story = UserStory.new
    user_story.user_story_tags<< UserStoryTag.new
    user_story.user_story_tasks<< UserStoryTask.new
    
    assert user_story.save, "User story should save #{user_story.errors.full_messages}"
    
    user_story_id = user_story.id
    user_story.destroy
    assert UserStoryTag.count(:all, conditions: {user_story_id: user_story_id}) == 0, "Destroying a user story should auto destroy associated tags"
    assert UserStoryTask.count(:all, conditions: {user_story_id: user_story_id}) == 0, "Destroying a user story should auto destroy associated tasks"
  end
end
