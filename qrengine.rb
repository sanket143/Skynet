require 'base64'
require 'zlib'
require 'quirc'

def decodeQR(crypt)
  encoded = <<~EOD
    #{crypt}
  EOD

  img = Zlib::Inflate.inflate(Base64.decode64(encoded))
  res = Quirc.decode(img, 120, 120).first
  return res.payload

end

puts decodeQR("eJzt0kEOwyAMRNHe/9LpFo1mwK1IYqQ/mwQDfl5wXYQQQgghT+cziZ7Tb+Ue
7vvurL76Vvvhvuvqu0jvqHoP9wx3dh73fHdWxz3Hrc5TvYfbx01RP83j7uH2
cCtzuf+7g7uvr74ZrY9r967cedxebrrjZtK9tMbt4Y7+L/V/Tdzn3DRH+td5
0hq3h5veR+qjNTcPbh+3Mpd7Qzt6497vat+Voe9Oa7j93GpdrXGt+7i9XO3j
+jknzYB7huvmGM+7GXHPcWeOM3B7upV5Rlvvun3cHm6K+qt5qibucy4hhBBC
yN58AXWDGDc=")