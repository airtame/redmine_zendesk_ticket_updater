require 'redmine'
require 'zendesk_api'

class ZendeskListener < Redmine::Hook::Listener
  # We need this helper for rendering the detail stuff, and the accessors to fake it out
  include ActionView::Helpers::IssuesHelper
  attr_accessor :controller, :request
  
  def controller_issues_edit_after_save(context)
    zendesk_client = ZendeskAPI::Client.new do |config|
      subdomain = Setting.plugin_redmine_zendesk_ticket_updater['zendesk_subdomain']
      config.url = "https://#{subdomain}.zendesk.com/api/v2" # e.g. https://mydesk.zendesk.com/api/v2
      config.username = Setting.plugin_redmine_zendesk_ticket_updater['zendesk_username']
      config.password = Setting.plugin_redmine_zendesk_ticket_updater['zendesk_password']
      config.retry = true
    end


    puts context.inspect
    self.controller = context[:controller]
    self.request = context[:request]
    
    custom_field = CustomField.find(Setting.plugin_redmine_zendesk_ticket_updater['redmine_custom_field_id'])
    return unless custom_field
    
    journal = context[:journal]
    return unless journal
    
    issue = context[:issue]
    return unless issue && issue.custom_value_for(custom_field)
    
    zendesk_id_value = issue.custom_value_for(custom_field)
    return unless zendesk_id_value
    
    zendesk_ids = zendesk_id_value.to_s.split(',').map(&:strip)
    return if zendesk_ids.empty?
    
    zendesk_ids.each do |zendesk_id|
      issue_url = "#{Setting.plugin_redmine_zendesk_ticket_updater['redmine_url']}/issues/#{issue.id}"
      comment = "Redmine ticket #{issue_url} was updated by #{journal.user.name}:\n\n"
      
      for detail in journal.details
        comment << show_detail(detail, true) rescue ""
        comment << "\n"
      end
      
      if journal.notes && !journal.notes.empty?
        comment << journal.notes
      end

      ticket = ZendeskAPI::Ticket.find(zendesk_client, :id => zendesk_id)
      ticket.comment = ZendeskAPI::Ticket::Comment.new(zendesk_client, :value => comment, :public => false)
      ticket.save!
    end
  end
end
