Python
==========

The package manager of choice is ``pip`` for python 2.7 and ``pip3`` for python 3.x. 
Get ``pip`` for both versions with::

  $ sudo chown -R pi:pi /usr/local  # make usr:group pi own /usr/local
  $ mkdir tmp
  $ cd tmp
  $ wget https://bootstrap.pypa.io/get-pip.py
  $ python get-pip.py

Then upate/install some key libraries with ``pip install -U <pkgs>``::

  - pip
  - setuptools
  - wheel

