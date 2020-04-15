import hypergeo

def findLandCombos(n, k, total, start, landCombos, res):
    if (k == 0):
        if (total == n):
            landCombos += [res]
        return
    
    for i in range(start, n+1):
        res += [i]
        findLandCombos(n, k - 1, total + i, i, landCombos, res.copy())
        del res[-1]


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


def deckCastibility(manaCosts: list, lands: list, totalDeckSize:int):
    """ Returns the castibility of a deck. Where card castibility is defined
        strictly by being able to cast it "on time," the definition of
        deck castibility is more flexible. For now, we are just returning the
        average castibility of all cards, but it could a weighted average, or
        anything at all.
        By returning the average castibilities of each card, we are returning
        the odds of being able to cast every spell you draw on time, I think.
    """
    assert sum(lands)+len(manaCosts) == totalDeckSize
    return sum([cardCastibility(lands,m,totalDeckSize) for m in manaCosts]) / len(manaCosts)


def cardCastibility(landSet:list, manaCost:tuple, totalDeckSize:int):
    """ Returns odds of being able to cast a card on curve. This function
        assumes that the mana cost of a card is less than the number of lands of
        the corresponding color(s) required. May need to update this function
        later.

    Keyword Arguments:
        landSet: tuple of lands. Of form (W,U,B,R,G), with 0 for no lands
                (0,0,0,10,7) would represent a set of lands of 10 Mountain 7 Forest
        
        manaCost: tuple of mana cost (generic, (W,U,B,R,G))
    """
    
    # Example: For 2RG, each of these casts. Programmatically find set
    # (3,1) rrrg
    # (2,2) rrgg
    # (1,3) rggg
    # print(landSet,type(landSet))
    lands = landSet.copy()
    res = [0, 0, 0, 0, 0]
    for i in range(len(res)):
        lands[i] -= manaCost[1][i]
        if (lands[i] < 0):
            return 0
        res[i] += manaCost[1][i]
    combos = []
    # This is where the magic happens
    findManaCombos(manaCost[0], lands, res, combos)
    manacombinations = set(combos)
    
    odds = 0
    for c in manacombinations:
        odds += hypergeo.MVHG(landSet, c, totalDeckSize)
    
    return odds


