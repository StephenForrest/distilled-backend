require 'jwt'

rsa_private = OpenSSL::PKey::RSA.generate 2048
rsa_public = rsa_private.public_key

paragonToken = JWT.encode payload, rsa_private, 'RS256'

puts paragonToken

decoded_token = JWT.decode paragonToken, rsa_public, true, { algorithm: 'RS256' }

puts decoded_token