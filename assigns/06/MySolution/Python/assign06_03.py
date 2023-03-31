####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../../../mypylib')
from mypylib_cls import *
####################################################
"""
HX-2023-03-24: 20 points
Solving the N-queen puzzle
"""
####################################################
def solve_N_queen_puzzle(N):
    """
Please revisit assign04-04.sml.
A board of size N is a tuple of length N.
######
For instance, a tuple (0, 0, 0, 0) stands
for a board of size 4 (that is, a 4x4 board)
where there are no queen pieces on the board.
######
For instance, a tuple (2, 1, 0, 0) stands
for a board of size 4 (that is, a 4x4 board)
where there are two queen pieces; the queen piece
on the 1st row is on the 2nd column; the queen piece
on the 2nd row is on the 1st column; the last two rows
contain no queen pieces.
######
This function [solve_N_queen_puzzle] should return
a stream of ALL the boards of size N that contain N
queen pieces (one on each row and on each column) such
that no queen piece on the board can catch any other ones
on the same board.
"""
    def nqueen(bd):
        res = 0
        for j0 in bd:
            if j0 <= 0:
                break
            else:
                res = res + 1
        return res

    def board_safety_all(bd):
        return \
            int1_forall\
            (nqueen(bd), \
             lambda i0: board_safety_one(bd, i0))

    def board_safety_one(bd, i0):
        def helper(j0):
            pi = bd[i0]
            pj = bd[j0]
            return pi != pj and abs(i0-j0) != abs(pi-pj)
        return int1_forall(i0, helper)

    def board(bd, i0, j0):
        x = list(bd)
        x[i0] = j0
        return tuple(x)

    def position(bd, i0, j0):
        def helper(x0):
            pos = bd[x0]
            return pos != j0 and abs(i0-x0) != abs(j0-pos)
        return int1_forall(i0, helper)

    def fchildren(nxs, c, x):
        q = nqueen(nxs)
        def valid(n):
            if position(nxs, q, n):
                bd = board(nxs, q, n)
                x.put(bd)
        int1_foreach(c + 1, lambda r: () if r == 0 else valid(r))
        return None
    
    def gtree_dfs(nxs, fchild, x):
        def help(qnxs):
            if qnxs.empty():
                return strcon_nil()
            else:
                nx1 = qnxs.get()

                fchild(nx1,x,qnxs)
                return strcon_cons(nx1, lambda: help(qnxs))
        return lambda: help(nxs)

    qnxs = queue.LifoQueue()
    qnxs.put((0,) * N)

    return stream_make_filter(gtree_dfs(qnxs, fchildren, N), lambda r: nqueen(r) == N)