module Paperclip
  # Applies database stored transformations
  class DynamicEdit < Paperclip::Processor
    def initialize file, options = {}, attachment = nil
      super
      @format = options[:format]
      @current_format = File.extname(@file.path)
      @basename = File.basename(@file.path, @current_format)
    end

    def dynamic_edit_transformations
      self.attachment.instance.send("#{self.attachment.name}_dynamic_edit") || []
    end

    def format_transformations
      self.dynamic_edit_transformations.map{|x|"#{x}"}.join(' ')
    end

    def make(*args)
      filename = [@basename, @format ? ".#{@format}" : ""].join
      dst = TempfileFactory.new.generate(filename)

      if dynamic_edit_transformations.present?
        parameters = ":source #{format_transformations} :dest"
        Paperclip.run('convert', parameters, :source => File.expand_path(@file.path), :dest => File.expand_path(dst.path))
      else
        FileUtils.cp(File.expand_path(@file.path), File.expand_path(dst.path))
      end

      dst
    end
  end
end