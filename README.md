# Decidim::AnonymousProposals

Transform proposals component to allow not signed in users creation of
proposals. For this the proposals created anonymously will be linked with
a special anonymous users group. There is a task to create/update anonymous
groups in organizations explained in Installation section.


## Installation

Add this line to your application's Gemfile:

```ruby
gem "decidim-anonymous_proposals", git: "https://github.com/PopulateTools/decidim-module-anonymous_proposals", branch: :main

```

And then execute:

```bash
bundle
```

To have the functionality available there must be at least one anonymous user group.
An anonymous user group is a user group with `{ anonymous: true }` present in the
`extended_data` attribute. There is a task to create automatically or update the
first anonymous group of organizations (or a specific organization if its id is
provided).

The task accepts the following arguments:

1. Name of the group (default: "Anonymous")
2. Nickname of the group (default: "anonymous")
3. Email of the group (default: "anonymous@example.org")
4. organization_id. This argument is optional, if not provided a group is generated
   with the previous configurations for each organization

Example of use:

```bash
rake decidim_anonymous_proposals:generate_anonymous_group["Aportaciones anónimas",anonima,anonymous@example.org]
```

## Contributing

See [Decidim](https://github.com/decidim/decidim).

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.
