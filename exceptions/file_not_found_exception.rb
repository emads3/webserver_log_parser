class FileNotFoundException < StandardError
  def initialize(msg = 'File Not Found')
    super
  end
end
