CALL apoc.load.xml("file:///register_hgkt_short.xml")
YIELD value
WITH value._children[1]._children[0]._children[0]._children[0] AS p
WITH [item in p._children WHERE item._type = "listPerson"] AS persLists
UNWIND persLists[0]._children AS pers
UNWIND [item in pers._children WHERE item.type = "Nachname"] AS nn
UNWIND [item in pers._children WHERE item._type = "note" AND item.n="Sacherläuterung"] AS n
WITH nn.key AS k, n._text AS info
MATCH (p:KESSLERPERSON {key: k}) SET p.info = info
RETURN p