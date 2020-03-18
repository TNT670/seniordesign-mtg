import json
import hypergeo

def mana_to_tuple(mana_costs: list):
    mana_tuples = []
    mana_tuple = ()
    for card in mana_costs:
        mana_tuple = ()
        for symbol in ['W', 'U', 'B', 'R', 'G']:
            mana_tuple = mana_tuple + (card.count(symbol),)
        mana_tuples.append(mana_tuple)
    return mana_tuples

def parse_json(json_s):
    json_string = str(json_s)
    # print(json_string)
    obj = json.loads(json_string)
    
    rawManaCostList = [x["manaCost"] for x in obj["cards"]]
    # ['0 0 0 W U G ', 'X GU GW ', 'X WU WP ']

    mana_tuples = mana_to_tuple(rawManaCostList)
    # 5 tuple of count of color appearances
    manaCosts = []
    for c, t in zip(rawManaCostList, mana_tuples):
        # print("{}\t{}".format(c, t))
        cost = ((c.count('0')),t)
        manaCosts += [cost]
        print(cost)

    return bestLands(manaCosts)



if __name__ == '__main__':
    data = {
        "deckName":"tempName",
        "identity":"WUG",
        "cards":[
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
        ]
    }

    parse_json(json.dumps(data))