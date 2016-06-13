# Redmine sample plugin
require 'redmine'
require File.dirname(__FILE__) + '/lib/zendesk'

Redmine::Plugin.register :redmine_zendesk_ticket_updater do
  name 'Redmine Zendesk Ticket Updater'
  author 'Stephen Davidson'
  description 'Updates associated Zendesk tickets when Redmine issues are updated'
  version '0.0.1'
  settings :default => {
      'zendesk_subdomain' => 'http://support.zendesk.com/',
      'zendesk_username' => 'zendeskuser',
      'zendesk_password' => 'zendeskpassword',
      'field' => nil,
      'redmine_url' => 'https://your.redmine.url/'
    },
    :partial => 'settings/zendesk_plugin_settings'
end
