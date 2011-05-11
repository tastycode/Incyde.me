require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def setup
    sign_in users(:marcus)
  end
  test "should be able to post an incyte" do
    assert_difference('Post.count') do 
      post :create, :post=>{:content=>"Foo bar"}
    end
    assert_redirected_to "/"
  end

end
