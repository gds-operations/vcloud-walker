# VCloud Walker

Vcloud-walker is a command line tool, to describe different VMware vCloud Director 5.1 entities. It uses Fog under
the hood.

## Usage
To find usage, run `bundle exec thor list`.

You can perform following operations with walker.

#### Walk vdcs :
    bundle exec thor vcloud_walk:vdcs

describes all vdcs within given organization. This includes vapp, vm and network information

#### Walk catalogs:
    bundle exec thor vcloud_walk:catalogs

describes all catalogs and catalog items within given organization.

#### Walk organization networks : 
     bundle exec thor vcloud_walk:networks

describes all organization networks

#### Walk edgegateways :
    bundle exec thor vcloud_walk:edgegateways

describes all edgegateway for given organization. Each edgegateway includes configuration for firewall, load balancer
and nat services.

#### Walk entire organization : 
     bundle exec thor vcloud_walk:organization

describes the entire organization, which includes edgegateway, catalogs,
networks and vdcs within an organization

### Credentials

You will need to specify the credentials for your vmware environment. As Vcloud-walker uses fog to query the vmware api,
you will need to create a `.fog` file containing these credentials.

An example of .fog file is:
````
default:
  vcloud_director_username: 'user_id@org_id'
  vcloud_director_password: 'password'
  vcloud_director_host: 'api_endpoint'
````

To understand more about `.fog` files, visit the 'Credentials' section here => http://fog.io/about/getting_started.html.

### Output

Walker can output data in JSON or YAML format. The default output format
is JSON.
You can use command line option --yaml for yaml output.

Find sample json output in docs/examples directory.

