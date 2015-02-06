module DynamicEditable
  extend ActiveSupport::Concern

  module ClassMethods
    def make_editable(field)
      send(:serialize, "#{field}_dynamic_edit".to_sym)
    end
  end

  def dynamic_edit_set(field,v)
    self.send("#{field}_dynamic_edit=",v)
  end

  def dynamic_edit(field)
    v = self.send("#{field}_dynamic_edit")

    if v
      unless v.is_a? Array
        raise "DynamicEdit expects #{field}_dynamic_edit to be serializable and be an Array.  #{v.class} found instead."
      end
      v
    else
      []
    end
  end

  def dynamic_edit_append(field, transformation)
    dynamic_edit_set(field, dynamic_edit(field).append(transformation))
  end

  def dynamic_edit_undo(field)
    current = dynamic_edit(field)
    current.slice!(-1) if current.present?
  end

  def dynamic_edit_undo!(field)
    dynamic_edit_undo(field)
    self.save
    self.send(field).reprocess!
  end

  def dynamic_edit_revert(field)
    dynamic_edit_set(field, nil)
  end

  def dynamic_edit_revert!(field)
    dynamic_edit_revert(field)
    self.save
    self.send(field).reprocess!
  end

  def convert_options_for(field)
    self.dynamic_edit(field).map {|x|" \\(#{x}\\) "}
  end

  def dynamic_edit_rotate(field, degrees)
    raise ArgumentError.new("Valid rotations are 90, 180, or 270") unless [90,180,270].include?(degrees.to_i)
    dynamic_edit_append(field, "-rotate #{degrees}")
  end

  def dynamic_edit_rotate!(field, degrees)
    dynamic_edit_rotate(field, degrees)
    self.save
    self.send(field).reprocess!
  end

  def dynamic_edit_rotate_right!(field)
    dynamic_edit_append(field, "-rotate 90")
    self.save
    self.send(field).reprocess!
  end

  def dynamic_edit_rotate_left!(field)
    dynamic_edit_append(field, "-rotate 270")
    self.save
    self.send(field).reprocess!
  end

  def dynamic_edit_rotate_180!(field)
    dynamic_edit_append(field, "-rotate 180")
    self.save
    self.send(field).reprocess!
  end
end

if defined? ActiveRecord::Base
  ActiveRecord::Base.class_eval do
    include DynamicEditable
  end
end
