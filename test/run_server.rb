require 'rubygems'
gem 'buildr'
require 'rjbjetty'

repositories.remote << "http://www.ibiblio.org/maven/"
repositories.remote << "http://repo1.maven.org/maven2/"

rjbJetty = Buildr::RjbJetty.new
rjbJetty.start
