module Tmdb
  class Struct < OpenStruct

    def initialize(data=nil)
      @table = {}

      if data
        data.each do |k,v|
          self.send("#{k.to_sym}=", analyze_value(v))
        end
      end
    end

    def analyze_value(v)
      case
        when v.is_a?(Hash)
          self.class.new(v)
        when v.is_a?(Array)
          v.map do |element|
            analyze_value(element)
          end
        else
          v
      end
    end

  end
end
