import time
import cv2
import mss
import numpy

with mss.mss() as sct:
    shared_file = open("shared.json", "r")
    
    try:
        shared_obj = json.loads(shared_file.read())
    except:
        monitor = {'top': 0, 'left': 0, 'width': 500, 'height': 500}
    last_time = int(round(time.time() * 1000))
    while 'Screen capturing':
        cur_time = int(round(time.time() * 1000))

        screen = sct.grab(monitor)
        # Get raw pixels from the screen, save it to a Numpy array
        img = numpy.array(screen)

        # Display the picture
        cv2.imshow('OpenCV/Numpy normal', img)

        if cur_time - last_time > 20:
          print(last_time)
          last_time = cur_time
          cv2.imwrite("./frames/" + str(last_time) + ".png", img)

        # Display the picture in grayscale
        # cv2.imshow('OpenCV/Numpy grayscale',
        # cv2.cvtColor(img, cv2.COLOR_BGRA2GRAY))

        # Press "q" to quit
        if cv2.waitKey(25) & 0xFF == ord('q'):
            cv2.destroyAllWindows()
            break