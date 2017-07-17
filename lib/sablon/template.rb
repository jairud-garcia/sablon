module Sablon
  class Template
    def initialize(path)
      @path = path
    end

    def errors
      @errors||[]
    end

    # Same as +render_to_string+ but writes the processed template to +output_path+.
    def render_to_file(output_path, context, properties = {})
      File.open(output_path, 'wb') do |f|
        f.write render_to_string(context, properties)
      end
    end

    # Process the template. The +context+ hash will be available in the template.
    def render_to_string(context, properties = {})
      begin 
        render(context, properties).string
      ensure
        Sablon::Processor::Image.reset
      end
    end

    private

    def render(context, properties = {})
      env = Sablon::Environment.new(self, MergeableHash.new(context))
      Zip.sort_entries = true # required to process document.xml before numbering.xml
      Zip::OutputStream.write_buffer(StringIO.new) do |out|        
        files = Zip::File.open(@path)
        files.each do |entry|
          entry_name = entry.name
          out.put_next_entry(entry_name)
          content = entry.get_input_stream.read
          if entry_name == 'word/document.xml'
            out.write(process(Processor::Document, content, env, properties))
          elsif entry_name =~ /word\/header\d*\.xml/ || entry_name =~ /word\/footer\d*\.xml/
            out.write(process(Processor::Document, content, env))
          elsif entry_name == 'word/numbering.xml'
            out.write(process(Processor::Numbering, content, env))
            #out.write(process(Processor::Numbering, content, env))
          elsif entry_name == 'word/_rels/document.xml.rels'
            process(Processor::Image, content, properties, out)
          elsif entry_name == '[Content_Types].xml'
            out.write(process(Processor::ContentType, content, properties, out))
          else
            out.write(content)
          end
        end

        entry=files.detect{|file| file.name=='word/_rels/document.xml.rels'}
        out.put_next_entry(entry.name)
        content = entry.get_input_stream.read
        out.write(process(Processor::Image, content, properties, out))
        Sablon::Processor::Image.add_images_to_zip!(context, out)
      end
    end


    # process the sablon xml template with the given +context+.
    #
    # IMPORTANT: Open Office does not ignore whitespace around tags.
    # We need to render the xml without indent and whitespace.
    def process(processor, content, *args)
      document = Nokogiri::XML(content)
      processor_instance=processor.new(document)
      begin 
        xml_document=processor_instance.process(*args).to_xml(indent: 0, save_with: 0)
      ensure
        @errors=processor_instance.errors
      end
      xml_document
    end
  end
end
