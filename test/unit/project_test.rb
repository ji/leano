require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should save project" do
    project = Project.new
    project.title = "Test Project"
    
    assert project.save, "Project title is not set."
  end
  
  test "New Projects Kanban" do
    project = Project.new(title: "Test Project")
    
    assert_not_nil project.kanban, "Projects should come with a Kanban by default"
    assert_equal project.title, project.kanban.title, "Title of associated Kanban should be equal to owning Projects one"
  end
end
