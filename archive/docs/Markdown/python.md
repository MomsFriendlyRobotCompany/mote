# Python

Python 2 will already be installed. You will need:

    sudo apt install python3

Unfortunatley, ``apt`` will change

## Pip

The package manager of choice is ``pip`` for python 2.7 and ``pip3`` for python 3.x.
Get ``pip`` for both versions with:

    cd  # change to home directory
    sudo chown -R pi:pi /usr/local  # make usr:group pi own /usr/local
    mkdir tmp
    cd tmp
    wget https://bootstrap.pypa.io/get-pip.py
    python get-pip.py
    python3 get-pip.py

Then update some key libraries with:

    sudo pip install -U pip setuptools wheel
    sudo pip3 install -U pip setuptools wheel
    sudo chown pi:pi -R /usr/local

**Note:** had to change the shebang in `pip` from python3 to python

Remember, python2 and python3 maintain their own separate package repos, so
you if you are going to program in both languages, then you need to add the
same packages to both repos.

## Other Packages

Insall other packages with `pip install -U <pkgs>`.

---

<p align="center">
	<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
		<img alt="Creative Commons License"  src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" />
	</a>
	<br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
</p>
