# VCloud Walker

Vcloud-walker is a command line tool, to describe different vcloud entities.

To find usage, run `bundle exec thor list`.

You can issue following commands 

`bundle exec thor vcloud_walk:catalogs`      # describe all catalogs within given organization
`bundle exec thor vcloud_walk:edgegateways`  # describe settings within edge gateways
`bundle exec thor vcloud_walk:networks`      # describe all networks within given organization
`bundle exec thor vcloud_walk:vdcs`          # describe all vdcs within given organization

You need your credentials for your vmware environment:

    API_USERNAME(which is vcloud-user-id@organisation-id)
    
    API_PASSWORD
    
The output is in JSON format
