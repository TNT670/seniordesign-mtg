from parse_json import parse_json
import json
import testData

def transform(inputCards:list,targLands:int):
	jsonSetup = {
		'deckName':'noName',
		'identity':'currentlyDoesntMatter',
		'cards':[],
		'targetLands':targLands
	}
	
	for count,cost in inputCards:
		for _ in range(count):
			jsonSetup['cards'] += [{'cardName':'','manaCost':cost}]

	return jsonSetup



	

def main():
	x = testData.issue1
	x = transform(x,40-len(x))
	# print(x['cards'])
	# for (2,"0 0 R G "),
	y = parse_json(json.dumps(x), debug = True)
	print(y)

if __name__ == '__main__':
	main()
