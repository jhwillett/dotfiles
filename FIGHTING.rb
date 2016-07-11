Redis.current.hgetall('ALI:{resque}:concurrent.queue_counts')

=> {"BackscrapeUserEmailsForEntityJob"=>"34574", "ProcessIngestionDataJob"=>"589235", "TestJailedJobJob"=>"0"}

Redis.current.llen('ALI:{resque}:concurrent.queue.BackscrapeUserEmailsForEntityJob.BackscrapeUserEmailsForEntityJob')

=> 34574

Redis.current.llen('ALI:{resque}:concurrent.queue.ProcessIngestionDataJob.ProcessIngestionDataJob')

=> 589235

Redis.current.lrange('ALI:{resque}:concurrent.queue.ProcessIngestionDataJob.ProcessIngestionDataJob',0,0)

=> ["{\"queue\":\"ProcessIngestionDataJob\",\"payload\":{\"class\":\"ProcessIngestionDataJob\",\"args\":[\"FullContactCompanyIngestionLogic\",[\"svb.com\",\"lumity.com\"],7668,11928]}}"]

Redis.current.lrange('ALI:{resque}:queue:ProcessIngestionDataJob',0,0)

=> ["{\"class\":\"ProcessIngestionDataJob\",\"args\":[\"GoogleContactIngestionLogic\",[\"saket@nexla.com\",\"mfitzpatrick@goodwinprocter.com\",\"cmcadam@goodwinprocter.com\"],59214,84537]}"]

# So, the list at ALI:{resque}:concurrent.queue.FOO.FOO contains
# strings which are JSON encodings of structures like:
#
{
  "queue"   => "ProcessIngestionDataJob",
  "payload" => {
    "class" => "ProcessIngestionDataJob",
    "args"  => ["FullContactCompanyIngestionLogic",["svb.com","lumity.com"],7668,11928]
  }
}

# We want to get these into their target queues.
#
# I'll use Resque for more magic safety.
#
#
Redis.current.lrange('ALI:{resque}:queue:ProcessIngestionDataJob',0,0)



def run(n)
  num = 0
  ['BackscrapeUserEmailsForEntityJob','ProcessIngestionDataJob','RefreshOrganizationInteractionSummaryJob','RefreshLeadInteractionSummaryJob','RemoveEntity','RefreshDealInteractionSummaryJob','RefreshContactInteractionSummaryJob'].each do |q|
    queue   = "concurrent.queue.#{q}.#{q}"
    puts "queue: #{queue}"
    puts "llen:  #{Resque.redis.llen(queue)}"
    fjobs   = []
    Resque.redis.pipelined do
      n.times do
        fjobs << Resque.redis.lpop(queue)
      end
    end
    jobs    = fjobs.map(&:value)
    puts "llen:  #{Resque.redis.llen(queue)}"
    Resque.redis.pipelined do
      jobs.each do |job|
        next if !job
        data    = JSON.load(job)
        klass   = Kernel.const_get(data['payload']['class'])
        args    = data['payload']['args']
        Resque.enqueue(klass,*args)
        num += 1
      end
    end
  end
  puts "num:  #{num}"
end
run(10)

