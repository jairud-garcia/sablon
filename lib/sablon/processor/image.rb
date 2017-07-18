# The code of that class was inspired in "kubido Fork - https://github.com/kubido/"
# -*- coding: utf-8 -*-
require 'sablon/processor/base'
module Sablon
  module Processor
    class Image < Base
      @@_last_rel_id=nil
      PICTURE_NS_URI = 'http://schemas.openxmlformats.org/drawingml/2006/picture'
      MAIN_NS_URI = 'http://schemas.openxmlformats.org/drawingml/2006/main'
      RELATIONSHIPS_NS_URI = 'http://schemas.openxmlformats.org/package/2006/relationships'
      IMAGE_TYPE = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/image'

      def process(properties)
        self.manipulate
      end

      def self.add_image(image)
        self.images<<image
      end
      def self.images
        @@_images||=[]
      end
      def self.reset
        @@_images=[]
        @@images_rids=nil
        @@_last_rel_id=nil
      end
      def self.next_rel_id
        if @@_last_rel_id
          next_rel=@@_last_rel_id
          @@_last_rel_id+=1
          next_rel
        end
      end

      def manipulate
        next_id = next_rel_id
        @@images_rids = {}
        relationships = @xml_node.at_xpath('r:Relationships', r: RELATIONSHIPS_NS_URI)

        Sablon::Processor::Image.images.each do |image|
          image.rid||=next_id
          relationships.add_child("<Relationship Id='rId#{image.rid}' Type='#{IMAGE_TYPE}' Target='media/#{image.name}'/>")
          @@images_rids[image.name.match(/(.*)\.[^.]+$/)[1]] = image.rid
          next_id+=1
        end

        @xml_node
      end

      # def self.add_images_to_zip!(context, zip_out)
      #   (Sablon::Processor::Image.images).each do |image|
      #     zip_out.put_next_entry(File.join('word', 'media', image.name),nil,nil,::Zip::Entry::STORED)
      #     zip_out.write(image.data)
      #   end
      # end

      def self.add_images(context, tmp_dir)
        (Sablon::Processor::Image.images).each do |image|
          File.open(File.join(tmp_dir,'word', 'media',image.name),'wb') do |f|
            f.write(image.data)
          end
        end
      end

      def self.list_ids
        @@images_rids
      end

      

      private

      def next_rel_id
        @@_last_rel_id=@xml_node.xpath('r:Relationships/r:Relationship', 'r' => RELATIONSHIPS_NS_URI).inject(0) do |max ,n|
          id = n.attributes['Id'].to_s[3..-1].to_i
          [id, max].max
        end+1
      end
    end
  end
end
