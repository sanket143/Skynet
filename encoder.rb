require 'rqrcode'
require 'rmagick'
include Magick

file_name = "./poster.jpg"

byteArray = File.binread(file_name)

unpacked = byteArray.unpack("H*")
text = unpacked[0]


def getImage(text)

  qrcode = RQRCode::QRCode.new(text)
  png = qrcode.as_png(
    bit_depth: 1,
    border_modules: 2,
    color_mode: ChunkyPNG::COLOR_GRAYSCALE,
    color: "black",
    file: nil,
    fill: 'white',
    module_px_size: 6,
    resize_exactly_to: true,
    resize_gte_to: true,
    size: 300
  )

  img = Image.from_blob(png.to_s)
  img[0].display
end

getImage("Sanket")

File.open("output.jpg", 'wb' ) do |output|
  output << unpacked.pack("H*")
end