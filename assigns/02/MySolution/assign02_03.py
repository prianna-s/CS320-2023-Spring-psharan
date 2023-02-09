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