
summary_keys = [
  'entity_type:11/entity_id:13758412',
  'entity_type:11/entity_id:13758412',
  'entity_type:11/entity_id:18149052',
  'entity_type:11/entity_id:35508221',
  'entity_type:11/entity_id:35665997',
  'entity_type:11/entity_id:35762786',
  'entity_type:11/entity_id:35849834',
  'entity_type:11/entity_id:36095575',
  'entity_type:11/entity_id:37680064',
  'entity_type:11/entity_id:37680065',
  'entity_type:29/entity_id:10046839',
  'entity_type:29/entity_id:10273254',
  'entity_type:29/entity_id:10352957',
  'entity_type:29/entity_id:8880587',
  'entity_type:3/entity_id:6518834',
  'entity_type:8/entity_id:57781862',
  'entity_type:8/entity_id:57781865',
  'entity_type:8/entity_id:57781867',
  'entity_type:8/entity_id:57781868',
]

ENV['SUMMARY_ACCESSOR_WRITE_TO_OAK'] = 'true' ; ENV['SUMMARY_CACHE_OAK_FORMAT'] = 'none' ; ENV['SUMMARY_CACHE_OAK_SERIAL'] = 'json'


SUMMARY_ACCESSOR_WRITE_TO_OAK=true SUMMARY_CACHE_OAK_FORMAT=none SUMMARY_CACHE_OAK_SERIAL=json

summary_keys.each { |sk| SummaryAccessor.dirty(sk) ; SummaryAccessor.fetch_summaries(sk) ; puts Redis.current.get(SummaryAccessor.redis_oak_key(sk)) }
