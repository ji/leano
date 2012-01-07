require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @authenticated_user = :one
    @unauthnticated_user = :two
    
    @auth_options = {auth: true, owner: false}
    @owner_options = {auth: true, owner: true}
  end
  
  test "should get index" do
    run_test_with_options(@auth_options) do |success|
      get :index
      
      if success
        assert_response :success
      else
        assert_redirected_to login_url
      end
    end
  end

  test "should get new" do
    run_test_with_options(@auth_options) do |success|
      get :new

      if success
        assert_response :success
      else
        assert_redirected_to login_url
      end
    end
  end

  test "should create project" do
    run_test_with_options(@auth_options) do |success|
      if success
        assert_difference('Project.count') do
          post :create, project: @project.attributes
        end

        assert_redirected_to project_path(assigns(:project))
      else
        post :create, project: @project.attributes
        assert_redirected_to login_url
      end
    end
  end

  test "should create a project with a kanban containing a default column set" do
    run_test_with_options(@auth_options) do |success|
      if success
        assert_difference('Project.count') do
          post :create, project: @project.attributes, default_kanban_column_set: true
        end

        assert_redirected_to project_path(assigns(:project))
      else
        post :create, project: @project.attributes
        assert_redirected_to login_url
      end
    end
  end

  test "should show project" do
    run_test_with_options(@owner_options) do |success|
      get :show, id: @project.to_param

      if success
        assert_response :success
      else
        assert_redirected_to login_url
      end
    end
  end

  test "should get edit" do
    run_test_with_options(@owner_options) do |success|
      get :edit, id: @project.to_param

      if success
        assert_response :success
      else
        assert_redirected_to login_url
      end
    end
  end

  test "should update project" do
    run_test_with_options(@owner_options) do |success|
      put :update, id: @project.to_param, project: @project.attributes

      if success
        assert_redirected_to project_path(assigns(:project))
      else
        assert_redirected_to login_url
      end
    end
  end

  test "should destroy project" do
    run_test_with_options(@owner_options) do |success|
      if success
        assert_difference('Project.count', -1) do
          delete :destroy, id: @project.to_param
        end
        
        assert_redirected_to projects_path
      else
        delete :destroy, id: @project.to_param
        assert_redirected_to login_url
      end
    end
  end
  
  
  
  
  def run_test_with_options(options)
    if options[:auth] == true
      # run without authenticated user
      logout
      yield false
      
      if options[:owner] == true
        # run with unauthorized user
        login_as @unauthnticated_user
        yield false
        logout
        
        # run with authorized user
        login_as @authenticated_user
        yield true
        logout
      else
        # run with authorized user
        login_as @authenticated_user
        yield true
        logout

        # run with unauthorized user
        login_as @unauthnticated_user
        yield true
        logout
      end
    else
      # run without authenticated user
      logout
      yield true
      
      # run with unauthorized user
      login_as @unauthnticated_user
      yield true
      logout
      
      # run with authorized user
      login_as @authenticated_user
      yield true
      logout
    end
    
  end
  
end
