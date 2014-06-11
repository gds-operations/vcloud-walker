# Contributing to vCloud Walker

We really welcome contributions.

## A quick guide on how to contribute

1. Clone the repo:

        git clone git@github.com:gds-operations/vcloud-walker.git

2. Run `bundle` to get the required dependecies

3. Run the tests. Pull requests that add features must include unit tests,
   so it is good to ensure you've got them passing to begin with.

        bundle exec rake

   If you have access to a live environment for testing, it would be great
   if you could run the integration tests too - for more details on the
   set-up for that, please see the [integration tests README]
   (https://github.com/gds-operations/vcloud-walker/blob/master/spec/integration/README.md)

4. Add your functionality or bug fix and a test for your change. Only refactoring and
   documentation changes do not require tests. If the functionality is at all complicated
   then it is likely that more than one test will be required. If you would like help
   with writing tests please do ask us.

5. Make sure all the tests pass, including the integration tests if possible.

6. Update the [CHANGELOG](https://github.com/gds-operations/vcloud-walker/blob/master/CHANGELOG.md)
   with a short description of what the change is. This may be a feature, a bugfix, or an
   API change. If your change is documenation or refactoring, you do not need to add a line
   to the CHANGELOG.

7. Fork the repo, push to your fork, and submit a pull request.

## How soon will we respond?

We will comment on your pull request within two working days. However, we might not be able to review it immediately.

We may come back to you with comments and suggestions, and if we would like you to make changes, we will close the pull request as well as adding details of the changes we'd like you to make.

If you feel your pull request has been outstanding too long, please feel free to bump it by making a comment on it.

## Guidelines for making a pull request

    The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
    "SHOULD NOT", "RECOMMENDED",  "MAY", and "OPTIONAL" in this document are to be
    interpreted as described in RFC 2119.

## In order for a pull request to be accepted, it MUST

- Include at least one test (unless it is documentation or refactoring). If you have any questions about how to write tests, please ask us, we will be happy to help
- Follow our [Git style guide](https://github.com/alphagov/styleguides/blob/master/git.md)
- Include a clear summary in the pull request comments as to what the change is and why
  you are making it
- Be readable - we might ask you to change unclear variable names or obscure syntactic sugar
- Have [good commit messages](http://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message)
  that explain the change being made in that commit. Don't be afraid to write a lot in the
  detail.

## In order for a pull request to be accepted, it SHOULD

- Include a line in the CHANGELOG unless it is a refactoring or documentation change
- If it is code, follow our [Ruby style guide](https://github.com/alphagov/styleguides/blob/master/ruby.md)
- If it is documentation, follow the [GDS content style guide](https://www.gov.uk/design-principles/style-guide/style-points)
