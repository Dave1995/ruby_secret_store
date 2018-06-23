require 'secret_store/version'
require 'secret_store/reader'


module SecretStore

  module_function

  def [](key)
    SecretStore::Reader.read(key)
  end
  
end

