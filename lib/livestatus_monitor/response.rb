require 'json'

module Response
  class << self
    def parse(data)
      data_array = JSON.parse(data)
      keys = data_array.unshift

      data_array.map do |data|
        Hash[keys.zip(data)].extend(Response)
      end
    end
  end

  def performance
    return @performance unless @performance.nil?

    @performance = { }

    data = self[:perf_data]

    @performance[:in] = data.match(/in=(?<in>[\d\.]+)/)[:in].to_i
    @performance[:out] = data.match(/out=(?<out>[\d\.]+)/)[:out].to_i

    @performance
  end
end