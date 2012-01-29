Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.2'
  s.required_rubygems_version = ">= 1.3.6"

  s.name        = "benchmark_ext"
  s.summary     = "Benchmark everything, just faster!"
  s.description = "Native implementation of Benchmark with much better performance."
  s.version     = '0.2.0'

  s.authors     = ["Dimitrij Denissenko"]
  s.email       = "dimitrij@blacksquaremedia.com"
  s.homepage    = "https://github.com/bsm/benchmark_ext"

  s.require_path = 'lib'
  s.files        = Dir['ext/**/*']
  s.extensions  << 'ext/benchmark_ext/extconf.rb'

  s.add_development_dependency "rake"
  s.add_development_dependency "rake-compiler"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec"
end
