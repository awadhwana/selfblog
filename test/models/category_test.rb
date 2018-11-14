require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @category = Category.new(name: "sports")  
  end

  test "category should be valid" do
    assert @category.valid?  
  end
  test "name should not be too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
  test "name should be unique" do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid? 
  end

end
