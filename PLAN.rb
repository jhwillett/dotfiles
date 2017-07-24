
heroku config:set --app ali-production BATCHER_ES_INDEXER_INSTANCES=AWS_ES_14,AWS_ES_16 BATCHER_ES_REINDEX_INSTANCES= BATCHER_ES_REREINDEX_INSTANCES= BATCHER_ES_STATS_INSTANCES=AWS_ES_14,AWS_ES_16 BATCHER_ES_VERIFICATION_INSTANCES=AWS_ES_14,AWS_ES_16 BATCHER_ES_WRITE_INSTANCES=AWS_ES_14,AWS_ES_16

heroku config:unset --app ali-production AWS_ES_05_AWS_KEY AWS_ES_05_AWS_REGION AWS_ES_05_AWS_SECRET AWS_ES_05_URL AWS_ES_10_AWS_KEY AWS_ES_10_AWS_REGION AWS_ES_10_AWS_SECRET AWS_ES_10_PARTIAL_REINDEXING AWS_ES_10_URL AWS_ES_12_AWS_KEY AWS_ES_12_AWS_REGION AWS_ES_12_AWS_SECRET AWS_ES_12_PARTIAL_REINDEXING AWS_ES_12_URL

[
  'indexer_primary','indexer_bilge','deleter_primary','deleter_bilge','verifier'
].each do |flavor|
  [ 'AWS_ES_05','AWS_ES_10','AWS_ES_12' ].each do |instance|
    batcher_name = "es_#{instance}_#{flavor}"
    ick          = Ick.new(Redis.current)
    50.times do |shard_id|
      ick_name   = Batchers::Batcher.sharded_queue_name(batcher_name,shard_id)
      ick_stats  = ick.ickstats(ick_name)
      next if !ick_stats
      next if ick_stats['total_size'] <= 0
      puts "ick_name:  #{ick_name}"
      puts "total_size: #{ick_stats['total_size']}"
      #ick.ickdel(ick_name)                # uncomment to del if sizes are sane
    end
  end
end
