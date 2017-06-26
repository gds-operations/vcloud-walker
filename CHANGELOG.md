## 5.1.0 (2017-06-23)

  - Remove support for any Ruby older than v2.2.2.
  - Add support for Ruby 2.3.0 and 2.4.0.
  - Various bug fixes
  - Updated dependencies

## 5.0.0 (2015-10-20)

  - Remove support for Ruby 1.9.3.
  - Relax dependency on vCloud Core to anything in the 1.x branch to
    make installing this gem alongside other vCloud gems easier.

## 4.0.0 (2015-01-22)

  - Update dependency on vCloud Core to 1.0.0 since it is now stable.

## 3.6.0 (2014-12-03)

Features:

  - Update vCloud Core to 0.16.0 for `vcloud-logout` utility.

## 3.5.0 (2014-10-15)

Features:

  - Upgrade dependency on vCloud Core to 0.13.0. An error will now be raised if
    your `FOG_CREDENTIAL` environment variable does not match the information
    stored against a vCloud Director session referred to by `FOG_VCLOUD_TOKEN`,
    so as to guard against accidental changes to the wrong vCloud Director
    organization.

## 3.4.0 (2014-09-11)

  - Upgrade dependency on vCloud Core to 0.11.0 which prevents plaintext
    passwords in FOG_RC. Please use tokens via vcloud-login as per
    the documentation: http://gds-operations.github.io/vcloud-tools/usage/

## 3.3.1 (2014-08-12)

  - Upgrade dependency on vCloud Core to 0.10.0 for parity with other vCloud
    Tools gems and prevent problems resolving dependencies.

## 3.3.0 (2014-08-08)

Depend on vCloud Core version 0.7.0, which:

  - Includes a new vcloud-login tool for fetching session tokens without the
    need to store your password in a plaintext FOG_RC file.
  - Deprecates the use of :vcloud_director_password in a plaintext FOG_RC file.
    A warning will be printed to STDERR at load time. Please use vcloud-login
    instead.

## 3.2.3 (2014-07-14)

Bugfixes:

  - Prevent an "undefined method for nil:Nilclass" exception when
    encountering a vApp that has no networks attached.

API changes:

  - Vcloud::Walker::walk now returns an exception if provided an invalid
    resource type instead of returning a `nil` object and printing the valid
    options to STDOUT.

Bugfixes:

  - Rename Rake integration test from 'integration_test' to 'integration' for consistency with other vCloud Tools

## 3.2.2 (2014-05-01)

  - Use pessimistic version dependency for vcloud-core

## 3.2.1 (2014-04-22)

Bugfixes:

  - Requires vCloud Core v0.0.12 which fixes issue with progress bar falling over when progress is not returned

## 3.2.0 (2014-04-14)

Features:

  - Support v5.1 API over VCloud Director 5.5
  - Require fog v1.21 to allow use of FOG_VCLOUD_TOKEN via ENV as an alternative to a .fog file

## 3.1.2 (2014-02-07)

  - First release of gem
