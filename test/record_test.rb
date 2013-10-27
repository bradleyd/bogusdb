require_relative "test_helper"

class RecordTest < MiniTest::Test
  def setup
    @bogusdb = Bogusdb::Record.new(name: 'foo', dob: '04/14/75')
  end
  
  def test_responds_to_new
    assert_respond_to Bogusdb::Record, :new
  end

  def test_bogusdb_has_correct_params
    assert_raises(TypeError) {
      Bogusdb::Record.new("some_param")
    }
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
    assert_kind_of(Hash, @bogusdb.attributes)
  end

  def test_bogusdb_responds_to_join
    assert_respond_to @bogusdb, :join_table
  end

  def test_join_table_has_correct_params
    @bogusdb.expects(:join_table).with(:profile, {avatar: 'image.jpg'})  
    @bogusdb.join_table(:profile, {avatar: 'image.jpg'})
  end

  def test_bogusdb_has_joined_table
    @bogusdb.join_table(:profile, {avatar: 'image.jpg'})
    assert_respond_to @bogusdb, :profile
  end

  def test_joined_tabled_responds_to_columns
    @bogusdb.join_table(:profile, {avatar: 'image.jpg'})
    assert_respond_to @bogusdb.profile, :avatar
  end

  def test_joined_table_attributes_returns_hash
    @bogusdb.join_table(:profile, {avatar: 'image.jpg'})
    assert_kind_of(Hash, @bogusdb.profile.attributes)
  end

end
