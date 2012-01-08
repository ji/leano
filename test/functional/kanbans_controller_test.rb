require 'test_helper'

class KanbansControllerTest < AuthenticationControllerTest
  setup do
    @kanban = kanbans(:one)
    @authenticated_user = :one
    @unauthnticated_user = :two
    
    @auth_options = {auth: true, owner: false}
    @owner_options = {auth: true, owner: true}
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:kanbans)
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should create kanban" do
  #   assert_difference('Kanban.count') do
  #     post :create, kanban: @kanban.attributes
  #   end
  # 
  #   assert_redirected_to kanban_path(assigns(:kanban))
  # end

  test "should show kanban" do
    run_test_with_options(@owner_options) do |success|
      get :show, id: @kanban.to_param
      
      if success
        assert_response :success
      else
        assert_redirected_to login_url
      end
    end
  end

  test "should get edit" do
    run_test_with_options(@owner_options) do |success|
      get :edit, id: @kanban.to_param
      
      if success
        assert_response :success
      else
        assert_redirected_to login_url
      end
    end
  end

  test "should update kanban" do
    run_test_with_options(@owner_options) do |success|
      put :update, id: @kanban.to_param, kanban: @kanban.attributes
      
      if success
        assert_redirected_to kanban_path(assigns(:kanban))
      else
        assert_redirected_to login_url
      end
    end
  end

  # test "should destroy kanban" do
  #   assert_difference('Kanban.count', -1) do
  #     delete :destroy, id: @kanban.to_param
  #   end
  # 
  #   assert_redirected_to kanbans_path
  # end
end
