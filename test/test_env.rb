require 'minitest/autorun'
require 'fileutils'
require 'yaml' 
require 'secret_store'

class EnvTest < Minitest::Test

    def setup
        super
        SecretStore::Reader.send :reset
        @dir = Dir.mktmpdir
        @dir2 = nil
    end

    def teardown
        super
        FileUtils.rm_rf( @dir )
        FileUtils.rm_rf( @dir2 ) if @dir2
    end

    def test_use_directory_as_store
        file = File.join(@dir, 'test.yml' )
        File.open( file, 'w') {|f| f.write( { 'password' => 'andre' }.to_yaml ) }
        ENV['SECRET_STORE_PATH'] = @dir
        assert SecretStore['USER'] != nil
        assert_equal( 'andre', SecretStore[ :password ] )        
    end

    def test_use_file_as_store
        file = File.join(@dir, 'test.yml' )
        File.open( file, 'w') {|f| f.write( { 'password' => 'peter' }.to_yaml ) }
        ENV['SECRET_STORE_PATH'] = file
        assert SecretStore['USER'] != nil
        assert_equal( 'peter', SecretStore[ :password ] )        
    end

    def test_use_multible_directories_as_store
        file = File.join(@dir, 'test.yml' )
        File.open( file, 'w') {|f| f.write( { 'password' => 'peter' }.to_yaml ) }

        @dir2 = Dir.mktmpdir
        file2 = File.join(@dir2, 'test.yml' )
        File.open( file2, 'w') {|f| f.write( { 'user' => 'andre' }.to_yaml ) }
        ENV['SECRET_STORE_PATH'] = "#{file}:#{file2}"

        assert_equal( 'peter', SecretStore[ :password ] )        
        assert_equal( 'andre', SecretStore[ :user ] )                    
    end

end