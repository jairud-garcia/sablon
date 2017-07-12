module Sablon
  class MergeableHash < Hash
    def initialize(value={})
      @_merged_objects=[]
      self.merge!(value)
    end
    def [] key
      merged_value=lookup(key)
      if merged_value[0]
        return merged_value[1]
      else
        super(key)
      end
    end
    def lookup(key)
      @_merged_objects.each do |object|
        if object.respond_to?(key.to_sym)
          return [true,object.public_send(key.to_sym)]
        end
      end
      [false]
    end
    def merge!(value)
      if value.is_a?(Hash)
        value.each{|k,v| self[k.to_s]=v}
      end
      if value.is_a?(MergeableHash)
        @_merged_objects+=value._merged_objects.dup
      else
        @_merged_objects<<value
      end

      # if object.is_a?(Hash)
      #   super(object)
      # else
      #   @_merged_objects<<object
      # end
    end
    def merge(object)
      result=self.dup
      result.merge!(object)
      result
    end

    protected
    def _merged_objects
      @_merged_objects
    end
  end
end
