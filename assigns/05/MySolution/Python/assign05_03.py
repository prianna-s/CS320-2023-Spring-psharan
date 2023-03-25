####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../../05')
sys.path.append('./../../../../mypylib')
from mypylib_cls import *
####################################################
"""
HX-2023-03-14: 30 points
BU CAS CS320-2023-Spring: Image Processing
"""
####################################################
import math
####################################################
import kervec
import imgvec
####################################################
from PIL import Image
####################################################

def load_color_image(filename):
    """
    Loads a color image from the given file and returns a dictionary
    representing that image.
    Invoked as, for example:
       i = load_color_image("test_images/cat.png")
    """
    with open(filename, "rb") as img_handle:
        img = Image.open(img_handle)
        img = img.convert("RGB")  # in case we were given a greyscale image
        img_data = img.getdata()
        pixels = list(img_data)
        width, height = img.size
        return imgvec.image(height, width, pixels)
    # return None

def save_color_image(image, filename, mode="PNG"):
    """
    Saves the given color image to disk or to a file-like object.  If filename
    is given as a string, the file type will be inferred from the given name.
    If filename is given as a file-like object, the file type will be
    determined by the "mode" parameter.
    """
    out = Image.new(mode="RGB", size=(image.width, image.height))
    out.putdata(image.pixlst)
    if isinstance(filename, str):
        out.save(filename)
    else:
        out.save(filename, mode)
    out.close()
    # return None

####################################################
#
# HX-2023-03-18:
# This one is incorrect:
# def grey_of_color(clr):
#     (r0, b1, g2) = clr
#     return round(0.299*r0+0.587*b1+0.114*g2)
def grey_of_color(clr):
    (rr, gg, bb) = clr
    return round(0.299*rr+0.587*gg+0.114*bb)
#
####################################################

def image_invert_grey(ximg):
    return imgvec.image_make_map(ximg, lambda pix: 255 - pix)
def image_invert_color(ximg):
    return imgvec.image_make_map(ximg, lambda clr: 255 - grey_of_color(clr))

####################################################
#
# towers = \
#     load_color_image("INPUT/towers.jpg")
# balloons = \
#     load_color_image("INPUT/balloons.png")
#
####################################################
#
# save_color_image(image_invert_color(towers), "OUTPUT/towers_invert.png")
# save_color_image(image_invert_color(balloons), "OUTPUT/balloons_invert.png")
#
####################################################

def image_edges_grey(image):
    """
    This is an implementation of the Sobel operator.
    """
    krow = \
        kervec.kernel_make_pylist\
        (3, [-1, -2, -1, 0, 0, 0, 1, 2, 1])
    kcol = \
        kervec.kernel_make_pylist\
        (3, [-1, 0, 1, -2, 0, 2, -1, 0, 1])
    imgrow = \
        imgvec.image_kernel_correlate(image, krow, 'extend')
    imgcol = \
        imgvec.image_kernel_correlate(image, kcol, 'extend')
    imgres = \
        imgvec.image_make_z2map\
        (imgrow, imgcol, lambda x, y: math.sqrt(x*x + y*y))
    return imgvec.image_round_and_clip(imgres)

def image_edges_color(image):
    return image_edges_grey\
        (imgvec.image_make_map(image, lambda clr: 255 - grey_of_color(clr)))

####################################################

def image_blur_bbehav_grey(image, ksize, bbehav):
    ksize2 = ksize*ksize
    kernel = \
        kervec.kernel_make_pylist\
        (ksize, ksize2*[1.0/ksize2])
    return imgvec.image_round_and_clip\
        (imgvec.image_kernel_correlate(image, kernel, bbehav))

####################################################

def color_filter_from_greyscale_filter(filt):
    """
    Given a filter that takes a greyscale image as input and produces a
    greyscale image as output, returns a function that takes a color image as
    input and produces the filtered color image.
    """
    def image_filter(cimage):
        ww = cimage.width
        hh = cimage.height
        image0 = filt(imgvec.image_make_map(cimage, lambda clr: clr[0]))
        image1 = filt(imgvec.image_make_map(cimage, lambda clr: clr[1]))
        image2 = filt(imgvec.image_make_map(cimage, lambda clr: clr[2]))
        return imgvec.image_make_tuple\
            (hh, ww, \
             tuple(zip(image0.pixlst, image1.pixlst, image2.pixlst)))
    return lambda cimage: image_filter(cimage)

####################################################

def image_blur_bbehav_color(image, ksize, bbehav):
    return \
        color_filter_from_greyscale_filter\
        (lambda image: image_blur_bbehav_grey(image, ksize, bbehav))(image)

####################################################
# save_color_image\
#    (image_blur_bbehav_color(balloons, 5, 'extend'), "OUTPUT/balloons_blurred.png")
####################################################

def path(energy,index,ww):
    if index < ww:
        energy[index] = (energy[index],2)
    elif index % ww == 0:
        z = energy[index] + energy[index - ww][0]
        y = energy[index] + energy[(index - ww) + 1][0]
        if z <= y:
            energy[index] = (z,0)
        else:
            energy[index] = (y,1)
    elif (index + 1) % ww == 0:
        x = energy[index] + energy[(index - ww) - 1][0]
        y = energy[index] + energy[index - ww][0]

        if y < x:
            energy[index] = (y,0)
        else:
            energy[index] = (x, -1)
    else:
        x = energy[index] + energy[(index - ww) - 1][0]
        y = energy[index] + energy[index - ww][0]
        z = energy[index] + energy[(index - ww) + 1][0]

        if x <= z and x <= y:
            energy[index] = (x,-1)
        elif y <= z:
            energy[index] = (y, 0)
        else:
            energy[index] = (z,1)
    return None

def seam_val(energy, size, ww):
    int1_foreach(size, lambda r: path(energy,r,ww))        
    return energy

def remove(image):
    ww = image.width
    hh = image.height
    size = ww * hh
    energy = image_edges_color(image)
    energy_list = list(energy.pixlst)
    seam = seam_val(energy_list, size, ww)
    rm_list = []
    minimum = seam[size - ww][0]
    l = size - ww
    for i in range(size - ww, size):
        if seam[i][0] < minimum:
            minimum = seam[i][0]
            l = i
    row = hh - 1
    while row >= 0:
        rm_list = pylist_append([l % ww],rm_list)
        if seam[l][1] == 2:
            break
        elif seam[l][1] == -1:
            l = (l - ww) - 1
        elif seam[l][1] == 0:
            l = (l - ww)
        else:
            l = (l - ww) + 1
        row = row - 1
    new_image = imgvec.image(hh, ww-1, imgvec.image_i2filter_pylist(image, lambda x, x1, r: rm_list[x] != x1))
    return new_image

def image_seam_carving_color(image, ncol):
    """
    Starting from the given image, use the seam carving technique to remove
    ncols (an integer) columns from the image. Returns a new image.
    """
    
    assert ncol < image.width
    image = imgvec.image(image.height, image.width, list(image.pixlst))
    final = int1_foldleft(ncol, image, lambda x,x0: remove(x))
    return imgvec.image_make_pylist(final.height, final.width, final.pixlst)

####################################################
# save_color_image(image_seam_carving_color(balloons, 100), "OUTPUT/balloons_seam_carving_100.png")
####################################################