module Sablon
  class Image
    include Singleton
    attr_reader :definitions

    Definition = Struct.new(:name, :data, :rid) do
      def inspect
        "#<Image #{name}:#{rid}"
      end
    end

    def self.create_by_path(path, random = nil)
      image_name = "#{random || Random.new_seed}-#{File.extname(path)}"
      rid=Sablon::Processor::Image.next_rel_id
      instance=Sablon::Image::Definition.new(image_name, IO.binread(path),rid)
      Sablon::Processor::Image.add_image(instance)
      instance
    end
  end
end
