#!/usr/bin/env python

from __future__ import print_function
from __future__ import division
import pygecko
# import opencvutils as cvu
from opencvutils import MJPEGServer
import Socket

# need to run this in another process because of OpenCV and GIL
def mjpeg(port=9000, win=(640,480)):
  MJPEGServer.cam = MJPEGServer.setUpCamera(pi=True, win=win)
	server = HTTPServer(('0.0.0.0', args['port']), MJPEGServer)
	print "server started on {}:{}".format(Socket.gethostname(), port)
	server.serve_forever()

def run():
  mjpeg()
  
if __name__ == '__main__':
  run()
