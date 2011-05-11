require 'test_helper'

class AdvertsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  def setup
    sign_in users(:marcus)
  end
  test "should be able to list ads" do
    get :index
    assert !assigns["adverts"].nil?

    assert_response :success


  end
  test "should be able to create ad" do
#    assert_difference('Advert.count') do 
      post :create, :advert=>{:title=>"foo",:body=>"bar",:user=>users(:marcus),:search=>searches(:dreams_search)}
      assert_response :success
#    end
#    assert_redirected_to "/adverts"
   
  end

end
