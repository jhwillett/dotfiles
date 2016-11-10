--
-- Set up, make my connection have nice properties for this kind of thing.
--
\set ECHO all
\timing on
SET maintenance_work_mem = '8GB';
--
-- Build some indices which are comparable to existing indexes, and
-- compare for size.
--
CREATE INDEX CONCURRENTLY jhw_entity_associations_on_id ON entity_associations (id);
CREATE INDEX CONCURRENTLY jhw_associations_entity_source_type_id ON entity_associations (source_entity_id, source_entity_type);
CREATE INDEX CONCURRENTLY jhw_associations_entity_target_type_id ON entity_associations (target_entity_id, target_entity_type);
--
-- Build single-column indices to compete with multi-column indices.
--
CREATE INDEX CONCURRENTLY jhw_entity_associations_on_source_entity_id ON entity_associations (source_entity_id);
CREATE INDEX CONCURRENTLY jhw_entity_associations_on_target_entity_id ON entity_associations (target_entity_id);
CREATE INDEX CONCURRENTLY jhw_entity_associations_on_source_entity_type ON entity_associations (source_entity_type);
CREATE INDEX CONCURRENTLY jhw_entity_associations_on_target_entity_type ON entity_associations (target_entity_type);
--
-- Build some new indices which would be darned convenient for the
-- storage layer.
--
CREATE INDEX CONCURRENTLY jhw_entity_associations_on_company_id ON entity_associations (company_id);
CREATE INDEX CONCURRENTLY jhw_entity_associations_on_updated_at ON entity_associations (updated_at);
--
-- Review the table.
--
\d entity_associations
SELECT c2.relname, c2.relpages FROM pg_class c, pg_class c2, pg_index i WHERE c.relname = 'entity_associations' AND c.oid = i.indrelid AND c2.oid = i.indexrelid ORDER BY c2.relname;
