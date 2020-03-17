
# from scipy.special import binom
from math import ceil, factorial

# n! / [k!(n-k)!] for (n choose k)
def binom(n,k):
    return factorial(n) / ( factorial(k) * factorial(n-k) )

def LsHeuristic(manaCosts: list):
    """ Returns a list representing the land set. Rounds up; the returned list
        should add up to either 17 or 18.
    
    Keyword Arguments:
        manaCosts: list of mana costs of the form (generic, (W,U,B,R,G)).
    
    Example:
        manaCosts = [(2, (0,0,0,1,1)), (2, (0,0,0,1,0)), (2, (0,0,0,0,1)),
                     (1, (0,0,0,1,0)), (0, (0,0,0,1,1)), (1, (0,0,0,0,1)),
                     (0, (0,0,0,1,0)), (0, (0,0,0,0,1))]
        landSet = [0, 0, 0, 9, 9]
    """
    lands = [0,0,0,0,0]
    for elem in manaCosts:
        lands = [lands[i] + elem[1][i] for i in range(0,5)]
    landSet = [ceil(x * 17 / sum(lands)) for x in lands]
    return landSet

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
    sampleSize = sum(req)

    num = 1
    for N,k in zip(pop,req):
        num *= binom(N,k)
    
    den = binom(totalPop,sampleSize)
    print(num)
    print(den)
    return num / den


def cardCastibility(landSet:list, manaCost:tuple):
    """ Returns odds of being able to cast a card on curve. This function
        assumes that the mana cost of a card is less than the number of lands of
        the corresponding color(s) required. May need to update this function
        later.
    TODO: lots of testing to make sure this function actually works!!!!
          Especially the mana combos!!!!

    Keyword Arguments:
        landSet: tuple of lands. Of form (W,U,B,R,G), with 0 for no lands
                (0,0,0,10,7) would represent a set of lands of 10 Mountain 7 Forest
        
        manaCost: tuple of mana cost (generic, (W,U,B,R,G))
    """
    
    # Example: For 2RG, each of these casts. Programmatically find set
    # (3,1) rrrg
    # (2,2) rrgg
    # (1,3) rggg
    
    lands = landSet.copy()
    res = [0, 0, 0, 0, 0]
    for i in range(0, len(res)):
        lands[i] -= manaCost[1][i]
        res += manaCost[1][i]
    combos = []
    # This is where the magic happens
    findManaCombos(manaCost[0], lands, res, combos)
    manacombinations = set(combos)

    odds = 0
    for c in manacombinations:
        odds += MVHG(lands, c, 40)

    return odds

def findManaCombos(generics, lands, res, combos):
    if (generics == 0):
        combos += (tuple(res),)
        return
    for i in range(0, len(res)):
        if (lands[i] != 0):
            landsCopy = lands.copy()
            landsCopy[i] -= 1
            resCopy = res.copy()
            resCopy[i] += 1
            findManaCombos(generics - 1, landsCopy, resCopy, combos)

def deckCastibility(cards):
    pass

# def bestLands(cards):
#     best = LsHeuristic(cards)
#     bestScore = deckCastibiliity(best)
    
#     for thisLands in each possible set of Lands in color identity:
#         if deckCastibiliity(thisLands) > bestScore:
#             best = thisLands
#             bestScore = deckCastibiliity(thisLands)

#     return best



if __name__ == '__main__':
    p = (5,10,15)
    r = (2,2,2)
    N = 30
    n = 6
    assert round(MVHG(p,r,N,n),10) == 0.0795755968
    # Example per
    # https://en.wikipedia.org/wiki/Hypergeometric_distribution#Multivariate_hypergeometric_distribution

    # cardCastibility((0,0,0,10,7),('2RG'))
