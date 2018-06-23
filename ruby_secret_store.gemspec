lib = File.join( __dir__, 'lib' )
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "secret_store/version"

Gem::Specification.new do |spec|
  spec.name          = 'ruby_secret_store'
  spec.version       = SecretStore::VERSION
  spec.authors       = [ 'Thomas Manig', 'David Erler', 'Andre Kullmann' ]
  spec.email         = [ 'thomas.manig(at)ottogroup.com' ]

  spec.summary       = 'Read Secrets for Configuration from ENV and File'
  spec.description   = 'Read Secrets for Configuration from ENV and File'
  spec.homepage      = ''

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
