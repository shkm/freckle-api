# freckle-api

**Note** Back at work and terribly busy after the Christmas holidays, so I
won't be working on this for a week or two, but it's certainly not abandoned!

Freckle API client for v2.

[![Gem Version](https://badge.fury.io/rb/freckle-api.svg)](https://badge.fury.io/rb/freckle-api)
[![Dependency Status](https://gemnasium.com/shkm/freckle-api.svg)](https://gemnasium.com/shkm/freckle-api)
[![Build Status](https://travis-ci.org/shkm/freckle-api.svg)](https://travis-ci.org/shkm/freckle-api)
[![Code Climate](https://codeclimate.com/github/shkm/freckle-api/badges/gpa.svg)](https://codeclimate.com/github/shkm/freckle-api)
[![Test Coverage](https://codeclimate.com/github/shkm/freckle-api/badges/coverage.svg)](https://codeclimate.com/github/shkm/freckle-api/coverage)

This is still in development and not ready to use yet.

I intend to implement timing functonality only to begin with,
adding more management features later on. In order to get it to a
usable/useful state, the following needs to be done:

## TODO

There's a lot to do right now, but to get this API into a useful state
for users simply logging their time, the following is mandatory:

- Implement timer:
  - start
  - pause
  - log
  - discard

Longer-term TODO items are, in general order of importance:

- Implement entries
- Error handling, retry on fail.
- Rate limiting -- Freckle only allows two requests per second per IP, so consider
  other users on the network as well. Goes with error handling.
- The entire v2 API that is currently available
- Better testing of requests
- DRYer tests
- Whatever other TODOs or FIXMEs in the codebase.
