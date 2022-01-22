require 'minitest/autorun'

require_relative '../log_file'
require_relative '../exceptions/file_not_found_exception'
require_relative '../exceptions/file_not_readable'

class TestLogFile < MiniTest::Test

  def test_log_file_class_existence
    some_file = 'webserver.log'
    assert_kind_of LogFile, LogFile.new(some_file)
  end

  def test_set_and_get_file
    f = LogFile.new 'webserver.log'

    another_file = 'runner.rb'
    f.set_file another_file
    p f.get_file_name
    assert_equal(f.get_file_name, another_file)
  end

  def test_to_string
    f = LogFile.new 'webserver.log'
    assert_kind_of(String, f.to_s)
  end

  def test_raises_file_not_found
    assert_raises(FileNotFoundException) do
      LogFile.new 'not_existence_file'
    end
  end

  def test_raises_file_not_readable
    assert_raises(FileNotReadable) do
      out_file = File.new('/tmp/out.txt', 'w')
      out_file.close
      File.chmod(666, out_file)
      LogFile.new '/tmp/out.txt'
    end
    File.delete('/tmp/out.txt')
  end

end
