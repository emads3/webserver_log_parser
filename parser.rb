#! /usr/bin/ruby

require_relative 'log_file'
require_relative 'log_parser'

def display_help_menu
  p 'usage: runner <file_name>'
  p "-h --help \t\t display the help menu"
end

arg = ARGV

if arg.length.zero?
  p 'Insufficient arguments number'
  display_help_menu
else

  display_help_menu if arg.include?('-h') or arg.include?('--help')

  case arg[0]
  when '-h', '--help'
    display_help_menu
  else
    file_name = arg[0]
    file = LogFile.new file_name
    # p "name: #{file}"
    parser = LogParser.new file
    parser.print_log_stats
  end
end

