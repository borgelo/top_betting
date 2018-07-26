require 'test_helper'

class LeagueroundsControllerTest < ActionController::TestCase
  setup do
    @leagueround = leaguerounds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leaguerounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create leagueround" do
    assert_difference('Leagueround.count') do
      post :create, leagueround: {  }
    end

    assert_redirected_to leagueround_path(assigns(:leagueround))
  end

  test "should show leagueround" do
    get :show, id: @leagueround
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @leagueround
    assert_response :success
  end

  test "should update leagueround" do
    patch :update, id: @leagueround, leagueround: {  }
    assert_redirected_to leagueround_path(assigns(:leagueround))
  end

  test "should destroy leagueround" do
    assert_difference('Leagueround.count', -1) do
      delete :destroy, id: @leagueround
    end

    assert_redirected_to leaguerounds_path
  end
end
