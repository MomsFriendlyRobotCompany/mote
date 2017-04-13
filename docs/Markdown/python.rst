Python
==========

The package manager of choice is ``pip`` for python 2.7 and ``pip3`` for python 3.x. 
Get ``pip`` for both versions with::

  $ sudo chown -R pi:pi /usr/local  # make usr:group pi own /usr/local
  $ mkdir tmp
  $ cd tmp
  $ wget https://bootstrap.pypa.io/get-pip.py
  $ python get-pip.py

Then upate/install some key libraries with ``pip install -U <pkgs>::

  pip
  setuptools
  wheel
  
  By default, pip loads::
  
  appdirs (1.4.3)
  lxml (3.4.0)
  packaging (16.8)
  pip (9.0.1)
  pyparsing (2.2.0)
  python-apt (0.9.3.12)
  RPi.GPIO (0.6.3)
  setuptools (34.4.1)
  six (1.10.0)
  wheel (0.29.0)
