require 'test_helper'
require 'bcrypt'

class ContributorTest < ActiveSupport::TestCase
  test "New project should accept new user" do
    project = Project.new(title: "Project 1");
    assert project.save, "Project should save #{project.errors.full_messages}"
    
    assert_difference('project.users.count') do
      user = User.new(name: "dave123",
                      password: "secret",
                      is_stakeholder: false,
                      email: "dave123@me.com")


      assert user.save, "User should save #{user.errors.full_messages}"

      project.users<< user
    end
    
    assert project.save, "Project should save with new user. #{project.errors.full_messages}"
  end
  
  test "New user should accept new project" do
    user = User.new(name: "dave123",
                    password: "secret",
                    is_stakeholder: false,
                    email: "dave123@me.com")
    assert user.save, "User should save #{user.errors.full_messages}"
    
    assert_difference('user.projects.count') do
      project = Project.new(title: "Project 1");
      assert project.save, "Project should save #{project.errors.full_messages}"
      
      user.projects<< project
    end
    
    assert user.save, "User should save #{user.errors.full_messages}"
  end
  
  test "Contributors existence" do
    user = User.new(name: "dave123",
                    password: "secret",
                    is_stakeholder: false,
                    email: "dave123@me.com")
    assert user.save, "User should save #{user.errors.full_messages}"
    
    project = Project.new(title: "Project 1");
    assert project.save, "Project should save #{project.errors.full_messages}"
    
    user.projects<< project
    assert user.save, "User should save #{user.errors.full_messages}"
    
    assert Contributor.count > 0, "No contributors created in Contributor model."
  end
end
