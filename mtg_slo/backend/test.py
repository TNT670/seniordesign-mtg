from parse_json import parse_json
import json
import testData

def transform(inputCards:list,inputFormat:str):
	jsonSetup = {
		'deckName':'noName',
		'identity':'only matters in app',
		'cards':[],
		'format':inputFormat
	}
	
	for count,cost in inputCards:
		for _ in range(count):
			jsonSetup['cards'] += [{'cardName':'','mana_cost':cost}]

	return jsonSetup



	

def main():
	tD = testData.evenSplit
	x = transform(tD[1],tD[0])	
	y = parse_json(json.dumps(x), debug = True)
	

if __name__ == '__main__':
	main()
