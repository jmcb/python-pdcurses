#!/usr/bin/env
"""
A rather hack-y script for supporting pip.
"""

import os, shutil

class SetupError (Exception): pass

def main ():
    template = open("setup.py_template").read()
    template = template.replace("PDCURSES_FLAV", "")
    fn = open("setup2.py", "w")
    fn.write(template)
    fn.close()

    if not os.path.exists("pdcurses.dll"):
        raise SetupError, "Cannot find a pdcurses.dll file. Please provide one."

    shutil.copyfile("gen/pdcurses.def", "pdcurses.def")
    shutil.copyfile("gen/pdcurses.lib", "pdcurses.lib")

    import setup2
    setup2.main()

    os.unlink("setup2.py")


if __name__=="__main__":
    main()
