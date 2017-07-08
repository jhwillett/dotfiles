
heroku config:set BATCHER_ES_INDEXER_INSTANCES=AWS_ES_05,AWS_ES_10,AWS_ES_12,AWS_ES_14,AWS_ES_16 BATCHER_ES_REINDEX_INSTANCES=AWS_ES_14,AWS_ES_16 BATCHER_ES_REREINDEX_INSTANCES=AWS_ES_14,AWS_ES_16 BATCHER_ES_STATS_INSTANCES=AWS_ES_05,AWS_ES_10,AWS_ES_12,AWS_ES_14,AWS_ES_16 BATCHER_ES_VERIFICATION_INSTANCES=AWS_ES_05,AWS_ES_10,AWS_ES_12,AWS_ES_14,AWS_ES_16 BATCHER_ES_WRITE_INSTANCES=AWS_ES_05,AWS_ES_10,AWS_ES_12,AWS_ES_14,AWS_ES_16 --app ali-production

heroku config:unset AWS_ES_02_AWS_KEY AWS_ES_02_AWS_REGION AWS_ES_02_AWS_SECRET AWS_ES_02_URL AWS_ES_08_AWS_KEY AWS_ES_08_AWS_REGION AWS_ES_08_AWS_SECRET AWS_ES_08_INDEX_PER_MAPPING AWS_ES_08_URL AWS_ES_09_AWS_KEY AWS_ES_09_AWS_REGION AWS_ES_09_AWS_SECRET AWS_ES_09_PARTIAL_REINDEXING AWS_ES_09_URL AWS_ES_11_AWS_KEY AWS_ES_11_AWS_REGION AWS_ES_11_AWS_SECRET AWS_ES_11_PARTIAL_REINDEXING AWS_ES_11_URL AWS_ES_13_AWS_KEY AWS_ES_13_AWS_REGION AWS_ES_13_AWS_SECRET AWS_ES_13_PARTIAL_REINDEXING AWS_ES_13_URL AWS_ES_15_AWS_KEY AWS_ES_15_AWS_REGION AWS_ES_15_AWS_SECRET AWS_ES_15_PARTIAL_REINDEXING AWS_ES_15_URL --app ali-production

[
  'AWS_ES_02',
  'AWS_ES_08',
  'AWS_ES_09',
  'AWS_ES_11',
  'AWS_ES_13',
  'AWS_ES_15',
].each do |instance|
  [
    'indexer_primary',
    'indexer_bilge',
    'deleter_primary',
    'deleter_bilge',
    'verifier',
  ].each do |flavor|
    batcher_name = "es_#{instance}_#{flavor}"
    50.times do |shard_id|
      ick_name   = Batchers::Batcher.sharded_queue_name(batcher_name,shard_id)
      ick_stats  = Ick.ickstats(Redis.current,ick_name)
      next if !ick_stats
      next if ick_stats['total_size'] <= 0
      puts "ick_name:  #{ick_name}"
      #puts "ick_stats: #{ick_stats}"
      puts "total_size: #{ick_stats['total_size']}"
      #Ick.ickdel(Redis.current,ick_name)
    end
  end
end
