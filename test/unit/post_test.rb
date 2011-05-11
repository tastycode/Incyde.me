require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "word_frequency" do
    Post.new(:user=>users(:jacob), :content=>"The quick quick quick brown fox jumped over over the lazy brown dog").save

    frequency=Post.word_frequency(Post.all)
    assert frequency.keys.length>0
    assert_equal frequency['brown'],2
  end

  test "should not save post without content" do
    post = Post.new(:user=>users(:jacob))
    assert post.save==false
  end

  test "should be able to save basic post" do
    post = Post.new(:user=>users(:jacob), :content=>"Foo bar baz")
    assert post.save
  end

end
