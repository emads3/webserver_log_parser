# frozen_string_literal: true

class LogParser

  def initialize file
    @file = file.to_s
    parse_file
  end

  def print_log_stats
    @log.each do |page, stats|
      p "#{page} .. total visits: #{stats[:visits]} .. unique_visits: #{stats[:ips].length}"
    end
  end

  def get_log
    @log
  end

  protected

  def parse_file

    @log = {}

    File.open(@file).each do |line|

      tokens = line.chop.split ' '

      next if line.length < 2 # log format must be split into two tokens <page> <IP>, this will also handle empty lines

      page = tokens[0].to_sym
      ip = tokens[1]

      if @log.key?(page) # already has that page stored

        @log[page][:ips] << ip unless @log[page][:ips].include?(ip)

        @log[page][:visits] = @log[page][:visits] + 1 # increment non-unique visits counter

      else
        @log[page] = { ips: [ip], visits: 1 }
      end
    end
  end

end
