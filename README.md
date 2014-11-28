# Overview

A small web service for computing word anagrams ([deployed on Heroku](http://anagramservice.herokuapp.com))

## Running

Install the application dependencies by calling `bundle install` and execute
`bundle exec rackup` from within the project directory. The service will then
be accessible from localhost on port 9292.

## Acceptance test

An acceptance test can be run by executing `bundle exec ruby test/acceptance.rb`
