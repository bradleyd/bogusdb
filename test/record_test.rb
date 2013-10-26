require_relative "test_helper"

class RecordTest < MiniTest::Test
  def setup
    # fake user record
    @bogusdb = Bogusdb::Record.new(name: 'foo', dob: '04/14/75')
  end
  
  def test_responds_to_new
    assert_respond_to Bogusdb::Record, :new
  end

  def test_bogusdb_responds_to_name
    assert_respond_to @bogusdb, :name
  end

  def test_bogusdb_responds_to_dob
    assert_respond_to @bogusdb, :dob
  end

  def test_record_responds_to_attributes
    assert_respond_to(@bogusdb, :attributes,  "Failure message.")
  end

  def test_attributes_returns_hash
    p @bogusdb.inspect
    assert_kind_of(Hash, @bogusdb.attributes)
  end

  

end
