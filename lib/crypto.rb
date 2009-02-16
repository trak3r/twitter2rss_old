# http://blog.leetsoft.com/2006/03/14/simple-encryption
# http://blog.leetsoft.com/files/crypto-key.rb.txt
require 'openssl'

module Crypto

  def self.create_keys(priv = "rsa_key", pub = "#{priv}.pub", bits = 512)
    if File.exists?(priv) && File.exists?(pub)
      # don't regenerate the keys every time
    else
      private_key = OpenSSL::PKey::RSA.new(bits)
      File.open(priv, "w+") { |fp| fp << private_key.to_s }
      File.open(pub,  "w+") { |fp| fp << private_key.public_key.to_s }
      private_key
    end
  end

  class Key
    def initialize(data)
      @public = (data =~ /^-----BEGIN (RSA|DSA) PRIVATE KEY-----$/).nil?
      @key = OpenSSL::PKey::RSA.new(data)
    end

    def self.from_file(filename)
      self.new File.read( filename )
    end

    def encrypt(text)
      encode(@key.send("#{key_type}_encrypt", text))
    end

    def decrypt(text)
      @key.send("#{key_type}_decrypt", decode(text))
    end

    def strip(text)
      text.gsub(/\r/, '').gsub(/\n/, '')
    end

    def encode(plain)
      # http://www.fepus.net/ruby1line.txt
      CGI.escape(strip(Base64.encode64(plain)))
    end

    def decode(encoded)
      Base64.decode64(CGI.unescape(encoded))
    end

    def private?
      !@public
    end

    def public?
      @public
    end

    def key_type
      @public ? :public : :private
    end
  end
end