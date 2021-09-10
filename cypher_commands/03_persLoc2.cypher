CALL apoc.load.xml("file:///hgk1880-09_1885.xml")
YIELD value
UNWIND value._children AS v
UNWIND [item in v._children WHERE v._type = "text"] AS t
UNWIND [item in t._children WHERE t._type = "body"] AS b
UNWIND [item in b._children WHERE item._type = "p"] AS p
WITH [item in p._children] as pChildren, t._children[0]._children[0]._text AS e  
UNWIND [item in pChildren WHERE NOT (apoc.meta.cypher.type(item) = "STRING") AND item._type = "note"] AS notes
UNWIND [item in notes._children WHERE NOT (apoc.meta.cypher.type(item) = "STRING") AND item._type = "persName"AND item.key IS NOT NULL] AS persInText
MERGE (kp:KESSLERPERSON {key: persInText.key} )
WITH kp, e
MATCH (n:ENTRY {head: e})
MERGE (n)-[:erwähnt]->(kp)
RETURN n, kp
