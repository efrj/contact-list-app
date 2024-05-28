require "test_helper"

class ContactTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @contact = @user.contacts.build(name: "John Doe", cpf: "12345678909", phone: "1234567890", address: "Street 1", city: "City", state: "ST", zip: "12345-678")
  end

  test "should be valid" do
    assert @contact.valid?
  end

  test "name should be present" do
    @contact.name = "   "
    assert_not @contact.valid?
  end

  test "cpf should be present" do
    @contact.cpf = "   "
    assert_not @contact.valid?
  end

  test "cpf should be unique per user" do
    duplicate_contact = @contact.dup
    @contact.save
    assert_not duplicate_contact.valid?
  end

  test "cpf should be valid" do
    @contact.cpf = "12345678900"
    assert_not @contact.valid?
  end
end
