require_relative "test_helper"

class BogusdbTest < MiniTest::Test
  def setup
    
  end

  def test_bogusdb_responds_to_version
    assert Bogusdb::VERSION
  end
end
