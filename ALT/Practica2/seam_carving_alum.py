# -*- coding: utf-8 -*-
from PIL import Image, ImageTk
import Tkinter
import os
import random
import numpy
import sys
import time
import math

def compute_gradient_simple(grad,img,width,height):
    """
    img  is a 2-dimensional graysacle image in a list of list format
    grad is the output represented in the same way
    width is the number of columns
    height is the number of rows
    """
    for y in range(1,height-1):
        for x in range(1, width-1):
            grad[y][x] = abs(img[y][x-1] - img[y][x+1])

def compute_gradient(grad,img,width,height,type):
    if type==0:
        compute_gradient_simple(grad,img,width,height)
    # COMPLETE to add new gradient types

def paint_seam(height,seam_path,color_matrix,path_color=[0,0,0]):
    for y in range(height):
        color_matrix[y][seam_path[y]] = path_color

def remove_seam(height,seam_path,color_matrix):
    for y in range(height):
        color_matrix[y].pop(seam_path[y])

def dp_seam_carving(width,height,grad,mat):
    """
    dynamic programming version which finds just one path/seam and
    returns it
    """
    infty=1e99
    # first row deserves special treatment:
	#Primera fila tada a 0
    for x in range(width):
        mat[0][x] = 0
    # the rest of rows
    for y in range(1,height):
        mat[y][0]       = infty
        mat[y][width-1] = infty
        # COMPLETE
		#for x in range(2,width-2):
		min_val = numpy.amin(mat[y])
		min_point = numpy.argmin(mat[y])

    # min_val, min_point = COMPLETE
    # retrieve the best path from min_point
    # path = [min_point]
    # COMPLETE HERE
    # path.reverse()

    # THIS CODE SHOULD BE REMOVED TO FINISH THE EXERCISE:
    x = random.randint(0,width-1)
    path = []
    for y in range(height):
      delta = random.randint(-1 if x > 0 else 0, 1 if x <width-1 else 0)
      x = x + delta
      path.append(x)
    # END OF CODE TO BE REMOVED
    return path

def matrix_to_color_image(color_matrix):
    return Image.fromarray(numpy.array(color_matrix, dtype=numpy.uint8))

def save_matrix_as_color_image(color_matrix,filename):
    img = matrix_to_color_image(color_matrix)
    img.save(filename)

######################################################################
#################       GRAPHICAL APPLICATION       ##################
######################################################################

class MyTkApp():
    def __init__(self,
	       color_img,
	       gradient_type,
	       removed_colums):

        self.root=Tkinter.Tk()
        self.root.title("Seam Carving")
        self.color_img = color_img
        self.gradient_type = gradient_type
        self.removed_colums = removed_colums
        width, height = color_img.size
        height = min(720, height)
        self.root.geometry('%dx%d' % (width, height+64))
        self.canvas = Tkinter.Canvas(self.root.master,width=width,height=height)
        # Image
        imTk = ImageTk.PhotoImage(color_img)
        self.center_x = imTk.width()/2
        self.center_y = imTk.height()/2
        self.canvas_img = imTk
        self.canvas.pack()

        l = Tkinter.Label(self.root)
        l.pack()
        self.b = Tkinter.Button(self.root, text="Empezar", command=self.runSeamCarving)
        self.b.pack()
        self.running = True
        self.root.mainloop()

    def showImg(self, im):
        "Updating image"
        imTk = ImageTk.PhotoImage(im)
        width, height = im.size
        self.canvas.delete(self.canvas_img)
        self.canvas_img = imTk
        self.canvas.create_image(self.center_x, self.center_y, image = self.canvas_img)
        self.canvas.update()

    def runSeamCarving(self):
      #self es como el this de Java
      self.b.config(text="Carving...")
      t0 = time.time()

      color_img = self.color_img

      gradient_type = self.gradient_type
      removed_colums = self.removed_colums

      width,height = color_img.size
      # convert the color image to a numpy array
      color_numpy = numpy.array(color_img.getdata()).reshape(height, width,3) # 3 for RGB
      # convert the numpy array into a list of lists, we will use this
      # list of lists (a list of rows) as our data structure during the
      # computations:
      color_matrix = color_numpy.tolist()

      # make the same for the grayscale version of the image:
      grayscale_img = color_img.convert("F")
      grayscale_numpy = numpy.array(grayscale_img.getdata()).reshape(height,width)
      grayscale_matrix = grayscale_numpy.tolist()

      # let's construct the gradient matrix as a list of lists:
      gradient_matrix = [[0.0 for x in range(width)] for y in range(height)]
      # let's construct the dynamic programming matrix as a list of lists:
      infty = 1e99
      dp_matrix = [[infty for x in range(width)] for y in range(height)]

      self.showImg(color_img) # show image
      for iteration in range(removed_colums):
        # compute the gradient
        compute_gradient(gradient_matrix,grayscale_matrix,width,height,gradient_type)
        # call the DP algorithm:
        seam_path = dp_seam_carving(width,height,gradient_matrix,dp_matrix)
        paint_seam(height,seam_path,color_matrix)
        # paint and show the seam
        self.showImg(matrix_to_color_image(color_matrix))
        # remove the seam path from the color matrix:
        remove_seam(height,seam_path,color_matrix)
        # remove from the grayscale_matrix
        remove_seam(height,seam_path,grayscale_matrix)
        # remove from the gradient matrix
        remove_seam(height,seam_path,gradient_matrix)
        # decrement width
        width -= 1
        # paint and show the seam
        self.showImg(matrix_to_color_image(color_matrix))

      # finally, save the resulting image:
      filepath, only_filename = os.path.split(file_name)
      output_file = os.path.join(filepath, "seam_carved_" + only_filename)
      save_matrix_as_color_image(color_matrix,output_file)
      t = time.time() - t0
      print 'Final time:', t
      self.b.config(text="Begin")


######################################################################
######################       MAIN PROGRAM       ######################
######################################################################
if __name__ == "__main__":
    if len(sys.argv) < 4:
        print '\n%s image_file gradient_type{0|1|2} {num_column|%%}\n'\
              % (sys.argv[0],)
        sys.exit()

    file_name = sys.argv[1]
    gradient_type = int(sys.argv[2])
    ncolumns = sys.argv[3]

    # open image
    color_img = Image.open(file_name)
    width,height = color_img.size

    # it is required to open image before processing this parameter in
    # case columns are relative
    if ncolumns[-1] == '%':
        ncolumns = int(float(ncolumns[:-1]) * width / 100)
    else:
        ncolumns = int(ncolumns)
    # python allows us to write 3<ncolumns<width
    # but most other programming languages dont
    assert 3 < ncolumns and ncolumns < width
    # number of columns to be removed
    removed_colums = width - ncolumns

    # tkinter
    app = MyTkApp(color_img,
		  gradient_type,
		  removed_colums)
