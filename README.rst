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

From-source installation
========================

There are two specific flavours of python-pdcurses that can be installed. These
are divided into "pdcurses" and "pdcurses-win32a". Please see the relevant
subheading for specific instructions, or the Common subheading for common
installation.

Currently, only building on Windows is supported. Hopefully this section can be
easily extended to cover building on other platforms.

If you are installing from a clone of the git repository, follow the
instructions under ``From git``. Otherwise, follow the instructions under
``From source``.

From git
^^^^^^^^

pdcurses
--------

To build the original pdcurses flavour, you'll need a copy of pdcurses.dll. You
can get this from the `PDCurses`_ website (or directly: `pdcurses.dll`_; the
hash for this file on my system is ``8df023b6765b21cdf937a25d9d8f14e2.``).

pdcurses-win32a
---------------

To build the win32a version, you'll need a copy of pdcurses.dll -- the specific
drop-in replacement for the original pdcurses.dll file. You can find this on the
`PDCurses-win32a`_ website (or directly: `pdcurses.dll (win32a)`_; the hash for
this file on my system is ``a4bda187a318154bf943672a5cb7a5dd``).

Common
------

On Windows, the simplest build environment to set up is one involving the
`MinGW32`_ compiler. As there are a variety of good instructions for setting
this up, I recommend reading `boodebr.org's Tutorial`_ and following the
instructions there.

Once you have MinGW32 installed, ensure that it's binary directory is included
in your PATH variable (On Windows, this can be found by right-clicking on ``My
Computer`` -> ``Properties`` -> ``Advanced`` -> ``Environment Variables`` and
adding the path to your installation; for default installations this may be
``C:\MingW32\bin``); also ensure that your Python installation is found in the
same variable (for default installations of Python, this is likely
``C:\PythonXX\``).

In my experience, it is necessary to do compilation directly via Window's
``cmd.exe`` prompt, over any instance of msysgit, git bash, Cygwin, etc; these
latter provide a variety of libraries that can cause clashes with MinGW32.

However, using one of these suites with access to ``make``, ``sed`` and a
variety of other programs will make the experience a lot easier.

Automatic
+++++++++

Inside your shell (with access to ``make``, etc)::
    
    make dirs

This should generate two subfolders: ``pdcurses`` and ``pdcurses-win32a``. If
you are only building a specific target, place the relevant pdcurses.dll file in
that target directory. If you are building both targets, place the relevant
pdcurses.dll file in the relevant directories.

Now run::

    make all
    OR (for plain pdcurses only)
    make all-pd-only
    OR (for win32a pdcurses only)
    make all-w32-only

Manual
++++++

You can duplicate the above effects if you do not have a system with ``make``,
etc, by creating the directories ``pdcurses`` and ``pdcurses-win32a`` yourself.
You'll need to copy and rename the following files::

    gen/setup-win32a.py      -> pdcurses-win32a/setup.py
    gen/pdcurses-win32a.def  -> pdcurses-win32a/pdcurses.def
    gen/pdcurses-win32a.lib  -> pdcurses-win32a/pdcurses.lib
    MANIFEST.in              -> pdcurses-win32a/MANIFEST.in
    *.h                      -> pdcurses-win32a/*.h
    *.c                      -> pdcurses-win32a/*.c
    gen/setup.py             -> pdcurses/setup.py
    gen/pdcurses.def         -> pdcurses/pdcurses.def
    gen/pdcurses.lib         -> pdcurses/pdcurses.lib
    MANIFEST.in              -> pdcurses/MANIFEST.in
    *.h                      -> pdcurses/*.h
    *.c                      -> pdcurses/*.c

Obviously, if you're only planning to build one target, you merely need to copy
one set of files.

All
+++

Finally, choose your build target (for example, for just ``pdcurses``), move to
the relevant directory using ``cmd.exe``, and then execute::

    python setup.py build -c mingw32
    python setup.py install

If you wish to create a binary package, you can instead use::

    python setup.py bdist_wininst

This will create an installer that will register itself as a program on Windows
platforms, and can thus be removed with ease at a later date.

*Note: Unless you copy the file distutils.cfg into your Python directory
(specifically X:\PythonXX\Libs\distutils\), you need to call build first to
ensure that it uses the correct compiler. Otherwise attempting to call install,
bdist_wininst, etc, without prior compilation attempts to compile using the
system default (likely Microsoft Visual C++, which you may not have installed),
ignoring the -c parameter.*

Alternate
+++++++++

To provide support for ``pip``'s easy installation system, there is a rather
hacked-together ``setup.py`` in the root directory which you can call instead of
doing the above::

    python setup.py build -c mingw32
    python setup.py install
    OR
    python setup.py bdist_wininst

This specifically only builds ``pdcurses``, not ``pdcurses-win32a``. If you wish
to build the latter, either follow the complicated instructions above, or
download a ``python-pdcurses-win32a`` source file and follow the instructions in
the ``From source`` section.

From source
^^^^^^^^^^^

There are two source distributions: ``python-pdcurses-0.3.4``, and
``python-pdcurses-win32a-0.3.4``. Each provides the necessary source files
(headers, actual source, .def, .lib and .dll) to compile the module.

In all instances it should be as simple as unzipping and executing the following
commands::

    python setup.py build -c mingw32
    python setup.py install
    OR
    python setup.py bdist_wininst

License
=======

Please see LICENSE.rst.

Links
=====

A summary of the links found in this document:

1. The `PDCurses`_ project homepage.
2. `Jérôme Berger`_'s website.
3. `Issue 2889`_ on the Python issue tracker, relating to pdcurses.
4. Jérôme Berger's `binary package`_ for Python 2.6.
5. The `PDcurses-win32a`_ fork of PDCurses, doing new window creation and direct
   drawing using the Windows API.
6. The `PDCurses mailing list`_.
7. The `python-pdcurses`_ project homepage (this project).
8. The `python-pdcurses Issue tracker`_ (this project).
9. Direct link to `pdcurses.dll`_ on the PDCurses's SourceForge project page.
10. Direct link to `pdcurses.dll (win32a)`_ on the PDCurses win32a page.
11. The `MinGW32`_ project.
12. `boodebr.org's Tutorial`_ for compiling Python C extensions using MinGW32.

.. _`PDCurses`: http://pdcurses.sourceforge.net

.. _`Jérôme Berger`: http://jeberger.free.fr

.. _`Issue 2889`: http://bugs.python.org/issue2889

.. _`binary package`: http://jeberger.free.fr/python

.. _`PDCurses-win32a`: http://www.projectpluto.com/win32a.htm

.. _`PDCurses mailing list`: http://www.mail-archive.com/pdcurses-l@lightlink.com/

.. _`python-pdcurses`: http://www.github.com/jmcb/python-pdcurses

.. _`python-pdcurses Issue tracker`: http://www.github.com/jmcb/python-pdcurses/issues

.. _`pdcurses.dll`: http://sourceforge.net/projects/pdcurses/files/pdcurses/3.4/pdc34dllw.zip/download

.. _`pdcurses.dll (win32a)`: http://www.gwi.net/~pluto/devel/pdcurses.dll

.. _`MinGW32`: http://www.mingw.org/

.. _`boodebr.org's Tutorial`: http://boodebr.org/main/python/build-windows-extensions
