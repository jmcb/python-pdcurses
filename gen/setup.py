#!/usr/bin/env python
"""
python-pdcurses setup module.
"""

from distutils.core import setup, Extension
import os

def main ():
    setup (
        name = "pdcurses",
        version = "0.3.4",
        description = "PDCurses drop-in replacement for _curses.",
        author = "Jon McManus, PDCurses",
        author_email = "jonathan@acss.net.au",
        url = "http://www.github.com/jmcb/python-pdcurses",
        long_description = """""",
        classifiers = [
            'Development Status :: 5 - Production/Stable', # PDCurses is a stable replacement for _curses.
            'Environment :: Console',
            'Environment :: Console :: Curses',
            'Intended Audience :: Developers',
            'License :: Public Domain',
            'Operating System :: OS Independent',
            'Programming Language :: C',
            'Programming Language :: Python',
            'Programming Language :: Python : 2.3',
            'Programming Language :: Python : 2.4',
            'Programming Language :: Python : 2.5',
            'Programming Language :: Python : 2.6',
            'Programming Language :: Python : 2.7',
            'Topic :: Software Development :: Libraries :: Python Modules',
        ],
        ext_modules = [Extension ('_curses',
                          sources = ['_curses_panel.c', '_cursesmodule.c'],
                          define_macros = [("WINDOW_HAS_FLAGS", None)],
                          libraries = ["pdcurses"])],
        data_files = [(".", ["pdcurses.dll"])],
        )

if __name__=="__main__":
    main()
