require 'test_helper'

class FactoryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get factory_index_url
    assert_response :success
  end

end
