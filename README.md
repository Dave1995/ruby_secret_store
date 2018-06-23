# SecretStore

Many secrets of a application, i.e. database credentials, are so far stored in environment variables.
In Docker environment reading those secrets from a file is preferred. 

SecretStore helps to combine both approaches. A secret with a given name is at first attempted to be read as
an environment variable. Only if not found it is read from a file with the fixed name __/run/secrets/secret__,
that contains simple pairs of keys and values and is expected to be delivered by the docker engine as a secret.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'secret_store'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install secret_store

## Usage

For instance read the database user :

SecretStore[ :PASSWORD ]

## Development

## Contributing
