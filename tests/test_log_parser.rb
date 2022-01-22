require 'minitest/autorun'

require_relative '../log_parser'

class TestLogParser < MiniTest::Test

  def test_parser_existence
    assert_kind_of LogParser, LogParser.new('webserver.log')
  end

  def test_parse_file
    log = []

    3.times do
      log << { :page => 'a', :ip => '123.123.123.123' }
    end
    4.times do
      log << { :page => 'b', :ip => '111.111.111.111' }
    end
    4.times do
      log << { :page => 'a', :ip => '111.111.111.111' }
    end

    temp_file = '/tmp/log'
    File.open(temp_file, 'a') do |f|
      log.each { |visit|
        f.puts("#{visit[:page]} #{visit[:ip]}")
      }
      # f.puts("some text some text\nsome anote\nasdfasdf")
    end
    parser = LogParser.new temp_file
    resulted_log = parser.get_log
    File.delete(temp_file)
    assert_equal resulted_log[:a][:visits], 7
  end
end
