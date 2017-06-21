require 'test_helper'

class SecretsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get secrets_index_url
    assert_response :success
  end

end
