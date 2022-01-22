class FileNotReadable < StandardError
  def initialize(msg = 'File Not Readable')
    super
  end
end
