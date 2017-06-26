#!/usr/bin/env python

from __future__ import print_function
from __future__ import division
# import opencvutils as cvu
from opencvutils.MJPEGServer import mjpegServer
import Socket

# need to run this in another process because of OpenCV and GIL
def mjpeg(port=9000, win=(640,480)):
	server = HTTPServer(('0.0.0.0', args['port']), mjpegServer)
	print "server started on {}:{}".format(Socket.gethostname(), port)
	server.serve_forever()

  
if __name__ == '__main__':
  mjpeg()
