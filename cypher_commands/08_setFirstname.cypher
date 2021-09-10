CALL apoc.load.xml("file:///register_hgkt_short.xml")
YIELD value
WITH value._children[1]._children[0]._children[0]._children[0] AS p
WITH [item in p._children WHERE item._type = "listPerson"] AS persLists
UNWIND persLists[0]._children AS pers
UNWIND [item in pers._children WHERE item.type = "Nachname"] AS nn
UNWIND [item in pers._children WHERE item.type = "Rufname"] AS rn
WITH nn.key AS k, rn._text AS rname
MATCH (p:KESSLERPERSON {key: k}) SET p.rufname = rname
RETURN p