MATCH p=(e)-[r:`erwähnt`]->(pe)
RETURN pe.key, pe.nachname, pe.rufname, count(pe) AS c, pe.info
ORDER BY c DESC