"""
Code for the function findLandCombos toward the end of this file was converted
and modified from Java code retrieved from
https://algorithms.tutorialhorizon.com/find-all-unique-combinations-of-exact-k-numbers-from-1-to-9-with-sum-to-n/
"""

from math import factorial

# n! / [k!(n-k)!] for (n choose k)
def binom(n,k):
	# print(n,k,n-k)
	return factorial(n) / ( factorial(k) * factorial(n-k) )


def MVHG(pop,req,totalPop):
    """ Returns probability

    Keyword Arguments:
        pop:(number of lands) iterable of subpopulation counts
        req:(mana cost) iterable of subpopulation requests
        totalPop:(size of deck) total number of objects in population. Can be >sum(pop)

    Example:
        pop = (10, 7)
        req = (2, 2)
        totalPop = 40
    """
    sampleSize = sum(req) + 7
    
    num = 1
    for N,k in zip(pop,req):
        
        # If N is ever < k, we are looking to draw more lands of a color
        # than are in the deck. The total odds is zero, since
        # this will never occur, even if we can draw the other colors.
        if N < k: 
            return 0

        num *= binom(N,k)

    num *= binom(totalPop - sum(pop), 7)
    
    den = binom(totalPop,sampleSize)
    return num / den


if __name__ == '__main__':
    p = (5,10,15)
    r = (2,2,2)
    N = 30
    n = 6
    print('execute parse_json as main to test')

    #assert round(MVHG(p,r,N,n),10) == 0.0795755968
    # Example per
    # https://en.wikipedia.org/wiki/Hypergeometric_distribution#Multivariate_hypergeometric_distribution

    # cardCastibility((0,0,0,10,7),('2RG'))
