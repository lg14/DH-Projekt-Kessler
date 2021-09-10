CALL apoc.load.xml("file:///hgk1880-09_1885.xml")
YIELD value UNWIND value._children AS v 
UNWIND [item in v._children WHERE v._type = "text"] AS t 
MERGE (e:ENTRY {head: t._children[0]._children[0]._text}) 
RETURN e