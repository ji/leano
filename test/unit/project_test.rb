require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "should save project" do
    project = Project.new
    project.title = "Test Project"
    
    assert project.save, "Project title is not set. #{project.errors.full_messages}"
  end
  
  test "should autocreate Kanban" do
    project = Project.new(title: "Test Project")
    
    assert_not_nil project.kanban, "Projects should come with a Kanban by default"
    assert_equal project.title, project.kanban.title, "Title of associated Kanban should be equal to owning Projects one"
  end
  
  test "should run with tags" do
    project = Project.new(title: "Project")
    user_story = UserStoryTag.new(tag_title: "Title")
    
    project.user_story_tags<< user_story
    assert project.save, "Project should save: #{project.errors.full_messages}"
  end
  
  test "should auto destroy associated objects" do
    project = Project.new(title: "Project")
    user_story = UserStoryTag.new(tag_title: "Title")
    project.user_story_tags<< user_story
    assert project.save, "Project should save: #{project.errors.full_messages}"
    
    project_id = project.id
    
    project.destroy
    assert Kanban.count(:all, conditions: {project_id: project_id}) == 0, "Destroying a Project should also destroy associated Kanban"
    assert UserStoryTag.count(:all, conditions: {project_id: project_id}) == 0, "Destroying a Project should also destroy associated UserStoryTags"
  end
end
