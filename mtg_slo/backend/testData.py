
evenSplit = [
    'Standard 40',
    [
        (2,"{3}{R}{R}"),
        (4,"{2}{R}{G}"),
        (4,"{2}{G}"),
        (2,"{2}{R}"),
        (1,"{G}{G}"),
        (3,"{2}{G}"),
        (4,"{2}{R}"),
        (3,"{G}"),
    ] 
]

tinyTri = [
    'Standard 40',
    [
        (2,"{3}{R}{R} "),
        (2,"{2}{B}{G} "),
        (2,"{2}{R}{G} "),
        (4,"{2}{G} "),
        (2,"{2}{R} "),
        (1,"{G}{G} "),
        (3,"{1}{G} "),
        (4,"{1}{R} "),
        (3,"{G} "),
    ]
]

issue1 = [
    'Standard 40',
    [
        (1,"{U}{U} "),
        (1,"{1}{G}{G} "),
        (2,"{1}{W}{G}"),
        (3,"{1}{U} "),
        (1,"{1}{G} "),
        (4,"{2}{U} "),
        (1,"{2}{W}{W}"),
        (2,"{2}{G} "),
        (1,"{3}{U} "),
        (1,"{3}{G}{G}{G}"),
        (1,"{3} " ),
        (3,"{4}{U} "),
        (1,"{4}{G}{G}{G}"),
        (1,"{5}{U}{U}")
    ]
]

commander = [
    'Commander',
    [
        (5,"{3}{R}{R} "),
        (5,"{2}{R}{G} "),
        (5,"{2}{G} "),
        (10,"{2}{R} "),
        (10,"{G}{G} "),
        (10,"{1}{G} "),
        (10,"{1}{R} "),
        (5,"{G} "),
    ]
]

if __name__ == '__main__':
    # Confirm decks are of size
    assert sum([count for count,cost in evenSplit[1]]) == 23
    assert sum([count for count,cost in tinyTri[1]]) == 23
    assert sum([count for count,cost in issue1[1]]) == 40-17
    assert sum([count for count,cost in commander[1]]) == 100-40
    print('All asserts OK')