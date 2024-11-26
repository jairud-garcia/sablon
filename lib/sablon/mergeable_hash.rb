module Sablon
  class MergeableHash < Hash
    def initialize(value = {})
      @_merged_objects = []
      self.merge!(value)
    end
    def [](key)
      is_value_present, resulting_value = lookup(key)
      if is_value_present
        if !resulting_value.nil?
          resulting_value
        else
          Sablon::NullObject.new
        end
      else
        super(key)
      end
    end
    def lookup(key)
      @_merged_objects.each do |object|
        if object.respond_to?(key.to_sym)
          return [true, object.public_send(key.to_sym)]
        end
      end
      [false, nil]
    end
    def merge!(value)
      if value.is_a?(Hash)
        value.each { |k, v| self[k.to_s] = v }
      end
      if value.is_a?(MergeableHash)
        @_merged_objects += value._merged_objects.dup
      else
        @_merged_objects << value
      end

      # if object.is_a?(Hash)
      #   super(object)
      # else
      #   @_merged_objects<<object
      # end
    end
    def merge(object)
      result = self.dup
      result.merge!(object)
      result
    end

    protected
      attr_reader :_merged_objects
  end

  class NullObject
    def nil?
      true
    end
  end
end
