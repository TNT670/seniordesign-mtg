from math import factorial


# n! / [k!(n-k)!] for (n choose k)
def binom(n,k):
	# print(n,k,n-k)
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
    landSet = [round(x * 17 / sum(lands)) for x in lands]
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
        # print('\t',N,k)
        if N-k < 0:
        	return 0
            # print(N,k)
            # print(pop,req)
            # exit()
        num *= binom(N,k)
    
    den = binom(totalPop,sampleSize)
    # print(num)
    # print(den)
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
    for i in range(len(res)):
        lands[i] -= manaCost[1][i]
        res[i] += manaCost[1][i]
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
    for i in range(len(res)):
        if (lands[i] != 0):
            landsCopy = lands.copy()
            landsCopy[i] -= 1
            resCopy = res.copy()
            resCopy[i] += 1
            findManaCombos(generics - 1, landsCopy, resCopy, combos)

def deckCastibility(manaCosts: list, lands: list):
	# Returns average castibility of spells in deck.

	c = 0
	for m in manaCosts:
		c += cardCastibility(lands, m)
	
	c /= len(lands)
	
	return c

def bestLands(manaCosts: list):
#     best = LsHeuristic(cards)
#     bestScore = deckCastibiliity(best)
    
#     for thisLands in each possible set of Lands in color identity:
#         if deckCastibiliity(thisLands) > bestScore:
#             best = thisLands
#             bestScore = deckCastibiliity(thisLands)

#     return best
  bestLandSet = LsHeuristic(manaCosts)
  bestScore = deckCastibility(manaCosts, bestLandSet)

  landTypes = 0
  for i in range(len(bestLandSet)):
    if bestLandSet[i] != 0:
      landTypes += 1

  if landTypes == 1:
    return bestLandSet


  elif landTypes == 2:
    originalBestLandSet = bestLandSet.copy()
    testLandSet = bestLandSet.copy()
    raiseValue = True
    ##  First Tests the landSet by raising the amount of the first type of lands and lowering the second type
    while(landTypes == 2):
      for i in range(len(testLandSet)):
        if testLandSet[i] != 0:
          ## Raise the value of the first land type
          if raiseValue == True:
            testLandSet[i] = testLandSet[i] + 1
            raiseValue = False
          ## Lower the value of the second land type
          elif raiseValue == False:
            testLandSet[i] = testLandSet[i] - 1
            raiseValue = True
        ## If the tested landSet is better than the previous it is set as the bestLandSet
        if deckCastibility(manaCosts, testLandSet) > bestScore:
          bestLandSet = testLandSet
          bestScore = deckCastibility(manaCosts, testLandSet)
        ## Make sure that one of the lands hasnt reached 0
        landTypes = 0
      for i in range(len(testLandSet)):
        if testLandSet[i] != 0:
          landTypes += 1

    ## Now test the landSet by lowering the first type of lands and raising the second type
    testLandSet = originalBestLandSet.copy()
    raiseValue = False
    landTypes = 2
    while(landTypes == 2):
      for i in range(len(testLandSet)):
        if testLandSet[i] != 0:
          if raiseValue == True:
            testLandSet[i] = testLandSet[i] + 1
            raiseValue = False
          elif raiseValue == False:
            testLandSet[i] = testLandSet[i] -1
            raiseValue = True
        if deckCastibility(manaCosts, testLandSet) > bestScore:
          bestLandSet = testLandSet
          bestScore = deckCastibility(manaCosts, testLandSet)
      landTypes = 0
      for i in range(len(testLandSet)):
        if testLandSet[i] != 0:
          landTypes += 1


    return bestLandSet



if __name__ == '__main__':
    p = (5,10,15)
    r = (2,2,2)
    N = 30
    n = 6
    #assert round(MVHG(p,r,N,n),10) == 0.0795755968
    # Example per
    # https://en.wikipedia.org/wiki/Hypergeometric_distribution#Multivariate_hypergeometric_distribution

    # cardCastibility((0,0,0,10,7),('2RG'))
