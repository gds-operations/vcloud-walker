# VCloud Walker

Vcloud-walker is a command line tool, to describe different VMware vCloud
Director 5.1 entities. It uses Fog under the hood.

## Installation

Add this line to your application's Gemfile:

    gem 'vcloud-walker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vcloud-walker

## Usage
To find usage, run `vcloud-walk`.

You can perform following operations with walker.

#### Walk vdcs:
   vcloud-walk vdcs

describes all vdcs within given organization. This includes vapp, vm and network
information.

#### Walk catalogs:
    vcloud-walk catalogs

describes all catalogs and catalog items within given organization.

#### Walk organization networks:
     vcloud-walk networks

describes all organization networks.

#### Walk edgegateways:
    vcloud-walk edgegateways

describes all edgegateway for given organization. Each edgegateway includes
configuration for firewall, load balancer and nat services.

#### Walk entire organization:
     vcloud-walk organization

describes the entire organization, which includes edgegateway, catalogs,
networks and vdcs within an organization.

### Credentials

You will need to specify the credentials for your VMware environment.
Vcloud-walker uses fog to query the VMware api,
which offers two ways to do this.

#### 1. Create a `.fog` file containing your credentials

An example of .fog file is:

````
default:
  vcloud_director_username: 'user_id@org_id'
  vcloud_director_password: 'password'
  vcloud_director_host: 'api_endpoint'
````

To understand more about `.fog` files, visit the 'Credentials' section here
=> http://fog.io/about/getting_started.html.

### 2. Log on externally and supply your session token

You can choose to log on externally by interacting independently with the API
and supplying your session token to the tool by setting the `FOG_VCLOUD_TOKEN`
ENV variable. This option reduces the risk footprint by allowing the user to
store their credentials in safe storage. The default token lifetime is '30
minutes idle' - any activity extends the life by another 30 mins.

A basic example of this would be the following:

    curl
       -D-
       -d ''
       -H 'Accept: application/*+xml;version=5.1' -u '<user>@<org>'
       https://host.com/api/sessions

This will prompt for your password.

From the headers returned, select the header below

     x-vcloud-authorization: AAAABBBBBCCCCCCDDDDDDEEEEEEFFFFF=

Use token as ENV var FOG_VCLOUD_TOKEN

    FOG_VCLOUD_TOKEN=AAAABBBBBCCCCCCDDDDDDEEEEEEFFFFF= vcloud-walk organization

### Output

Walker can output data in JSON or YAML format. The default output format is JSON.
You can use command line option ```--yaml``` for yaml output.

Find sample json output in docs/examples directory.

## The vCloud API

vCloud Tools currently use version 5.1 of the [vCloud API](http://pubs.vmware.com/vcd-51/index.jsp?topic=%2Fcom.vmware.vcloud.api.doc_51%2FGUID-F4BF9D5D-EF66-4D36-A6EB-2086703F6E37.html). Version 5.5 may work but is not currently supported. You should be able to access the 5.1 API in a 5.5 environment, and this *is* currently supported.

The default version is defined in [Fog](https://github.com/fog/fog/blob/244a049918604eadbcebd3a8eaaf433424fe4617/lib/fog/vcloud_director/compute.rb#L32).

If you want to be sure you are pinning to 5.1, or use 5.5, you can set the API version to use in your fog file, e.g.

`vcloud_director_api_version: 5.1`

## Debugging

`export EXCON_DEBUG=true` - this will print out the API requests and responses.

`export DEBUG=true` - this will show you the stack trace when there is an exception instead of just the message.
