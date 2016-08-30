
# Measure all StatsJobs::ALL_GROUPS for runtime.
#
StatsJob::ALL_GROUPS.each { |group| s = Time.now ; StatsJob.perform(group) ; t = Time.now - s ; puts "%8.3f: %s" % [ t.to_f, group ] }

# BILGE PUMP: Repeatedy dirty the Summary cache for the tip of all
# index_bilge batchers:
#

loop{sleep(1);puts SummaryAccessor.dirty(*Batchers::Factory::ALL_BATCHERS.values.map(&:ick_names).flatten.select{|s|/bilge/=~s}.map{|s|Ick.ickreserve(Redis.current,s,1)}.map(&:first).select{|s|s}.map(&:first)).to_s}

heroku run --app ali-production -- rails runner 'loop{sleep(1);puts SummaryAccessor.dirty(*Batchers::Factory::ALL_BATCHERS.values.map(&:ick_names).flatten.select{|s|/bilge/=~s}.map{|s|Ick.ickreserve(Redis.current,s,1)}.map(&:first).select{|s|s}.map(&:first)).to_s}'


# Get the size of all fifo shards:
#
Batchers::Factory::ALL_BATCHERS.values.map(&:fifo_names).flatten.map {|n|[n,Redis.current.llen(n)]}.to_h

# Get the size of all fifo batchers which have fallen behind:
#
Batchers::Factory::ALL_BATCHERS.values.map(&:fifo_names).flatten.map {|name|[name,Redis.current.llen(name)]}.select{|name,num|num>1000}.to_h

# Get the ScheduleBatcherJobsJob failure count table:
ScheduleBatcherJobsJob.fetch_failure_count_table

# Get the names of all batchers and how many shards they have.
#
Batchers::Factory::ALL_BATCHERS.values.map{|b| [b.stats_name,[b.num_push_shards,b.num_push_shards].max]}.to_h

# Run a batch of size one against shard 3 of es_FOUND_ES_18_indexer_bilge.
#
BatcherJob.perform('es_FOUND_ES_18_indexer_bilge',3,1)


# Get the stats for all ick shards:
#
Batchers::Factory::ALL_BATCHERS.values.map(&:ick_names).flatten.map {|n|[n,Ick.ickstats(Redis.current,n)['pset_size']]}.to_h

# Run all shards of all the live ones 1 entry:

Batchers::Factory::DRIVEN_BATCHERS.values.map{ |batcher| [batcher.stats_name, batcher.num_pop_shards.times.map { |shard| BatcherJob.perform(batcher.stats_name,shard,1) } ] }

Batchers::Factory::DRIVEN_CRAWLERS.values.map{ |crawler| [crawler.stats_name, CrawlerJob.perform(crawler.stats_name) ] }

# Select all the index_bilge batchers and get a look at their first elements.
#
Batchers::Factory::ALL_BATCHERS.values.select{|b|/indexer_bilge/=~b.stats_name}.map(&:ick_names).flatten.map{|ick|[ick,Ick.ickreserve(Redis.current,ick,1)]}

# Get a list of the summary_keys at the tip of all index_bilge batchers.
#
Batchers::Factory::ALL_BATCHERS.values.map(&:ick_names).flatten.select{|s|/bilge/=~s}.map{|s|Ick.ickreserve(Redis.current,s,1)}.map(&:first).select{|s|s}.map(&:first)

# Select all the index_bilge batchers and get a look at just the their
# first summary_keys:
#
Batchers::Factory::ALL_BATCHERS.values.select{|b|/indexer_bilge/=~b.stats_name}.map(&:ick_names).flatten.map{|ick|[ick,Ick.ickreserve(Redis.current,ick,1).map(&:first)]}.select

Batchers::Factory::ALL_BATCHERS.values.select{|b|/indexer_bilge/=~b.stats_name}.map(&:ick_names).flatten.map{|ick|[ick,Ick.ickcommit(Redis.current,ick,"entity_type:3/entity_id:10667370","entity_type:3/entity_id:10665805")]}


Batchers::Factory::ALL_BATCHERS.values.select{|b| /FOUND_ES_11/ =~ b.stats_name || /FOUND_ES_12/ =~ b.stats_name}.map(&:ick_names).flatten.map{|ick|[ick,Ick.ickstats(Redis.current,ick)['total_size']]}

Batchers::Factory::ALL_BATCHERS.values.select{|b| /indexer_bilge/ =~ b.stats_name && (/FOUND_ES_11/ =~ b.stats_name || /FOUND_ES_12/ =~ b.stats_name)}.map(&:ick_names).flatten.map{|ick|[ick,Ick.ickdel(Redis.current,ick)]}

Batchers::Factory::ALL_BATCHERS.keys.select{|k| /indexer_bilge/ =~ k && (/FOUND_ES_11/ =~ k || /FOUND_ES_12/ =~ k)}.map{|k| Batchers::Factory::ALL_BATCHERS[k].num_push_shards}


num = 0 ; Batchers::Factory::ALL_BATCHERS.values.select{|b| /FOUND_ES_11/ =~ b.stats_name || /FOUND_ES_12/ =~ b.stats_name}.map(&:ick_names).flatten.map{|ick|[ick,Ick.ickcommit(Redis.current,ick,*Ick.ickreserve(Redis.current,ick,num).map(&:first))]}


num = 1000 ; s = 0.5 ; t = 1000 ; t.times.each { puts 'tick' ; Batchers::Factory::ALL_BATCHERS.values.select{|b| /FOUND_ES_11/ =~ b.stats_name || /FOUND_ES_12/ =~ b.stats_name}.map(&:ick_names).flatten.map{|ick|[ick,Ick.ickcommit(Redis.current,ick,*Ick.ickreserve(Redis.current,ick,num).map(&:first))]} ; sleep s }

# Ick Drainer
#
# Drain a group of Icks safely. With million of entries entries,
# Ick.ickdel() can be expensive enough to harm Redis availability.
# So here we do smaller batches.
#
ick_names = ["es_FOUND_ES_18_indexer_primary", "es_FOUND_ES_18_indexer_bilge", "es_FOUND_ES_18_indexer_bilge/batcher_shard_1", "es_FOUND_ES_18_indexer_bilge/batcher_shard_2", "es_FOUND_ES_18_indexer_bilge/batcher_shard_3", "es_FOUND_ES_18_indexer_bilge/batcher_shard_4", "es_FOUND_ES_18_indexer_bilge/batcher_shard_5", "es_FOUND_ES_18_indexer_bilge/batcher_shard_6", "es_FOUND_ES_18_indexer_bilge/batcher_shard_7", "es_FOUND_ES_18_indexer_bilge/batcher_shard_8", "es_FOUND_ES_18_indexer_bilge/batcher_shard_9", "es_FOUND_ES_18_indexer_bilge/batcher_shard_10", "es_FOUND_ES_18_indexer_bilge/batcher_shard_11", "es_FOUND_ES_18_indexer_bilge/batcher_shard_12", "es_FOUND_ES_18_indexer_bilge/batcher_shard_13", "es_FOUND_ES_18_indexer_bilge/batcher_shard_14", "es_FOUND_ES_18_deleter_primary", "es_FOUND_ES_18_deleter_bilge", "es_FOUND_ES_18_verifier", "es_FOUND_ES_19_indexer_primary", "es_FOUND_ES_19_indexer_bilge", "es_FOUND_ES_19_indexer_bilge/batcher_shard_1", "es_FOUND_ES_19_indexer_bilge/batcher_shard_2", "es_FOUND_ES_19_indexer_bilge/batcher_shard_3", "es_FOUND_ES_19_indexer_bilge/batcher_shard_4", "es_FOUND_ES_19_indexer_bilge/batcher_shard_5", "es_FOUND_ES_19_indexer_bilge/batcher_shard_6", "es_FOUND_ES_19_indexer_bilge/batcher_shard_7", "es_FOUND_ES_19_indexer_bilge/batcher_shard_8", "es_FOUND_ES_19_indexer_bilge/batcher_shard_9", "es_FOUND_ES_19_indexer_bilge/batcher_shard_10", "es_FOUND_ES_19_indexer_bilge/batcher_shard_11", "es_FOUND_ES_19_indexer_bilge/batcher_shard_12", "es_FOUND_ES_19_indexer_bilge/batcher_shard_13", "es_FOUND_ES_19_indexer_bilge/batcher_shard_14", "es_FOUND_ES_19_indexer_bilge/batcher_shard_15", "es_FOUND_ES_19_indexer_bilge/batcher_shard_16", "es_FOUND_ES_19_indexer_bilge/batcher_shard_17", "es_FOUND_ES_19_indexer_bilge/batcher_shard_18", "es_FOUND_ES_19_indexer_bilge/batcher_shard_19", "es_FOUND_ES_19_deleter_primary", "es_FOUND_ES_19_deleter_bilge", "es_FOUND_ES_19_verifier"]
ick_names = [
  'correspondence_text_preview_data',
  'evict_pg-Correspondence-body_data-body_data',
  'evict_pg-Correspondence-body_data-body_data/batcher_shard_1',
  'evict_pg-Correspondence-body_data-body_data/batcher_shard_2',
  'evict_pg-Correspondence-text_data-text_data',
  'evict_pg-Correspondence-text_data-text_data/batcher_shard_1',
  'evict_pg-Correspondence-text_data-text_data/batcher_shard_2',
  'migrate_s3-Correspondence-body_data-body_ext_key',
  'migrate_s3-Correspondence-body_data-body_ext_key/batcher_shard_1',
  'migrate_s3-Correspondence-body_data-body_ext_key/batcher_shard_2',
  'migrate_s3-Correspondence-body_data-body_ext_key/batcher_shard_3',
  'migrate_s3-Correspondence-text_data-text_ext_key',
  'migrate_s3-Correspondence-text_data-text_ext_key/batcher_shard_1',
  'migrate_s3-Correspondence-text_data-text_ext_key/batcher_shard_2',
]
def ick_looker(ick_names) ick_names.each { |ick_name| stats = Ick.ickstats(Redis.current,ick_name) ; next if stats.nil? ; total = stats['total_size'] ; next if !total || total <= 0 ; puts "#{ick_name}: #{stats['total_size']}" } ; puts 'done' end
def ick_drainer(ick_names,n) ick_names.each { |ick_name| keys = Ick.ickreserve(Redis.current,ick_name,n).map(&:first) ; next if keys.empty? ; got = Ick.ickcommit(Redis.current,ick_name,*keys) ; puts "#{ick_name} dropped #{got}" } ; puts 'done' end

ick_looker(ick_names)
ick_drainer(ick_names,100)
loop { ick_drainer(ick_names,1000) ; sleep 1 }



migration_queues.each { |mq| puts [mq,Ick.ickstats(Redis.current,mq)['total_size']] }

