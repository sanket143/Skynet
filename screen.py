import ctypes
import time
import pyautogui

class DetectClick:
    def detectClick(button, watchtime = 5):
        '''Waits watchtime seconds. Returns True on click, False otherwise'''
        if button in (1, '1', 'l', 'L', 'left', 'Left', 'LEFT'):
            bnum = 0x01
        elif button in (2, '2', 'r', 'R', 'right', 'Right', 'RIGHT'):
            bnum = 0x02

        start = time.time()
        while 1:
            if ctypes.windll.user32.GetKeyState(0x01) > 1:
                # ^ this returns either 0 or 1 when button is not being held down
                print(pyautogui.position())
            if ctypes.windll.user32.GetKeyState(0x02) > 2:
                return False


if __name__ == "__main__":
    d = DetectClick()
    print(d.detectClick("left"))
