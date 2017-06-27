module Sablon
  class MergeableHash < Hash
    def initialize(value={})
      @_merged_objects=[]
      if value.is_a?(Hash)
        value.each{|k,v| self[k]=v}
      else
        @_merged_objects<<value
      end
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
    def merge!(object)
      if object.is_a?(Hash)
        super(object)
      else
        @_merged_objects<<object
      end
    end
    def merge(object)
      result=self.dup
      result.merge!(object)
      result
    end
  end
end
