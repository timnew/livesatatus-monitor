class Request
  MAX_RESPONSE_LENGTH = 1024*10

  class << self
    def get(table)
      new.get(table)
    end
  end

  def initialize
    @table = nil
    @filters = []
    @column_headers = false
    @columns = []
    @output_format = nil
    @separators = nil
  end

  def get(table)
    @table = table
    self
  end

  def filter(*conditions)
    @filters.add_all conditions
    self
  end

  def column_headers(value)
    @column_headers = value
    self
  end

  def column(*columns)
    @columns.add_all columns
    self
  end

  def output_format(format)
    @output_format = format
    self
  end

  def separator(*chars)
    @separators = chars.map { |c| c.ord }
    self
  end

  def send_to(stream)
    stream << "GET #{@table}\n"
    stream << "OutputFormat: #{@output_format}\n" unless @output_format.nil?
    stream << "Separators: #{@separators.join(' ')}\n" unless @separators.nil?
    @filters.each { |filter| stream << "Filter: #{filter}\n" }
    stream << "Columns: #{@columns.join(' ')}\n" unless @columns.empty?
    stream << "ColumnHeaders: #{@column_headers == true ? 'on' : @column_headers }\n" if @column_headers
    stream << "\n"

    stream
  end

  def to_s
    send_to ''
  end

  def fetch_response(socket)
    result = socket.gets

    while socket.ready?
      result += "\n" + socket.gets
    end

    result
  end

  def submit(socket)
    send_to(socket)

    socket.readpartial MAX_RESPONSE_LENGTH
  ensure
    socket.close
  end

  def submit_and_parse(socket)
    Response.parse submit(socket)
  end
end