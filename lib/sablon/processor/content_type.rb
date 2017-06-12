# -*- coding: utf-8 -*-
require 'sablon/processor/base'
module Sablon
  module Processor
    class ContentType < Base

      TYPES = {
        png: 'image/png',
        jpg: 'image/jpeg',
        jpeg: 'image/jpeg',
        gif: 'image/gif',
        bmp: 'image/bmp'
      }

      def process(properties, out)
        TYPES.each do |extension, content_type|
          unless ContentType.extensions(@xml_node).include?(extension.to_s)
            node = Nokogiri::XML::Node.new('Default', @xml_node)
            node['Extension'] = extension
            node['ContentType'] = content_type
            @xml_node.root << node
          end
        end

        @xml_node
      end

      private

      def self.extensions(doc)
        doc.root.children.map{ |child| child['Extension'] }.compact.uniq
      end
    end
  end
end
