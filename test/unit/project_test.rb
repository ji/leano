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
end
