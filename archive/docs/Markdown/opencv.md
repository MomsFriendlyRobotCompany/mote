# OpenCV Install

opencv will be installed from [packagecloud.io](https://packagecloud.io/walchko/robots). You can follow 
their instructions from the install tab, but they are repeated here below:

## Manual Install

In order to install a deb repo, first you need to install the GPG key that used 
to sign repository metadata. You do that using a utility called apt-key.

    curl -L https://packagecloud.io/walchko/robots/gpgkey | sudo apt-key add -

Refresh your package cache by running:

    sudo apt-get update

If you are running Debian, install debian-archive-keyring so that official Debian 
repositories will be verified:

    sudo apt-get install debian-archive-keyring

Install a package called apt-transport-https to make it possible for apt to 
fetch packages over https.

    sudo apt-get install -y apt-transport-https

Create a file named ``/etc/apt/sources.list.d/walchko_robots.list`` that contains 
the repository configuration below.

Make sure to replace ubuntu and trusty in the config below with your Linux 
distribution and version:

    deb https://packagecloud.io/walchko/robots/ubuntu/ trusty main
    deb-src https://packagecloud.io/walchko/robots/ubuntu/ trusty main

Valid options for os and dist parameters can be found in our support OS list 
in the docs.

Run:

    sudo apt-get update

to update your local APT cache.

You can now install packages from your repository.

## Install Opencv 3.x

Now run:

    sudo apt install libopencv-dev

Once the library is done installing, run:

    sudo ldconfig /usr/local/lib

To double check all went well, look for opencv in the following output:

    ldconfig -p | grep opencv
