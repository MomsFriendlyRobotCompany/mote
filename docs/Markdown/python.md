# Python

## Pip

The package manager of choice is ``pip`` for python 2.7 and ``pip3`` for python 3.x. 
Get ``pip`` for both versions with:

    sudo chown -R pi:pi /usr/local  # make usr:group pi own /usr/local
    mkdir tmp
    cd tmp
    wget https://bootstrap.pypa.io/get-pip.py
    python get-pip.py

Then update some key libraries with:

    pip install -U pip setuptools wheel

## Other Packages

Insall other packages with `pip install -U <pkgs>`:

- [hostinfo](https://github.com/walchko/hostinfo): follow install directions
- pygecko
- opencvutils


---

<p align="center">
	<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
		<img alt="Creative Commons License"  src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" />
	</a>
	<br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
</p>
