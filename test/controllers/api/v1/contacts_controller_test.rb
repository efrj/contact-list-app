require "test_helper"

class Api::V1::ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @contact = contacts(:one)
    @other_contact = contacts(:two)
  end

  test "should get index" do
    sign_in @user
    get api_v1_contacts_url, as: :json
    assert_response :success
  end

  test "should create contact" do
    sign_in @user
    assert_difference('Contact.count') do
      post api_v1_contacts_url, params: { contact: { name: "Jane Doe", cpf: "98765432100", phone: "0987654321", address: "Street 2", city: "City", state: "ST", zip: "98765-432" } }, as: :json
    end
    assert_response 201
  end

  test "should show contact" do
    sign_in @user
    get api_v1_contact_url(@contact), as: :json
    assert_response :success
  end

  test "should update contact" do
    sign_in @user
    patch api_v1_contact_url(@contact), params: { contact: { name: "John Updated" } }, as: :json
    assert_response 200
  end

  test "should destroy contact" do
    sign_in @user
    assert_difference('Contact.count', -1) do
      delete api_v1_contact_url(@contact), as: :json
    end
    assert_response 204
  end

  private

  def sign_in(user)
    post user_session_url, params: { user: { email: user.email, password: 'password' } }, as: :json
  end
end
