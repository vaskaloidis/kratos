
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kratos/version"

Gem::Specification.new do |spec|
  spec.name          = "kratos"
  spec.license       = "MIT"
  spec.version       = Kratos::VERSION
  spec.authors       = ["vaskaloidis"]
  spec.email         = ["vas.kaloidis@gmail.com"]

  spec.summary       = "Pentest framework"
  spec.description   = "Pentest framework"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/kratos/extconf.rb"]

  spec.add_dependency "tty-color", "~> 0.4.2"
  spec.add_dependency "tty-command", "~> 0.8.0"
  spec.add_dependency "tty-config", "~> 0.2.0"
  spec.add_dependency "tty-cursor", "~> 0.5.0"
  spec.add_dependency "tty-editor", "~> 0.4.0"
  spec.add_dependency "tty-file", "~> 0.6.0"
  spec.add_dependency "tty-font", "~> 0.2.0"
  spec.add_dependency "tty-markdown", "~> 0.4.0"
  spec.add_dependency "tty-pager", "~> 0.11.0"
  spec.add_dependency "tty-platform", "~> 0.1.0"
  spec.add_dependency "tty-progressbar", "~> 0.15.0"
  spec.add_dependency "tty-prompt", "~> 0.16.1"
  spec.add_dependency "tty-screen", "~> 0.6.4"
  spec.add_dependency "tty-spinner", "~> 0.8.0"
  spec.add_dependency "tty-table", "~> 0.10.0"
  spec.add_dependency "tty-tree", "~> 0.1.0"
  spec.add_dependency "tty-which", "~> 0.3.0"
  spec.add_dependency "pastel", "~> 0.7.2"
  spec.add_dependency "thor", "~> 0.20.0"

  spec.add_dependency "proxymachine"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "rspec", "~> 3.0"
end
