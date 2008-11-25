Gem::Specification.new do |s|
  s.name = %q{multibyte}
  s.version = "0.0.1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Aimonetti"]
  s.date = %q{2008-05-28}
  s.description = %q{Multibyte support for Ruby}
  s.email = ["mattaimonetti@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "website/index.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "Rakefile", "config/hoe.rb", "config/requirements.rb", "lib/multibyte.rb", "lib/multibyte/chars.rb", "lib/multibyte/generators/generate_tables.rb", "lib/multibyte/handlers/passthru_handler.rb", "lib/multibyte/handlers/utf8_handler.rb", "lib/multibyte/handlers/utf8_handler_proc.rb", "lib/multibyte/version.rb", "lib/unicode.rb", "log/debug.log", "script/destroy", "script/generate", "script/txt2html", "setup.rb", "spec/multibyte_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/deployment.rake", "tasks/environment.rake", "tasks/rspec.rake", "tasks/website.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://multibyte.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{multibyte}
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{Multibyte support for Ruby}
end