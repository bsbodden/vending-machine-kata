# Solution Notes for Vending Machine Kata

This solution uses Ruby and RSpec. The commits reflect the process that I've used
to pair-program remotely in the past (mostly in the context of helping/guiding more
junior team members):

- *Test ping-pong*: One person writes a spec, the other person passes it.
- *No broken commits*: A to-be-implemented feature is represented by a pending spec
- Whenever possible, refactor the code first then the tests/specs unless the spec change
  reflects a change in design/direction

## Setup

- Clone repository `git clone https://github.com/bsbodden/vending-machine-kata.git`
- If using RVM or rbenv I've provided .ruby-version and .ruby-gemset files that can be overriden
  by providing your own .rvmrc
- Install [Bundler](http://bundler.io/): `$ gem install bundler`
- Bundle install: `$bundle install`
- Run the specs: `rspec`
