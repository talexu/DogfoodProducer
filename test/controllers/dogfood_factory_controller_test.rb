require 'test_helper'

class DogfoodFactoryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dogfood_factory_index_url
    assert_response :success
  end

end
