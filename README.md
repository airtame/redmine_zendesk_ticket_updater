# Redmine Zendesk Ticket Updater
Update zendesk tickets when redmine issues are updated with a comment of the redmine changes.

## Installation

Installs the same as any Redmine 2.x or 3.x plugin. Please [read this guide](http://www.redmine.org/projects/redmine/wiki/Plugins#Installing-a-plugin) for basic tips.

1. Unzip or clone into to your `./plugins` folder (e.g. `/path/to/redmine/plugins/redmine_zendesk_ticket_updater`)
2. Run `bundle install` to pick up the necessary Gems
3. Restart your Redmine instance
4. Go to `Administration` > `Plugins` to verify that the plugin is shown
5. Click `Configure`

## Configuration

Pre-requisites:

* Zendesk: Have a user account with the ability to comment on tickets
* Redmine: Have a custom text field to issues that will comment on zendesk tickets. Tickets should be added
as comma separated values

Fields in plugin configuration (all are required for the plugin to work):

| Field        | Value           |
| ------------- | ------------- |
| Redmine Url      | Url for your redmine installation ex. http://redmine.example.com |
| Redmine Custom Field ID | Id for custom redmine field. To find the field id ex. http://redmine.example.com/custom_fields.xml      |
| Zendesk Subdomain | Subdomain for your zendesk site. ex. example.airtame.com -> example      |
| Zendesk Username | Zendesk Username that will post comments on zendesk tickets |
| Zendesk Password | Passwrod for above zendesk user |

## Credit
Thanks to Zwily who made the original. This is a portover for redmine 2.x and 3.x compatibility:

[Zwily's Redmine Zendesk plugin](https://github.com/zwily/redmine_zendesk)
