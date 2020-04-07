from parse_json import parse_json
import json
import testData

def transform(inputCards:list):
	jsonSetup = {
		'deckName':'noName',
		'identity':'currentlyDoesntMatter',
		'cards':[]
	}
	
	for count,cost in inputCards:
		for _ in range(count):
			jsonSetup['cards'] += [{'cardName':'','manaCost':cost}]

	return jsonSetup



	

def main():
	x = testData.issue1
	x = transform(x)
	print(x['cards'])
	# for (2,"0 0 R G "),
	y = parse_json(json.dumps(x))
	print(y)

if __name__ == '__main__':
	main()
