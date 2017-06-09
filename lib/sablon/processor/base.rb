# -*- coding: utf-8 -*-
module Sablon
  module Processor
    class Base
      def initialize(xml_node)
        @xml_node = xml_node
        @errors=[]
      end

      def errors
        @errors
      end
    end
  end
end
