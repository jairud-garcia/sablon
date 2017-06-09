require "test_helper"

class InsertionOperationTest < Sablon::TestCase
  def setup
    super
  end
  
  def test_evaluation_without_errors
    expr_mock = MiniTest::Mock.new
    expr_mock.expect(:evaluate,  true,[Object] )
    field_mock = MiniTest::Mock.new
    field_mock.expect(:replace,  true,[Object,Object] )
    env_mock = MiniTest::Mock.new
    env_mock.expect(:context,  'context' )
    instance = Sablon::Statement::Insertion.new(
      expr_mock, field_mock,[])
    instance.evaluate(env_mock)
    assert_empty(instance.errors)
  end  

  def test_evaluation_with_errors
    expr_mock = MiniTest::Mock.new
    expr_mock.expect(:evaluate,  false,[Object] )
    field_mock = MiniTest::Mock.new
    field_mock.expect(:remove, nil)
    env_mock = MiniTest::Mock.new
    env_mock.expect(:context,  'context' )
    instance = Sablon::Statement::Insertion.new(
      expr_mock, field_mock,[])
    instance.evaluate(env_mock)
    refute_empty(instance.errors)
    assert_equal "NotFoundInContext", instance.errors[0][:message]
    
  end
end
