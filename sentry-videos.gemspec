# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "sentry-videos"
  gem.version       = File.new("VERSION", 'r').read.chomp
  gem.summary       = %q{Parses messages for videos links and replies with information about the video}
  gem.license       = "MIT"
  gem.authors       = ["jRiddick"]
  gem.email         = "apersson.93@gmail.com"
  gem.homepage      = "https://rubygems.org/gems/sentry-videos"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'

  gem.add_dependency "cinch"
  gem.add_dependency "video_info"
  gem.add_dependency "chronic"
  gem.add_dependency "chronic_duration"
  gem.add_dependency "twitter-text"
  gem.add_dependency "sentry-helper"
end
