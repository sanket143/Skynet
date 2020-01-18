require 'base64'
require 'zlib'
require 'chunky_png'
require 'quirc'

def decodeQR(crypted_file)
  img = ChunkyPNG::Image.from_file(crypted_file)
  res = Quirc.decode(img).first
  return res.payload

end