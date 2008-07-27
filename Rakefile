require 'rubygems'
Gem::manage_gems
require 'rake/gempackagetask'
require 'spec/rake/spectask'

spec = Gem::Specification.new do |spec|
    spec.name = "buildr-rjbjetty"
    spec.version = "0.1"
    spec.author = "Ted Shin"
    spec.homepage = "http://anarcher.tistory.com/"
    spec.summary = "a jetty task that in buildr using rjb not java classes "
    spec.files  = FileList["lib/**/*","README","Rakefile"].collect
    spec.require_path = "lib"
    spec.has_rdoc = false

    spec.add_dependency "buildr" , ">= 1.2.5"
end

Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_tar = true
    pkg.need_zip = true
end
