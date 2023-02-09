####################################################
import sys
sys.path.append('..')
from assign02 import *
####################################################
print("[import ./../assign02.py] is done!")
####################################################
#
# Please implement (20 points)
# mylist_mergesort (see list_mergesort in assign02.sml)
#
####################################################

def split(xs):
    if mylist_nilq(xs):
        return (mylist_nil(), mylist_nil())
    else:
        if mylist_nilq(xs.get_cons2()):
            return (mylist_cons(xs.get_cons1(), mylist_nil()), mylist_nil())
        else:
            (ys, zs) = split(xs.get_cons2().get_cons2())
            return (mylist_cons(xs.get_cons1(), ys), mylist_cons(xs.get_cons2().get_cons1(), zs))

def merge(ys, zs):
    if mylist_nilq(ys):
        return zs
    else:
        if mylist_nilq(zs):
            return mylist_cons(ys.get_cons1(), ys.get_cons2())
        else:
            if ys.get_cons1() <= zs.get_cons1():
                return mylist_cons(ys.get_cons1(), merge(ys.get_cons2(), mylist_cons(zs.get_cons1(), zs.get_cons2())))
            else:
                return mylist_cons(zs.get_cons1(), merge(mylist_cons(ys.get_cons1(), ys.get_cons2()), zs.get_cons2()))

def mylist_mergesort(xs):
	if mylist_nilq(xs):
		return mylist_nil()
	else:
		if mylist_nilq(xs.get_cons2()):
			return mylist_cons(xs.get_cons2(), mylist_nil())
		else:
			(ys, zs) = split(xs.get_cons2()
			return merge(mylist_mergesort(mylist_cons(xs.get_cons1(), ys)), mylist_mergesort(mylist_cons(xs.get_cons2().get_cons1(), zs)))
