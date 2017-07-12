# -*- coding: utf-8 -*-
require "test_helper"

class MergeableHash < Sablon::TestCase

  def test_hash_initializer
    mergeable_hash=Sablon::MergeableHash.new a: 1, b:'b'
    assert_equal({ 'b'=>'b', 'a'=> 1}, mergeable_hash)
  end

  def test_object_initializer
    mergeable_hash=Sablon::MergeableHash.new OpenStruct.new(x: 2)
    assert_equal(2, mergeable_hash[:x])
  end

  def merge!_hash
    mergeable_hash=Sablon::MergeableHash.new a: 1
    mergeable_hash.merge!(b: '2')
    assert_equal({ b:'2', a: 1}, mergeable_hash)
  end
  def merge_hash
    mergeable_hash=Sablon::MergeableHash.new a: 2
    new_hash=mergeable_hash.merge(b: '4')
    assert_equal({ b:'4', a: 2}, new_hash)
  end
  def merge_object
    mergeable_hash=Sablon::MergeableHash.new a: 2, b: 'B'
    new_hash=mergeable_hash.merge!(OpenStruct.new(x: 100, b: '1'))
    assert_equal(new_hash['x'], 100)
    assert_equal(new_hash[:a], 2)
    assert_equal(new_hash[:b], 1)
  end
  
  def merge
    mergeable_hash=Sablon::MergeableHash.new a: 1, b: { c: 2, "d" => 3 }
    new_merged_object=mergeable_hash.merge(a: "a", e: "new-key")
    assert_equal({ "a" => "a", "b" => { "c" => 2, "d" => 3 }, "e" => "new-key" }, new_merged_object)
  end

end
