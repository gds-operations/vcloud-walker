# VCloud Walker

Vcloud-walker is a command line tool, to describe different vcloud entities.

## Usage
To find usage, run `bundle exec thor list`.

You can perform following operations with walker.

#### Walk vdcs :
<pre>`bundle exec thor vcloud_walk:vdcs` </pre>         
describes all vdcs within given organization. This include vapp, vm and network information
<br/><br/>

#### Walk catalogs:
<pre> `bundle exec thor vcloud_walk:catalogs` </pre>     
describes all catalogs and catalog items within given organization.

  
#### Walk organization networks : 
<pre> `bundle exec thor vcloud_walk:networks` </pre>      
 describes all organization networks


#### Walk edgegateways :
 <pre> `bundle exec thor vcloud_walk:edgegateways` </pre>   
describes all edgegateway for given organization. Each edgegateway includes configuration for firewall, load balancer and nat services.


### Credentials

You will need credentials for your vmware environment. Vcloud-walker internally uses fog to query vmware api.
You need to create .fog.To understand how to write .fog file, check 'Credentials' section here => http://fog.io/about/getting_started.html.

An example of .fog file is:
<pre>
default:
  vcloud_director_username: 'user-id@org-id'
  vcloud_director_password: 'password'
  vcloud_director_host: 'api-endpoint'
</pre>  
  
  
### Output

The output is in JSON format. Find sample output look into docs/examples directory. 


