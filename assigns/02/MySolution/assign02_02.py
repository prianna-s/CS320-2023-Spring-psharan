####################################################
import sys
sys.path.append('..')
from assign02 import *
####################################################
print("[import ./../assign02.py] is done!")
####################################################
#
# Please implement (10 points)
# mylist_quicksort (see list_quicksort in assign02.sml)
#
####################################################

def qpart(xs,p0):
    
    if mylist_nilq(xs):
        return (mylist_nil(),mylist_nil())
    else:
        (ys,zs)= qpart(xs.get_cons2(), p0)
        if xs.get_cons1() <= p0:
            return(mylist_cons(xs,ys),zs)
        else:
            return (ys,mylist_cons(xs,zs))

def mylist_quicksort(xs):
    
    if mylist_nilq(xs):
        return mylist_nil()
    else:
        (ys,zs) = qpart(xs.get_cons2(),xs.get_cons1())
        ys=mylist_quicksort(ys)
        zs=mylist_quicksort(zs)
        return mylist_append(ys, mylist_cons(xs.get_cons1(),zs))