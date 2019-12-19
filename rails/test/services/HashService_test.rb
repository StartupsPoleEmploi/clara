require "test_helper"

class HashServiceTest < ActiveSupport::TestCase
  
  test '.recursive_compact should remove all empty elements from a hash' do
    #given
    myHash = { "Jane Doe" => 2 , "Jim Doe" => nil, 3 => nil }
    #when
    result = HashService.new.recursive_compact(myHash)
    #then
    assert_equal({ "Jane Doe" => 2 }, result)
  end

  test '.recursive_compact should remove all empty element from an array' do
    #given
    myArray = ["Good", nil, "morning", 4]
    #when
    result = HashService.new.recursive_compact(myArray)
    #then
    assert_equal(["Good", "morning", 4], result)
  end

  test '.recursive_compact should remove all empty element from an array in an hash' do
    #given
    myHashInAnArray = {"Good" => 4, "test" => ["Jim Doe", nil], 2 => nil}
    #when
    result = HashService.new.recursive_compact(myHashInAnArray)
    #then
    assert_equal({"Good" => 4, "test" => ["Jim Doe"]}, result)
  end

  test '.reject_ids! should remove id and _id from an hash' do
    #given
    x = {"my_id" => 1, "_id" => 2, "anything else" => 3}
    #when
    result = HashService.new.reject_ids!(x)
    #then
    assert_equal({"anything else" => 3}, result)
  end
  test '.reject_ids! should remove id and _id from a hash in a hash' do
    #given
    y = {"id" => 1, "hi" => {"_id" => 2, "how" => 3}, "are you" => 5}
    #when
    result = HashService.new.reject_ids!(y)
    #then
    assert_equal({"hi" => {"how" => 3}, "are you" => 5}, result)
  end
  test '.reject_ids! should remove id and _id from an array in a hash' do
    #given
    z = { "good morning" => 1, "id" => 2, "test" => [ {"my_id" => 4}, 3 ], "your_id" => [42] }
    #when
    result = HashService.new.reject_ids!(z)
    #then
    assert_equal( {"good morning"=>1, "test" => [ {}, 3 ] }, result)
  end
  test '.reject_ids! should remove id and _id from hash in an array' do
    #given
    k = [1, "id", "_id", {"my_id" => 2, "id" => 3}]
    #when
    result = HashService.new.reject_ids!(k)
    #then
    assert_equal([1, "id", "_id", {}], result)
  end

  test '.reject_keys_that_starts_with! should count keys that starts with some value in a hash' do
    #given
    x = {"my_test" => 1, "something special" => 42, "my test" => 2, "my other test" => 3, "the chosen one" => 4}
    val = "my"
    #when
    result = HashService.new.reject_keys_that_starts_with!(x, val)
    #then
    assert_equal(3, result)
  end
  test '.reject_keys_that_starts_with! should count keys that starts with some value in a hash from a hash' do
    #given
    y = {"my_test" => 1, "hash" => {"my_cat" => 3, "something special" => 42}, "my test" => 2, "the chosen one" => 4}
    val = "my"
    #when
    result = HashService.new.reject_keys_that_starts_with!(y, val)
    #then
    assert_equal(3, result)
  end
  test '.reject_keys_that_starts_with! should count keys that starts with some value from an array in a hash' do
    #given
    z = { "my_test" => 1, "random thing" => 2, "test" => [ {"my_test" => 4}, 3 ], "my_number" => [42] }
    val = "my"
    #when
    result = HashService.new.reject_keys_that_starts_with!(z, val)
    #then
    assert_equal(3, result)
  end
  test '.reject_keys_that_starts_with! should count keys that start with some value from a hash in an array' do
    #given
    k = [1, "hello", "my_test", {"my_test" => 2, "my_number" => 3}]
    val = "my"
    #when
    result = HashService.new.reject_keys_that_starts_with!(k, val)
    #then
    assert_equal(2, result)
  end

end
