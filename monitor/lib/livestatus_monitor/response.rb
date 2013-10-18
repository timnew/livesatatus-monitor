require 'json'

module Response
  class << self
    def parse(data)
      data_array = JSON.parse(data)
      keys = data_array.shift

      keys.map!{ |i| i.to_sym rescue i }

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
    
    @performance[:in_max] = 30.mega
    @performance[:out_max] = 30.mega

    @performance[:in_percentage] =  @performance[:in].percentage_of @performance[:in_max]
    @performance[:out_percentage] = @performance[:out].percentage_of @performance[:out_max]

    @performance
  end
end