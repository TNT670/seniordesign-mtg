import json

def parse_json(json_s):
    json_string = str(json_s)
    print(json_string)
    obj = json.loads(json_string)
    mana_costs = [x["manaCost"] for x in obj["cards"]]
    mana_tuples = mana_to_tuple(mana_costs)
    for x, y in zip(mana_costs, mana_tuples):
        print("{}\t{}".format(x, y))

def mana_to_tuple(mana_costs):
    mana_tuples = []
    mana_tuple = ()
    for card in mana_costs:
        mana_tuple = ()
        for symbol in ['W', 'U', 'B', 'R', 'G']:
            mana_tuple = mana_tuple + (card.count(symbol),)
        mana_tuples.append(mana_tuple)
    return mana_tuples