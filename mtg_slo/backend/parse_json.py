import json
import land


def parse_json(json_s, debug = False):
    json_string = str(json_s)
    
    jDict = json.loads(json_string)
    
    rawManaCostList = [x["manaCost"] for x in jDict["cards"]]
    # ['0 0 0 W U G ', 'X GU GW ', 'X WU WP ']

    mana_tuples = mana_to_tuple(rawManaCostList)
    # List of 5-tuples, representing colored mana cost of that card
    
    manaCosts = []
    for c, t in zip(rawManaCostList, mana_tuples):
        generics = int(c[1:c.index('}')]) if c[1].isdigit() else 0
        cost = ((generics),t)
        manaCosts += [cost]

    deckCountDict = {
        'Standard 40': 40,
        'Standard 60': 60,
        'Commander': 100
    }
    totalDeckSize = deckCountDict[jDict['format']]

    return land.bestLands(manaCosts, totalDeckSize, debug)


def mana_to_tuple(mana_costs: list):
    mana_tuples = []
    mana_tuple = ()
    for card in mana_costs:
        mana_tuple = ()
        for symbol in ['W', 'U', 'B', 'R', 'G']:
            mana_tuple = mana_tuple + (card.count(symbol),)
        mana_tuples.append(mana_tuple)
    return mana_tuples



def main():
    data = {
        "deckName":"tempName",
        "identity":"WUG",
        "cards":[
            {
                "cardName":"",
                "manaCost":"0 0 0 R R "
            },
            {
                "cardName":"",
                "manaCost":"0 0 0 R R "
            },
            {
                "cardName":"",
                "manaCost":"0 0 R G "
            },
            {
                "cardName":"",
                "manaCost":"0 0 R G "
            },
            {
                "cardName":"",
                "manaCost":"0 0 R G "
            },
            {
                "cardName":"",
                "manaCost":"0 0 R G "
            },
            {
                "cardName":"",
                "manaCost":"0 0 G "
            },
            {
                "cardName":"",
                "manaCost":"0 0 G "
            },
            {
                "cardName":"",
                "manaCost":"0 0 G "
            },
            {
                "cardName":"",
                "manaCost":"0 0 G "
            },# 10th card 
            {
                "cardName":"",
                "manaCost":"0 0 R "
            },
            {
                "cardName":"",
                "manaCost":"0 0 R "
            },       
            {
                "cardName":"",
                "manaCost":"G G "
            },
            {
                "cardName":"",
                "manaCost":"0 G "
            },
            {
                "cardName":"",
                "manaCost":"0 G "
            },
            {
                "cardName":"",
                "manaCost":"0 G "
            },
            {
                "cardName":"",
                "manaCost":"0 R "
            },
            {
                "cardName":"",
                "manaCost":"0 R "
            },
            {
                "cardName":"",
                "manaCost":"0 R "
            },
            {
                "cardName":"",
                "manaCost":"0 R "
            },#20th card
            {
                "cardName":"",
                "manaCost":"G "
            },
            {
                "cardName":"",
                "manaCost":"G "
            },
            {
                "cardName":"",
                "manaCost":"G "
            },
        ]
    }

    # print((type(data)))
    # for k,v in data.items():
        # print(k,type(v))
    print(data["cards"] )
    # parse_json(json.dumps(data))

if __name__ == '__main__':
    main()