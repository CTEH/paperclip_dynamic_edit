require 'paperclip/attachment'

Paperclip::Attachment.class_eval do
  def dynamic_edit_set(v) instance.send(:dynamic_edit_set, name, v) end
  def dynamic_edit() instance.send(:dynamic_edit, name) end
  def dynamic_edit_append(transformation) instance.send(:dynamic_edit_append, name, transformation) end
  def dynamic_edit_undo() instance.send(:dynamic_edit_undo, name) end
  def dynamic_edit_undo!() instance.send(:dynamic_edit_undo!, name) end
  def dynamic_edit_revert() instance.send(:dynamic_edit_revert, name) end
  def dynamic_edit_revert!() instance.send(:dynamic_edit_revert!, name) end
  def convert_options_for() instance.send(:convert_options_for, name) end
  def dynamic_edit_rotate(degrees) instance.send(:dynamic_edit_rotate, name, degrees) end
  def dynamic_edit_rotate!(degrees) instance.send(:dynamic_edit_rotate!, name, degrees) end
  def dynamic_edit_rotate_right!() instance.send(:dynamic_edit_rotate_right!, name) end
  def dynamic_edit_rotate_left!() instance.send(:dynamic_edit_rotate_left!, name) end
  def dynamic_edit_rotate_180!() instance.send(:dynamic_edit_rotate_180!, name) end
end
