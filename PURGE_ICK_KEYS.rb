def for_all_es_queues(*instance_names)
  instance_names.each do |instance_name|
    [
      "es_#{instance_name}_indexer_bilge",
      "es_#{instance_name}_indexer_primary",
      "es_#{instance_name}_deleter_bilge",
      "es_#{instance_name}_deleter_primary",
      "es_#{instance_name}_verifier",
    ].each do |batcher_name|
      50.times do |shard_id|
        queue_key   = batcher_name
        if 0 != shard_id
          queue_key = "#{batcher_name}/batcher_shard_#{shard_id}"
        end
        do_one_queue(queue_key)
      end
    end
  end
end
def do_one_queue(queue_key)
  stats = Ick.ickstats(Redis.current,queue_key)
  puts "#{queue_key}: nil" if !stats
  return                   if !stats
  puts "#{queue_key}: #{stats['total_size']}"
  Ick.ickdel(Redis.current,queue_key) if stats['total_size'] < 10000
end
for_all_es_queues(*Batchers::Factory.all_known_elasticsearch_urls.keys)
for_all_es_queues('FOUND_ES_13','FOUND_ES_16')
