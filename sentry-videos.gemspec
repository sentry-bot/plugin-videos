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

  gem.add_dependency "cinch", "~> 2.0"
  gem.add_dependency "video_info", "~> 2.5"
  gem.add_dependency "chronic", "~> 0.10"
  gem.add_dependency "chronic_duration", "~> 0.10"
  gem.add_dependency "twitter-text", "~> 1.13"
  gem.add_dependency "sentry-helper", "~> 0.1.0"
end
