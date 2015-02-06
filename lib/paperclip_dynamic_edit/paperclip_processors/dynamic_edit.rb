module Paperclip
  # Applies database stored transformations
  class DynamicEdit < Paperclip::Processor
    def initialize file, options = {}, attachment = nil
      super
      @format = File.extname(@file.path)
      @basename = File.basename(@file.path, @format)
    end

    def dynamic_edit_transformations
      self.attachment.instance.send("#{self.attachment.name}_dynamic_edit") || []
    end

    def format_transformations
      self.dynamic_edit_transformations.map{|x|"#{x}"}.join(' ')
    end

    def make(*args)
      return @file unless dynamic_edit_transformations.present?

      dst = Tempfile.new([@basename,@format])
      dst.binmode

      parameters = ":source #{format_transformations} :dest"
      Paperclip.run('convert', parameters, :source => File.expand_path(@file.path), :dest => File.expand_path(dst.path))

      dst
    end
  end
end