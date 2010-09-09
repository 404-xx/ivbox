# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{everbox}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["why404"]
  s.date = %q{2010-09-09}
  s.description = %q{SDK written in Ruby for the EverBox(see http://www.everbox.com).}
  s.email = %q{why404@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "Gemfile",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "everbox.gemspec",
     "lib/everbox.rb",
     "lib/everbox/config.rb",
     "lib/everbox/device.rb",
     "lib/everbox/fs.rb",
     "lib/everbox/utils.rb",
     "lib/everbox/version.rb",
     "spec/everbox_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/why404/everbox}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{EverBox Ruby SDK}
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/everbox_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<rest-client>, [">= 1.6.1.a"])
      s.add_runtime_dependency(%q<json_pure>, [">= 1.4.6"])
      s.add_runtime_dependency(%q<mime-types>, [">= 1.16"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<rest-client>, [">= 1.6.1.a"])
      s.add_dependency(%q<json_pure>, [">= 1.4.6"])
      s.add_dependency(%q<mime-types>, [">= 1.16"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<rest-client>, [">= 1.6.1.a"])
    s.add_dependency(%q<json_pure>, [">= 1.4.6"])
    s.add_dependency(%q<mime-types>, [">= 1.16"])
  end
end

