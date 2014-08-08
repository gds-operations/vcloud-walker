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
