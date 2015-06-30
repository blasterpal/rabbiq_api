require 'test_helper'

class Api::PostsControllerTest < ActionController::TestCase
  setup do
    @api_post = api_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_posts)
  end

  test "should create api_post" do
    assert_difference('Api::Post.count') do
      post :create, api_post: { body: @api_post.body, published: @api_post.published, title: @api_post.title }
    end

    assert_response 201
  end

  test "should show api_post" do
    get :show, id: @api_post
    assert_response :success
  end

  test "should update api_post" do
    put :update, id: @api_post, api_post: { body: @api_post.body, published: @api_post.published, title: @api_post.title }
    assert_response 204
  end

  test "should destroy api_post" do
    assert_difference('Api::Post.count', -1) do
      delete :destroy, id: @api_post
    end

    assert_response 204
  end
end
