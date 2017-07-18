require 'fileutils'
require 'tempfile'

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
      # File.open(output_path, 'wb') do |f|
      #   f.write render_to_string(context, properties)
      # end
      begin 
        render(context, properties,output_path)
      ensure
        Sablon::Processor::Image.reset
      end
    end

    def render_to_string(context, properties = {})
      tmp_file=Tempfile.new('tmp.docx')
      render_to_file(tmp_file.path, context, properties)
      File.open(tmp_file,'r').read
    end

    private

    def render(context, properties = {},output_path)
      tmp_dir=Dir.mktmpdir
      env = Sablon::Environment.new(self, MergeableHash.new(context))
      Zip.sort_entries = true # required to process document.xml before numbering.xml
      files = Zip::File.open(@path)
      files.each do |entry|
        entry_name = entry.name
        content = entry.get_input_stream.read
        if entry_name == 'word/document.xml'
          write_plain_file(tmp_dir,entry_name,process(Processor::Document, content, env, properties))
        elsif entry_name =~ /word\/header\d*\.xml/ || entry_name =~ /word\/footer\d*\.xml/
          write_plain_file(tmp_dir,entry_name,process(Processor::Document, content, env))
        elsif entry_name == 'word/numbering.xml'
          write_plain_file(tmp_dir,entry_name,process(Processor::Numbering, content, env))
        elsif entry_name == 'word/_rels/document.xml.rels'
          process(Processor::Image, content, properties)
        elsif entry_name == '[Content_Types].xml'
          write_plain_file(tmp_dir,entry_name,process(Processor::ContentType, content, properties))
        else
          write_plain_file(tmp_dir,entry_name,content)
        end
      end
      entry=files.detect{|file| file.name=='word/_rels/document.xml.rels'}
      content = entry.get_input_stream.read
      write_plain_file(tmp_dir,entry.name,process(Processor::Image, content, properties))
      Sablon::Processor::Image.add_images(context, tmp_dir)
      zip_content(tmp_dir,output_path)
    end

    def zip_content(tmp_dir,output_path)
      File.delete(output_path) if File.exists?(output_path)
      `(cd #{tmp_dir} ; zip -r -D  #{output_path} .)`
    end

    #Writes the file in a tmp directory 
    def write_plain_file(tmp_dir, file, content)
      filepath=File.join(tmp_dir,file)
      FileUtils.mkdir_p(File.dirname(filepath))
      File.open(filepath,'wb') do |f|
        f.write(content)
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
