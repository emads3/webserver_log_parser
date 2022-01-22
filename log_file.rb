require_relative './exceptions/file_not_found_exception'
require_relative './exceptions/file_not_readable'

class LogFile

  def initialize file
    @file_name = file
    run_file_validity_checks
  end

  def set_file file
    @file_name = file
    run_file_validity_checks
  end

  def get_file_name
    @file_name
  end

  def to_s
    @file_name
  end

  protected

  def run_file_validity_checks
    raise FileNotFoundException unless check_file_existence
    raise FileNotReadable unless check_file_is_readable?
  end

  def check_file_is_readable?
    File.readable? @file_name
  end

  def check_file_existence
    File.exist? @file_name
  end

end
