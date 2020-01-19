import time
import cv2
import mss
import numpy
import json

with mss.mss() as sct:

    width = 500
    height = 500
    monitor = {'top': 0, 'left': 0, 'width': width, 'height': height}

    last_time = int(round(time.time() * 1000))
    while 'Screen capturing':
        cur_time = int(round(time.time() * 1000))
        shared_file = open("shared.json", "r")

        try:
            shared_obj = json.loads(shared_file.read())
        except:
            print("Using default")
            shared_obj = {"cursor": [200, 200]}

        shared_file.close()

        top = min(shared_obj["cursor"][1] - 200, 765 - width)
        left = min(shared_obj["cursor"][0] - 200, 1365 - height)

        monitor = {
            'top': top if top >= 0 else 0,
            'left': left if left >= 0 else 0,
            'width': width,
            'height': height
        }

        screen = sct.grab(monitor)
        
        # Get raw pixels from the screen, save it to a Numpy array
        img = numpy.array(screen)

        # Display the picture
        cv2.imshow('OpenCV/Numpy normal', img)

        if cur_time - last_time > 20:
          last_time = cur_time
          cv2.imwrite("./exframes/" + str(last_time) + ".png", img)

        if cv2.waitKey(25) & 0xFF == ord('q'):
            cv2.destroyAllWindows()
            break