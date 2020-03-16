import hypergeo
import structs

# TODO MVP
def LsHeuristic(decklist):
	pass

# Sample data input
dataIn = (
	(6,'2RG'),
	(4,'2R'),
	(3,'2G'),
	(3,'1R'),
	(1,'RG'),
	(1,'1G'),
	(3,'R'),
	(2,'G')
)

# TODO weights??


initLandSet = (17,0,0,0,0)
# initLandSet = LsHeuristic()  TODO

# while localMax landSet not found:
	# test next landSet
	# thisLandSet = MVGH()

# return/write bestLandset



def starflutCallable(argument:Deck):
	print(argument.name)
	return (0,0,0,10,7)

