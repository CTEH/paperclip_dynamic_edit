$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "paperclip_dynamic_edit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "paperclip_dynamic_edit"
  s.version     = PaperclipDynamicEdit::VERSION
  s.authors     = ["Jeff Fendley"]
  s.email       = ["jeff.fendley@gmail.com"]
  s.summary     = "Paperclip processor that allows user-specified rotation (or any Image Magick edit) to be stored and applied to styles."
  s.description = "Paperclip processor that allows user-specified rotation (or any Image Magick edit) to be stored and applied to styles."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]


  s.add_dependency "rails", "> 3.1.2"
  s.add_dependency "paperclip", "> 3.5.0"
end
