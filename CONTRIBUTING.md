# Contributing to the Cucumber Aruba Project

## Introduction

We would love to get help from you as "user" and "contributor".

**Users**

* Tell us how "Aruba" works for you
* Spread the word if you like our work and please tell us if somethings is (utterly) wrong
* Encourage people in testing their code and keep communicating their needs

**Contributors**

* Send us bug fixes
* Add new features to the code
* Discuss changes
* Add missing documentation
* Improve our test coverage

The rest of this document is a guide for those maintaining Aruba, and others
who would like to submit patches.

## Contributing to the "aruba" project

It would be great if all people who want to contribute to the "aruba" project
&mdash; contributors and maintainers &mdash; follow the guidelines in this
section. There are also "Getting started"-sections both for
[contributors](#getting-started-as-a-contributor) and
[maintainers](#getting-started-as-a-maintainer).

### Issues

About to create a new Github Issue? We appreciate that. But before you do,
please learn our basic rules:

* This is not a support forum. If you have a question, please go to
  [The Cukes Google Group](http://groups.google.com/group/cukes).
* Do you have an idea for a new feature? Then don't expect it to be implemented
  unless you or someone else sends a
  [pull request](https://help.github.com/articles/using-pull-requests). It
  might be better to start a discussion on
  [the google group](http://groups.google.com/group/cukes).
* Reporting a bug? Just follow our comments in the issue template
* We love [pull requests](https://help.github.com/articles/using-pull-requests).
  The same here: Please consider our comments within the template we provide
  for your pull request(s).


### Pull Requests

**Contributors**

Please...

* Fork the project. Make a branch for your change.
* Make your feature addition or bug fix &mdash; if you're unsure if your
  addition will be accepted, open an issue for discussion first
* Make sure your patch is well covered by tests. We don't accept changes that
  aren't tested.
* Please do not change the Rakefile, version, or history.
  (If you want to have your own version, that is fine but
  bump version in a commit by itself so we can ignore it when we merge your change.)
* Make sure your pull request complies with our development style.
* Rebase your branch if needed to reduce clutter in our git history.
* Make sure you don't break other people's code &mdash; On major changes: First
  deprecate, then bump major version, then make breaking changes,
* Split up your changes into reviewable "git"-commits which combine all
  lines/files relevant for a single change.
* Send us a pull request.

**Maintainers**

* Use pull requests for larger or controversial changes made by yourself or
  changes you might expected to break the build.
* Commit smaller changes directly to master, e.g. fixing typos, adding tests or
  adding documentation.
* Update [CHANGELOG.md](CHANGELOG.md) when a pull request is merged.
* Make sure all tests are green before merging a pull request.

### Development style

* We try to follow the recommendations in the
  [Ruby Community Style Guide](https://github.com/bbatsov/ruby-style-guide) and use
  [`rubocop`](https://github.com/bbatsov/rubocop) to "enforce" it. Please see
  [.rubocop.yml](.rubocop.yml) for exceptions.
* There should be `action`-methods and `getter`-methods in `aruba`. Only the
  latter should return values. Please expect the first ones to return `nil`.
* Add documentation (aka acceptance tests) for new features using `aruba`'s
  steps and place them some where suitable in [here](features/).
* Add unit tests where needed to cover edge cases which are not (directly)
  relevant for users.
* Add developer documentation in [`yardoc`](http://yardoc.org/) to all relevant
  methods added.
* Format your commits messages following those seven rules &mdash; see
  [this blog post](http://chris.beams.io/posts/git-commit/) for a well written
  explanation about the why.
  1. Separate subject from body with a blank line
  2. Limit the subject line to 50 characters
  3. Capitalize the subject line
  4. Do not end the subject line with a period
  5. Use the imperative mood in the subject line
  6. Wrap the body at 72 characters
  7. Use the body to explain what and why vs. how (optional if subject is self-explanatory)

## Getting started as a "Contributor"

### Bootstrap environment

To get started with `aruba`, you just need to bootstrap the environment by
running the following command.

~~~bash
# Bootstrap environment
bin/bootstrap
~~~

### Running tests

Make sure you bootstrap the environment first. Then run the following command
to run the test suite.

```bash
# Run the test suite
bin/test

# Or use these rake tasks:

# Run the whole test suite
rake test
# Run RSpec tests
rake test:rspec
# Run Cucumber features
rake test:cucumber
# Run Cucumber features which are "WORK IN PROGRESS" and are allowed to fail
rake test:cucumber_wip
```

If you have problems because our assumptions about your local setup are wrong,
try the follwing instead. This requires the `docker`-command/project to be installed on
your local system.

```bash
# Build the docker container
bundle exec rake docker:build

# Build with disabled cache
bundle exec rake 'docker:build[false]'

# Build image with version tag
bundle exec rake 'docker:build[false, 0.1.0]'

# Run the whole test suite in "docker"-container
RUN_IN_DOCKER=1 bin/test

# Run only selected scenario
RUN_IN_DOCKER=1 bin/test cucumber features/steps/command/shell.feature:14
```

### Installing your own gems used for development

A `Gemfile.local`-file can be used to have your own gems installed to support
your normal development workflow.

Example:

~~~ruby
gem 'pry'
gem 'pry-byebug'
gem 'byebug'
~~~

### Running a developer console

If you want to try out the Aruba api, you canuse the interactive aruba console:

```bash
bin/console
```

This will start an IRB console with Aruba's API loaded.

### Linting

Aruba's Rakefile provides the following linting tasks

```bash
bundle exec rake lint                         # Run all linters
bundle exec rake lint:coding_guidelines       # Lint our code with "rubocop"
bundle exec rake lint:licenses                # Check for relevant licenses in project
bundle exec rake lint:travis                  # Lint our .travis.yml
```

### Building and installing your local Aruba version

You can use the following rake tasks to build and install your work-in-progress locally:

```bash
# Build your copy
bundle exec rake rubygem:build
# Build and install your copy
bundle exec rake rubygem:install
# Build and install your copy without network access
bundle exec rake rubygem:install:local
```

## Getting started as a "Maintainer"

### Release Process

* Bump the version number in `lib/aruba/version.rb`
* Make sure `CHANGELOG.md` is updated with the upcoming version number, and has
  entries for all fixes.
* No need to add a `CHANGELOG.md` header at this point - this should be done
  when a new change is made, later.
* If a major version is released, update the `still`-branch which points to
  "old" major version

Now release it

~~~bash
# update dependencies
bundle update

# Run test suite
bin/test

# Release gem
git commit -m "Version bump"
bin/release

# If it's a major relase:
# Merge changes back to have an correct documentation
git checkout still
git merge master
git push
~~~

Now send a PR to https://github.com/cucumber/website adding an article
with details of the new release and merge it - an aruba maintainer should
normally allowed to merge PRs on `cucumber/website`. A copy of an old
announcement can be used as basis for the new article. After this send an email
with the link to the article to cukes@googlegroups.com.

### Gaining Release Karma

To become a release manager, create a pull request adding your name to the list
below, and include your Rubygems email address in the ticket. One of the
existing Release managers will then add you.

Current release managers:
  * Aslak Hellesøy ([@aslakhellesoy](https://github.com/aslakhellesoy))
  * Matt Wynne ([@mattwynne](https://github.com/mattwynne))
  * Matijs van Zuijlen ([@mvz](https://github.com/mvz))

To grant release karma, issue the following command:

    gem owner aruba --add <NEW OWNER RUBYGEMS EMAIL>
