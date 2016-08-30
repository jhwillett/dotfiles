
# Peek at all the assignees per env SIGNUP_TO_LEAD_ASSIGNEES:
#
SignupToLeadJob.get_environment_variable(SignupToLeadJob::ENV_ASSIGNEES,errors).split(',').map(&:to_i)
#
# Gives something like:
#
#  => [26365, 15924, 42932, 42933, 42934, 42935, 66828, 62853, 62852, 65020, 72648, 72649, 76244, 83551, 85713, 92331, 89410]
#

# Peek at all the assignees's emails to confirm:
#
CompanyUserAccessor.fetch_by_ids(SignupToLeadJob.get_environment_variable(SignupToLeadJob::ENV_ASSIGNEES,errors).split(',').map(&:to_i)).map(&:email)
#
# Gives something like:
#
# => ["bcelani@prosperworks.com", "hayley@prosperworks.com", "anders@prosperworks.com", "malcolm@prosperworks.com", "ale@prosperworks.com", "kylev@prosperworks.com", "jake@prosperworks.com", "lauren@prosperworks.com", "david.gerths@prosperworks.com", "rebecca@prosperworks.com", "andrew.suh@prosperworks.com", "briana@prosperworks.com", "daniel@prosperworks.com", "kristine@prosperworks.com", "casey@prosperworks.com", "lbrose@prosperworks.com", "jessica@prosperworks.com"]
#

# Pretty-print those emails:
#
puts CompanyUserAccessor.fetch_by_ids(SignupToLeadJob.get_environment_variable(SignupToLeadJob::ENV_ASSIGNEES,errors).split(',').map(&:to_i)).map(&:email).join("\n")
#

# Given a list of emails, find the Users which are associated with them:
#
emails = [
  "bcelani@prosperworks.com",
  "hayley@prosperworks.com",
  "anders@prosperworks.com",
  "malcolm@prosperworks.com",
  "ale@prosperworks.com",
  "kylev@prosperworks.com",
  "lauren@prosperworks.com",
  "david.gerths@prosperworks.com",
  "andrew.suh@prosperworks.com",
  "briana@prosperworks.com",
  "daniel@prosperworks.com",
  "kristine@prosperworks.com",
  "casey@prosperworks.com",
  "lbrose@prosperworks.com",
  "jessica@prosperworks.com",
  "ben@prosperworks.com",
  "bgibb@prosperworks.com",
  "ryan@prosperworks.com",
]
company_id = SignupToLeadJob.get_environment_variable(SignupToLeadJob::ENV_COMPANY_ID,[]).to_i
assignees = emails.map{|e|UserAccessor.find_by_email(e)}.map(&:id).map{|uid|CompanyUserAccessor.find_by_company_id_and_user_id(company_id,uid)}.map(&:id)
assignees.join(',')

# was: "26365,15924,42932,42933,42934,42935,66828,62853,62852,65020,72648,72649,76244,83551,85713,92331,89410"
# now: "26365,15924,42932,42933,42934,42935,62853,62852,72648,72649,76244,83551,85713,92331,89410,97099,97098,97100"


