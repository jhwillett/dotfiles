SET maintenance_work_mem = '8GB';

CREATE INDEX CONCURRENTLY jhw_activity_counts_on_company_id ON activity_counts (company_id);

CREATE INDEX CONCURRENTLY jhw_activity_counts_on_custom_activity_type_id ON activity_counts (custom_activity_type_id);

CREATE INDEX CONCURRENTLY jhw_activity_counts_on_entity_id ON activity_counts (entity_id);

CREATE INDEX CONCURRENTLY jhw_activity_logs_on_company_id ON activity_logs (company_id);

CREATE INDEX CONCURRENTLY jhw_activity_logs_on_company_user_id ON activity_logs (company_user_id);

CREATE INDEX CONCURRENTLY jhw_activity_logs_on_custom_activity_type_id ON activity_logs (custom_activity_type_id);

CREATE INDEX CONCURRENTLY jhw_activity_logs_on_source_id ON activity_logs (source_id);

CREATE INDEX CONCURRENTLY jhw_activity_logs_on_target_id ON activity_logs (target_id);

CREATE INDEX CONCURRENTLY jhw_addresses_on_address_owner_id ON addresses (address_owner_id);

CREATE INDEX CONCURRENTLY jhw_addresses_on_company_id ON addresses (company_id);

CREATE INDEX CONCURRENTLY jhw_api_keys_on_company_id ON api_keys (company_id);

CREATE INDEX CONCURRENTLY jhw_company_user_group_joins_on_company_user_id ON company_user_group_joins (company_user_id);

CREATE INDEX CONCURRENTLY jhw_company_user_group_joins_on_group_id ON company_user_group_joins (group_id);

CREATE INDEX CONCURRENTLY jhw_company_users_on_company_id ON company_users (company_id);

CREATE INDEX CONCURRENTLY jhw_company_users_on_user_id ON company_users (user_id);

CREATE INDEX CONCURRENTLY jhw_contact_suggestions_on_company_id ON contact_suggestions (company_id);

CREATE INDEX CONCURRENTLY jhw_contacts_on_assignee_id ON contacts (assignee_id);

CREATE INDEX CONCURRENTLY jhw_correspondences_on_company_id ON correspondences (company_id);

CREATE INDEX CONCURRENTLY jhw_correspondences_on_creator_id ON correspondences (creator_id);

CREATE INDEX CONCURRENTLY jhw_custom_fields_on_company_id ON custom_fields (company_id);

CREATE INDEX CONCURRENTLY jhw_custom_fields_on_custom_field_definition_id ON custom_fields (custom_field_definition_id);

CREATE INDEX CONCURRENTLY jhw_custom_fields_on_field_owner_id ON custom_fields (field_owner_id);

CREATE INDEX CONCURRENTLY jhw_custom_fields_on_option_id ON custom_fields (option_id);

CREATE INDEX CONCURRENTLY jhw_deal_histories_on_assignee_id ON deal_histories (assignee_id);

CREATE INDEX CONCURRENTLY jhw_deal_histories_on_customer_source_id ON deal_histories (customer_source_id);

CREATE INDEX CONCURRENTLY jhw_deal_histories_on_loss_reason_id ON deal_histories (loss_reason_id);

CREATE INDEX CONCURRENTLY jhw_deal_histories_on_pipeline_id ON deal_histories (pipeline_id);

CREATE INDEX CONCURRENTLY jhw_deal_histories_on_stage_id ON deal_histories (stage_id);

CREATE INDEX CONCURRENTLY jhw_deals_on_stage_id ON deals (stage_id);

CREATE INDEX CONCURRENTLY jhw_email_trackers_on_activity_log_id ON email_trackers (activity_log_id);

CREATE INDEX CONCURRENTLY jhw_email_trackers_on_company_user_id ON email_trackers (company_user_id);

CREATE INDEX CONCURRENTLY jhw_email_trackers_on_opened_activity_log_id ON email_trackers (opened_activity_log_id);

CREATE INDEX CONCURRENTLY jhw_entity_associations_on_company_id ON entity_associations (company_id);

CREATE INDEX CONCURRENTLY jhw_entity_associations_on_source_entity_id ON entity_associations (source_entity_id);

CREATE INDEX CONCURRENTLY jhw_entity_associations_on_target_entity_id ON entity_associations (target_entity_id);

CREATE INDEX CONCURRENTLY jhw_entity_events_on_entity_id ON entity_events (entity_id);

CREATE INDEX CONCURRENTLY jhw_field_layout_items_on_company_id ON field_layout_items (company_id);

CREATE INDEX CONCURRENTLY jhw_field_layouts_on_company_id ON field_layouts (company_id);

CREATE INDEX CONCURRENTLY jhw_file_documents_on_company_id ON file_documents (company_id);

CREATE INDEX CONCURRENTLY jhw_file_documents_on_creator_id ON file_documents (creator_id);

CREATE INDEX CONCURRENTLY jhw_gmail_msgid_mappings_on_company_id ON gmail_msgid_mappings (company_id);

CREATE INDEX CONCURRENTLY jhw_gmail_msgid_mappings_on_company_user_id ON gmail_msgid_mappings (company_user_id);

CREATE INDEX CONCURRENTLY jhw_goals_on_goal_membership_id ON goals (goal_membership_id);

CREATE INDEX CONCURRENTLY jhw_goal_memberships_on_company_id ON goal_memberships (company_id);

CREATE INDEX CONCURRENTLY jhw_goal_memberships_on_company_user_id ON goal_memberships (company_user_id);

CREATE INDEX CONCURRENTLY jhw_google_cloud_message_registration_records_on_user_id ON google_cloud_message_registration_records (user_id);

CREATE INDEX CONCURRENTLY jhw_group_permissions_on_company_id ON group_permissions (company_id);

CREATE INDEX CONCURRENTLY jhw_group_permissions_on_group_id ON group_permissions (group_id);

CREATE INDEX CONCURRENTLY jhw_group_permissions_on_pipeline_id ON group_permissions (pipeline_id);

CREATE INDEX CONCURRENTLY jhw_import_statuses_on_company_id ON import_statuses (company_id);

CREATE INDEX CONCURRENTLY jhw_import_statuses_on_user_id ON import_statuses (user_id);

CREATE INDEX CONCURRENTLY jhw_integration_tokens_on_owner_id ON integration_tokens (owner_id);

CREATE INDEX CONCURRENTLY jhw_invitations_on_recipient_id ON invitations (recipient_id);

CREATE INDEX CONCURRENTLY jhw_invitations_on_sender_id ON invitations (sender_id);

CREATE INDEX CONCURRENTLY jhw_leads_on_assignee_id ON leads (assignee_id);

CREATE INDEX CONCURRENTLY jhw_leads_on_converted_contact_id ON leads (converted_contact_id);

CREATE INDEX CONCURRENTLY jhw_leads_on_converted_deal_id ON leads (converted_deal_id);

CREATE INDEX CONCURRENTLY jhw_leads_on_customer_source_id ON leads (customer_source_id);

CREATE INDEX CONCURRENTLY jhw_meetings_on_company_user_id ON meetings (company_user_id);

CREATE INDEX CONCURRENTLY jhw_mobile_push_tokens_on_user_id ON mobile_push_tokens (user_id);

CREATE INDEX CONCURRENTLY jhw_notification_channels_on_company_user_id ON notification_channels (company_user_id);

CREATE INDEX CONCURRENTLY jhw_organization_suggestions_on_company_id ON organization_suggestions (company_id);

CREATE INDEX CONCURRENTLY jhw_organizations_on_assignee_id ON organizations (assignee_id);

CREATE INDEX CONCURRENTLY jhw_organizations_on_company_id ON organizations (company_id);

CREATE INDEX CONCURRENTLY jhw_recent_searches_on_target_entity_id ON recent_searches (target_entity_id);

CREATE INDEX CONCURRENTLY jhw_reminders_on_company_user_id ON reminders (company_user_id);

CREATE INDEX CONCURRENTLY jhw_saved_searches_on_company_user_id ON saved_searches (company_user_id);

CREATE INDEX CONCURRENTLY jhw_serialized_entities_on_company_id ON serialized_entities (company_id);

CREATE INDEX CONCURRENTLY jhw_stage_entry_logs_on_company_id ON stage_entry_logs (company_id);

CREATE INDEX CONCURRENTLY jhw_stage_entry_logs_on_entity_id ON stage_entry_logs (entity_id);

CREATE INDEX CONCURRENTLY jhw_stage_entry_logs_on_pipeline_id ON stage_entry_logs (pipeline_id);

CREATE INDEX CONCURRENTLY jhw_stage_entry_logs_on_previous_stage_id ON stage_entry_logs (previous_stage_id);

CREATE INDEX CONCURRENTLY jhw_stage_entry_logs_on_stage_id ON stage_entry_logs (stage_id);

CREATE INDEX CONCURRENTLY jhw_trigger_logs_on_entity_id ON trigger_logs (entity_id);

CREATE INDEX CONCURRENTLY jhw_typed_properties_on_company_id ON typed_properties (company_id);

CREATE INDEX CONCURRENTLY jhw_typed_properties_on_property_owner_id ON typed_properties (property_owner_id);

CREATE INDEX CONCURRENTLY jhw_user_feedback_responses_on_company_id ON user_feedback_responses (company_id);

CREATE INDEX CONCURRENTLY jhw_user_feedback_responses_on_user_id ON user_feedback_responses (user_id);

CREATE INDEX CONCURRENTLY jhw_zero_input_ingestions_on_company_id ON zero_input_ingestions (company_id);

CREATE INDEX CONCURRENTLY jhw_zero_input_ingestions_on_user_id ON zero_input_ingestions (user_id);
