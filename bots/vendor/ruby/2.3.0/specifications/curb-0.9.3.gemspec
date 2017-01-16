# -*- encoding: utf-8 -*-
# stub: curb 0.9.3 ruby lib ext
# stub: ext/extconf.rb

Gem::Specification.new do |s|
  s.name = "curb".freeze
  s.version = "0.9.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze, "ext".freeze]
  s.authors = ["Ross Bamford".freeze, "Todd A. Fisher".freeze]
  s.date = "2016-04-11"
  s.description = "Curb (probably CUrl-RuBy or something) provides Ruby-language bindings for the libcurl(3), a fully-featured client-side URL transfer library. cURL and libcurl live at http://curl.haxx.se/".freeze
  s.email = "todd.fisher@gmail.com".freeze
  s.extensions = ["ext/extconf.rb".freeze]
  s.extra_rdoc_files = ["LICENSE".freeze, "README.markdown".freeze]
  s.files = ["LICENSE".freeze, "README.markdown".freeze, "ext/extconf.rb".freeze]
  s.homepage = "http://curb.rubyforge.org/".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.markdown".freeze]
  s.rubyforge_project = "curb".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Ruby libcurl bindings".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version
end
