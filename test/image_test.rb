# -*- coding: utf-8 -*-
require "test_helper"
require "support/xml_snippets"

class SablonImageTest < Sablon::TestCase
  include Sablon::Test::Assertions

  def setup
    super
    Sablon::Processor::Image.reset
    @base_path = Pathname.new(File.expand_path("../", __FILE__))

    @template_path = @base_path + "fixtures/image_template.docx"
    @sample_path = @base_path + "fixtures/image_sample.docx"
  end

  def test_generate_document_from_template_with_images
    @images = [
      Sablon::Image.create_by_path(@base_path + "fixtures/images/c-3po.jpg", 1),
      Sablon::Image.create_by_path(@base_path + "fixtures/images/r2-d2.png", 2)
    ]
    output_path = @base_path + "sandbox/images.docx"
    template = Sablon.template @template_path
    context = {
      "items"=> [
        {
          title: "C-3PO",
          image: @images[0]
        },
        {
          title: "R2-D2",
          image: @images[1]
        }
      ]
    }

    template.render_to_file output_path, context

    assert_docx_equal @sample_path, output_path
  end

  # def test_generate_document_from_template_with_lazy_loaded_images
  #   output_path = @base_path + "sandbox/images.docx"
  #   template = Sablon.template @template_path
  #   context = {
  #     "items"=> [
  #       OpenStruct.new(title: "C-3PO"),
  #       OpenStruct.new(title: "R2-D2")]
  #   }
  #   item=context['items'][0]
  #   def item.image 
  #      Sablon::Image.create_by_path(Pathname.new(File.expand_path("../", __FILE__)) + "fixtures/images/c-3po.jpg", 1)
  #   end
  #   item=context['items'][1]
  #   def item.image 
  #      Sablon::Image.create_by_path(Pathname.new(File.expand_path("../", __FILE__)) + "fixtures/images/r2-d2.png", 2)
  #   end

  #   template.render_to_file output_path, context

  #   assert_docx_equal @sample_path, output_path
  # end

  # def test_generate_document_null_images

  #   output_path = @base_path + "sandbox/images.docx"
  #   template = Sablon.template @template_path
  #   context = {
  #     "items"=> [
  #       {
  #         title: "C-3PO",
  #         image: nil
  #       },
  #       {
  #         title: "R2-D2",
  #         image: nil
  #       }
  #     ]
  #   }
  #   template.render_to_file output_path, context
  #   sample_path = @base_path + "fixtures/null_image_sample.docx"
  #   assert_docx_equal sample_path, output_path
  # end
end
