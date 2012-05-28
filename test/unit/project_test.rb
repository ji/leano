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

  test "should return the owner's name" do
    owner = User.new(name: "ted", password: "secret", email: "ted@me.com")
    owner.save

    project = Project.new(title: "Ted's project")
    project.users<< owner
    project.save

    contributor = Contributor.new(user_id: owner.id, project_id: project.id)
    contributor.save

    assert project.owner_name == owner.name, "#{owner.name}'s project does not belong to #{owner.name}"
  end

end
