
evenSplit = [
    (2,"0 0 0 R R "),
    (4,"0 0 R G "),
    (4,"0 0 G "),
    (2,"0 0 R "),
    (1,"G G "),
    (3,"0 G "),
    (4,"0 R "),
    (3,"G "),
]

tinyTri = [
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

issue1 = [
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

if __name__ == '__main__':
    # Confirm decks are of size
    assert sum([count for count,cost in evenSplit]) == 23
    assert sum([count for count,cost in tinyTri]) == 23
    assert sum([count for count,cost in issue1]) == 23
    print('All asserts OK')