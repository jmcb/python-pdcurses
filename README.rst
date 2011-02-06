***************
python-pdcurses
***************
**Using pdcurses as a drop-in replacement for _curses on non-POSIX platforms.**

General information
===================

Currently, the state of Python 2.x builds, for Windows specifically, is that the
``_curses`` base module is not available. On all platforms, the ``curses``
wrapper module that sits on top of this is available. Obviously the former not
being included is due to the fact that curses support is limited to platforms
that provide curses implementations -- usually only POSIX compatible platforms.

The latter always being included would imply that the intent is to allow access
to this module agnostically, whenever a Python-compatible ``_curses`` module is
available.

Thus, the aim of this module is to provide a drop-in replacement for ``_curses``
using the `PDCurses`_ library. This module should hopefully work for all Python
versions from 2.3 through 2.7.

Module information
==================

Credit for this module is as follows:

1. The `PDCurses`_ project. Without it, this module would not be possible. 
2. `Jérôme Berger`_'s `binary package`_ for Python 2.6 (linked to on `Issue
   2889`_ of the Python bug tracker), which combined the Python ``_curses``
   source code with the ``PDCurses`` headers.
3. Secondarily, the `PDCurses-win32a`_ extension on ``PDCurses``, which provides
   a drop-in replacement for the ``pdcurses.dll`` file and works by creating a
   window and doing direct drawing.

Indeed, it is the intent of this module to bring together all of the above
factors, plus a few minor modifications, in order to make the process of
building a ``_curses`` compatible module a simple task.

There are a variety of patches sitting on the Python bug tracking queue (ie,
`Issue 2889`_) relating to bringing ``PDCurses`` to Python, and thus Windows
support to curses: this module does none of these things, and does not require
modification of the Python source tree in any way.

It would be great if ``PDCurses`` could come to Python, but more experience
hackers than I would appear to have attempted to do this, and failed.

Support and Documentation
=========================

Support for ``PDCurses`` itself can be found on the `PDCurses`_ website, and on
the (low-traffic) `PDCurses mailing list`_.

Support for ``PDCurses-win32a`` can be found on the `PDCurses-win32a` website,
or by contacting the maintainer of the module using the email address found on
the website.

Documentation for each of these is available on the relevant web site, though
you may have to dig quite deeply in order to find it.

Support and documentation for this module (``python-pdcurses`` specifically) can
be found either in this file, or in other files in this project (see
`python-pdcurses`_ on GitHub). If none of these answers your questions, feel
free to open an issue on the `python-pdcurses Issue tracker`_.

For installation, please see the `Installation`_ section of this document.

Installation
============

(More to come.)

.. Links
.. =====

.. _`PDCurses`: http://pdcurses.sourceforge.net

.. _`Jérôme Berger`: http://jeberger.free.fr

.. _`Issue 2889`: http://bugs.python.org/issue2889

.. _`binary package`: http://jeberger.free.fr/python

.. _`PDCurses-win32a`: http://www.projectpluto.com/win32a.htm

.. _`PDCurses mailing list`: http://www.mail-archive.com/pdcurses-l@lightlink.com/

.. _`python-pdcurses`: http://www.github.com/jmcb/python-pdcurses

.. _`python-pdcurses Issue tracker`: http://www.github.com/jmcb/python-pdcurses/issues
