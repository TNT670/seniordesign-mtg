
evenSplit = [
    'Standard 40',
    [
        (2,"0 0 0 R R "),
        (4,"0 0 R G "),
        (4,"0 0 G "),
        (2,"0 0 R "),
        (1,"G G "),
        (3,"0 G "),
        (4,"0 R "),
        (3,"G "),
    ] 
]

tinyTri = [
    'Standard 40',
    [
        (2,"0 0 0 R R "),
        (2,"0 0 B G "),
        (2,"0 0 R G "),
        (4,"0 0 G "),
        (2,"0 0 R "),
        (1,"G G "),
        (3,"0 G "),
        (4,"0 R "),
        (3,"G "),
    ]
]

issue1 = [
    'Standard 40',
    [
        (1,"U U "),
        (1,"0 G G "),
        (2,"0 W G"),
        (3,"0 U "),
        (1,"0 G "),
        (4,"0 0 U "),
        (1,"0 0 W W"),
        (2,"0 0 G "),
        (1,"0 0 0 U "),
        (1,"0 0 0 G G G"),
        (1,"0 0 0 " ),
        (3,"0 0 0 0 U "),
        (1,"0 0 0 0 G G G"),
        (1,"0 0 0 0 0 U U")
    ]
]

commander = [
    'Commander',
    [
        (5,"0 0 0 R R "),
        (5,"0 0 R G "),
        (5,"0 0 G "),
        (10,"0 0 R "),
        (10,"G G "),
        (10,"0 G "),
        (10,"0 R "),
        (5,"G "),
    ]
]

if __name__ == '__main__':
    # Confirm decks are of size
    assert sum([count for count,cost in evenSplit[1]]) == 23
    assert sum([count for count,cost in tinyTri[1]]) == 23
    assert sum([count for count,cost in issue1[1]]) == 40-17
    assert sum([count for count,cost in commander[1]]) == 100-40
    print('All asserts OK')