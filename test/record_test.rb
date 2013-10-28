require_relative "test_helper"

class RecordTest < MiniTest::Test
  def setup
    @bogusdb = Bogusdb::Record.new(name: 'akira', dob: '04/14/75')
  end
  
  def test_responds_to_new
    assert_respond_to Bogusdb::Record, :new
  end

  def test_responds_to_create
    assert_respond_to Bogusdb::Record, :create
  end

  def test_bogusdb_does_not_accept_string_params
    assert_raises(TypeError) {
      Bogusdb::Record.new("some_param")
    }
  end

  def test_multiple_records_on_create
    @bogusdb = Bogusdb::Record.create([{name: 'foo', dob: '04/14/75'},
                                       {name: 'baz', dob: '01/01/00'} ])

    assert_equal @bogusdb.first.name, 'foo' 
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

  def test_join_table_is_called_with_correct_params
    @bogusdb.expects(:join_table).with(:profile, {avatar: 'image.jpg'})  
    @bogusdb.join_table(:profile, {avatar: 'image.jpg'})
  end

  def test_bogusdb_has_a_joined_table
    @bogusdb.join_table(:profile, {avatar: 'image.jpg'})
    assert_respond_to @bogusdb, :profile
  end

  def test_joined_tabled_responds_to_specific_column
    @bogusdb.join_table(:profile, {avatar: 'image.jpg'})
    assert_respond_to @bogusdb.profile.first, :avatar
  end

  def test_joined_table_attributes_returns_hash
    @bogusdb.join_table(:profile, [{avatar: 'image.jpg'}, {avatar: 'sunny.jpg'}])
    assert_kind_of(Hash, @bogusdb.profile.first.attributes)
  end

  def test_joined_tables_when_multiples_records_are_created
    @bogusdb = Bogusdb::Record.create([{name: 'foo', dob: '04/14/75'},
                                       {name: 'baz', dob: '01/01/00'}
    ])

    @bogusdb.map {|i| i.join_table(:profiles, [{avatar: 'me.jpg'}, 
                                               {avatar: 'you.png'}]) 
    }
    assert_equal 'me.jpg', @bogusdb.first.profiles.first.avatar
  end
end
