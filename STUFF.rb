

$statsd = DevStatsd.new() ; ENV['LOG_STATSD'] = 'true'

100.times { CrawlerJob.perform('correspondence_text_preview_data') }
BatcherJob.perform('correspondence_text_preview_data',0,10)
100.times { CrawlerJob.perform('migrate_s3-Correspondence-text_data-text_ext_key') }
BatcherJob.perform('migrate_s3-Correspondence-text_data-text_ext_key',0,10)

batcher = Batchers::Factory::ALL_BATCHERS['correspondence_text_preview_data']
batcher.consumer.process_batch('x',(0..5).map{|id|[0,id.to_s]})

batcher = Batchers::Factory::ALL_BATCHERS['evict_pg-Correspondence-body_data-body_data']



