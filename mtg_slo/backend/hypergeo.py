

# from scipy.special import binom
from math import factorial

# n! / [k!(n-k)!] for (n choose k)
def binom(n,k):
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
	sampleSize = sum(req)

	num = 1
	for N,k in zip(pop,req):
		num *= binom(N,k)
	
	den = binom(totalPop,sampleSize)
	print(num)
	print(den)
	return num / den


def cardCastibility(landSet:tuple, manaCost: str):
	""" Returns odds of being able to cast a card on curve

	Keyword Arguments:
		landSet: tuple of lands. Of form (W,U,B,R,G), with 0 for no lands
				(0,0,0,10,7) would represent a set of lands of 10 Mountain 7 Forest
		
		manaCost: string of mana cost, of form '2RG'
	"""
	# Each of these casts. Programmatically find set
	# (3,1) rrrg
	# (2,2) rrgg
	# (1,3) rggg

	manacombinations = []


	# odds = 0
	# for each set of conditions:
		# odds += MVGH()

	return odds

def deckCastibility(cards):
	pass

# def bestLands(cards):
# 	best = LsHeuristic(cards)
# 	bestScore = deckCastibiliity(best)
	
# 	for thisLands in each possible set of Lands in color identity:
# 		if deckCastibiliity(thisLands) > bestScore:
# 			best = thisLands
# 			bestScore = deckCastibiliity(thisLands)

# 	return best



if __name__ == '__main__':
	p = (5,10,15)
	r = (2,2,2)
	N = 30
	n = 6
	assert round(MVHG(p,r,N,n),10) == 0.0795755968
	# Example per
	# https://en.wikipedia.org/wiki/Hypergeometric_distribution#Multivariate_hypergeometric_distribution

	# cardCastibility((0,0,0,10,7),('2RG'))
