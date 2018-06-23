require 'yaml'

# Reader reads a configuration with a given name.
# Configuration is read in following order, first match is returned
# 1. Environment variable
# 2. Property File
class Reader
    class << self

        # If the given +name+ exists as environment variable it will returned 
        # otherwise it tries to find the given +name+ as property in the sceret files
        # described in +SECRET_FILE_PATH+ environment variable. 
        def read(name)
            str = name.to_s
            env?(str) ? ENV[str] : properties[str]            
        end

        priavte

        # If the given +key+ exists as environment variable it will returned
        def env(key)       
            str = name.to_s     
            env?(str) && ENV[str]
        end

        # Check if the given +key+ exists as environment variable.
        def env?(key)
            blank?(ENV[key])
        end    

        # Check if the given +value+ is not empty.
        def blank?(value)
            value.nil? == false && value.empty? == false
        end

        # Returns a hash contains all loaded secret properties
        def properties
            @properties ||= load_files
        end

        # Loads the given +file+ as yaml file and puts the values into the given +hash+
        def load_file( file, hash = {})
            hash.merge!( YAML.load_file(file) )
        end
        
        def load_files( hash = {} )
            files.inject(hash){|h,file|load_file(file,h)}
        end

        def files
            locations.inject([]) do |ary,loc| 
                ary << File.file?( loc )
                ary.concat( Dir[ File.join(loc,'**/*.yml') ] )
                ary
            end
        end

        def locations        
            if path = env( :SECRET_FILE_PATH )
                path.split(':')
            else
                [ '/run/secrets/secret' ]
            end        
        end

    end # class << self
end # Reader
