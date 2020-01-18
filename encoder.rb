file_name = "./poster.jpg"

byteArray = File.binread(file_name)

unpacked = byteArray.unpack("H*")
text = unpacked[0]


File.open("output.jpg", 'wb' ) do |output|
  output << unpacked.pack("H*")
end