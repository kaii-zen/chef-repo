@mysql @wip
Feature: Automatically deploy a database server
  In order to make a database server available to our application servers

  Background:
    * I have a server called "mysql"
    * "mysql" is running "ubuntu" "precise"
    * "mysql" has been provisioned
    * the "chef-client::service" recipe has been added to the "mysql" run list
    * the "dbmaster" role has been added to the "mysql" run list
    * the chef-client has been run on "mysql"
    * I ssh to "mysql" with the following credentials:
      | username | keyfile        |
      | root     | ../.ssh/id_rsa |


  Scenario: mysqld is running
    When I run "ps aux | grep mysqld | grep -v grep"
      Then I should see "mysqld" in the output

  Scenario: data volume should be an mdadm raid device
    When I run "mount | grep /mnt/data"
      Then I should see "/dev/md" in the output
