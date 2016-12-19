require 'test_helper'

class VillesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get villes_index_url
    assert_response :success
  end

  test "should get new" do
    get villes_new_url
    assert_response :success
  end

end
