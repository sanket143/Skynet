from pymouse import PyMouseEvent
import json
import os

filename = "shared.json"
shared_file = os.open(filename, os.O_RDWR | os.O_CREAT)

try:
  shared_obj = json.loads(os.read(shared_file, 10))
except:
  shared_obj = {}

class Clickonacci(PyMouseEvent):
    def __init__(self):
        print("Started Capturing Cursor...")
        PyMouseEvent.__init__(self)

    def click(self, x, y, button, press):
        if button == 1:
            if press:
                shared_obj["cursor"] = (x, y)
                os.ftruncate(shared_file, 0)
                os.lseek(shared_file, 0, os.SEEK_SET)

                os.write(shared_file, bytes(json.dumps(shared_obj), "utf-8"))

C = Clickonacci()
C.run()