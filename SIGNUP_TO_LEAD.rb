
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
CompanyUserAccessor.fetch_by_ids(SignupToLeadJob.get_environment_variable(SignupToLeadJob::ENV_ASSIGNEES,[]).split(',').map(&:to_i)).map(&:email)
#
# Gives something like:
#
# => ["bcelani@prosperworks.com", "hayley@prosperworks.com", "anders@prosperworks.com", "malcolm@prosperworks.com", "ale@prosperworks.com", "kylev@prosperworks.com", "jake@prosperworks.com", "lauren@prosperworks.com", "david.gerths@prosperworks.com", "rebecca@prosperworks.com", "andrew.suh@prosperworks.com", "briana@prosperworks.com", "daniel@prosperworks.com", "kristine@prosperworks.com", "casey@prosperworks.com", "lbrose@prosperworks.com", "jessica@prosperworks.com"]
#

# Pretty-print those emails:
#
puts CompanyUserAccessor.fetch_by_ids(SignupToLeadJob.get_environment_variable(SignupToLeadJob::ENV_ASSIGNEES,[]).split(',').map(&:to_i)).map(&:email).join("\n")
#

# There is an AE Assignee list:
#
#   SIGNUP_TO_LEAD_ACCOUNT_EXECUTIVE_FIELD_ID=9482
#
# ...is a custom_field_definitions.id for this field.
#
#   SIGNUP_TO_LEAD_ACCOUNT_EXECUTIVE_OPTIONS_BLACKLIST=39129,45975,12043,12045,54980
#
# ...are custom_field_definition_options.ids referring to
# custom_field_definition_options with
# custom_field_definition_options.custom_field_definition_id = 9482 e.g.:
#
#   ali-production::BLUE=> select id,name from custom_field_definition_options where custom_field_definition_id = 9482;
#     id   |      name
#   -------+-----------------
#    54980 | Anders Eddy
#    45975 | Brett Celani
#    42935 | Munjal Shah
#    42934 | Marina Fishman
#    39129 | Hayley Wickins
#    13570 | Jordan Lujan
#    12259 | Alissa Masuda
#    12260 | Brittany Perez
#    12045 | Taylor Lowe
#    12044 | David Hernandez
#    12043 | Jesse Price
#    24943 | Kyle Warren
#    29746 | Phil Taylor
#   (13 rows)
#
# The blacklist are filtered out e.g.:
#
#   ali-production::BLUE=> select id,name from custom_field_definition_options where custom_field_definition_id = 9482 AND id IN (39129,45975,12043,12045,54980);
#     id   |      name
#   -------+----------------
#    54980 | Anders Eddy
#    45975 | Brett Celani
#    39129 | Hayley Wickins
#    12045 | Taylor Lowe
#    12043 | Jesse Price
#   (5 rows)
#
# 


# Given a list of emails, find the Users which are associated with them:
#
emails = [
  "ale@prosperworks.com",
  "anders@prosperworks.com",
  "andrew.suh@prosperworks.com",
  "ben@prosperworks.com",
  "bgibb@prosperworks.com",
  "briana@prosperworks.com",
  "casey@prosperworks.com",
  "daniel@prosperworks.com",
  "david.gerths@prosperworks.com",
  "hayley@prosperworks.com",
  "kristine@prosperworks.com",
  "kylev@prosperworks.com",
  "lauren@prosperworks.com",
  "lbrose@prosperworks.com",
  "malcolm@prosperworks.com",
  "ryan@prosperworks.com",
]
company_id = SignupToLeadJob.get_environment_variable(SignupToLeadJob::ENV_COMPANY_ID,[]).to_i
assignees = emails.map{|e|UserAccessor.find_by_email(e)}.map(&:id).map{|uid|CompanyUserAccessor.find_by_company_id_and_user_id(company_id,uid)}.map(&:id)
assignees.join(',')

#  was: "26365,15924,42932,42933,42934,42935,66828,62853,62852,65020,72648,72649,76244,83551,85713,92331,89410"
#  now: "26365,15924,42932,42933,42934,42935,62853,62852,72648,72649,76244,83551,85713,92331,89410,97099,97098,97100"
# next: "42934,42932,72648,97099,97098,72649,85713,76244,62852,15924,83551,42935,62853,92331,42933,97100"


