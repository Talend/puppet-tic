# puppet-tic

TIC installation with Puppet

  * [What You Get From This control\-repo](#what-you-get-from-this-control-repo)
  * [Requirements](#requirements)
  * [Setup](#setup)


## What You Get From This control-repo

This repository exists as a talend tic puppet module

## Requirements
  - Epel Repository
  - Ruby >= 2.1.10
  - Bundler >= 1.13.6
  - ruby-augeas
## Setup
### Install
Clone this repo
``` bash
git clone git@github.com:Talend/talend-tic.git
```

### Testing Setup
Run bundler inside the checkout to statisfy requirents
``` bash
bundle install --path=vendor/bundle --without=development
```
Run puppet-rspec test for all site modules with
``` bash
sh scripts/test_runner.sh
```

### Development tests
[You need vagrant installed for this](https://www.vagrantup.com/downloads.html) and VirtualBox and at least 6Go RAM free.

To see the script usage:

``` bash
scripts/local_dev_tests.sh -h
```

Launching all the test, cleaning everything before:

``` bash
scripts/local_dev_tests.sh -c
```


For manually running rspec or beaker test per module change in the module dir and manually run
 ``` bash
 bundle exec rake beaker
 ```
