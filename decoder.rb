require 'rqrcode'
require 'rmagick'
require 'qrio'
require './qrengine'

include Qrio
include Magick

captured_file = "./tmp/00000000-126.png"
images_obj = Image.read(captured_file).first

$img_width = images_obj.columns
$img_height = images_obj.rows

# New BW QR Codes
img1 = Image.new($img_width, $img_height){ self.background_color = "white" }

img2 = Image.new($img_width, $img_height){ self.background_color = "white" }

img3 = Image.new($img_width, $img_height){ self.background_color = "white" }

# Pixel Arrays
no_of_pixels = $img_width * $img_height
$pixels1 = img1.get_pixels(0, 0, $img_width, $img_height)
$pixels2 = img2.get_pixels(0, 0, $img_width, $img_height)
$pixels3 = img3.get_pixels(0, 0, $img_width, $img_height)
orig_pixels = images_obj.get_pixels(0, 0, $img_width, $img_height)

for i in 0..(no_of_pixels - 1)
  red = orig_pixels[i].red
  green = orig_pixels[i].green
  blue = orig_pixels[i].blue

  if orig_pixels[i].to_color == "black"
    $pixels1[i].red = 0
    $pixels1[i].green = 0
    $pixels1[i].blue = 0
    
    $pixels2[i].red = 0
    $pixels2[i].green = 0
    $pixels2[i].blue = 0

    $pixels3[i].red = 0
    $pixels3[i].green = 0
    $pixels3[i].blue = 0
  
  elsif orig_pixels[i].to_color != "white"
    if orig_pixels[i].red > 32767
      $pixels1[i].red = 0
      $pixels1[i].green = 0
      $pixels1[i].blue = 0
    end
    if orig_pixels[i].green > 32767
      $pixels2[i].red = 0
      $pixels2[i].green = 0
      $pixels2[i].blue = 0
    end
    if orig_pixels[i].blue > 32767
      $pixels3[i].red = 0
      $pixels3[i].green = 0
      $pixels3[i].blue = 0
    end
  end
end

img1.store_pixels(0, 0, $img_width, $img_height, $pixels1)
img2.store_pixels(0, 0, $img_width, $img_height, $pixels2)
img3.store_pixels(0, 0, $img_width, $img_height, $pixels3)

img1.write("exframes/01.png")
img2.write("exframes/02.png")
img3.write("exframes/03.png")

text1 = decodeQR("exframes/01.png")
text2 = decodeQR("exframes/02.png")
text3 = decodeQR("exframes/03.png")

text = text1 + text2 + text3
puts text