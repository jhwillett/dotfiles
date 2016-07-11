
DatabaseReplicationUtil.use_replica { Correspondence.connection.exec_query("SELECT id,to_hex(id),md5(to_hex(id)),concat(md5(to_hex(id)),'/',to_hex(id)) FROM correspondences WHERE concat(md5(to_hex(id)),'/',to_hex(id)) <= '001' ORDER BY md5(to_hex(id)) ASC LIMIT 5") }
