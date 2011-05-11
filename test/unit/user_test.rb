require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  test "groups_permissions" do
    u=users(:david)
    assert groups(:business_users).users.first.can?("can_export_search")  
  end
end
