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
  
  test "should destroy associated Kanban" do
    project = Project.new(title: "Project")
    assert project.save, "Project title is not set. #{project.errors.full_messages}"
    
    kanban_id = project.kanban.id
    
    project.destroy
    assert Kanban.count(:all, conditions: {id: kanban_id}) == 0, "destroying a Project should also destroy associated Kanban"
  end
end
