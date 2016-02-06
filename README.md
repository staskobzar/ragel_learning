# UriScanner

> [![codecov.io](https://codecov.io/github/staskobzar/uri_scanner/coverage.svg?branch=master)](https://codecov.io/github/staskobzar/uri_scanner?branch=master) [![Build Status](https://travis-ci.org/staskobzar/uri_scanner.svg?branch=master)](https://travis-ci.org/staskobzar/uri_scanner)

Simple library that parses URI or scans input text for URIs.
RFC3986 compliant. SIP URIs parsing implemented following RFC3261.

This library is based on [Ragel State Machine Compiler](http://www.colm.net/open-source/ragel/).
Ragel is great software created by Dr. Adrian D. Thurston.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uri_scanner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uri_scanner

## Usage

Start with:
```ruby
require 'uri_scanner'
```
There are only four core methods:

```scan```: Scans text and return array of found URIs
```ruby
URIScanner.scan(text)
```

```parse_uri```: Parses uri and return object that allows access to URI segments.
Raises ```URIParserError```
```ruby
uri = URIScanner.parse_uri(uri_string)
uri.scheme
uri.host
uri.port
uri.userinfo
uri.username
uri.password
uri.path
uri.query
uri.fragment
uri.param
uri.header
```

```scan_and_parse```: Same as ```scan```, but retruns array of parsed URI objects (see parse_uri)
```ruby
URIScanner.scan_and_parse(text)
```

```is_ip_valid?```: Additional methos that validates IPv4/IPv6 (RFC3986 ABNF)
```ruby
URIScanner.is_ip_valid?(ip_string)
```

Check folder "example".

## Contributing

1. Fork it ( https://github.com/[my-github-username]/uri_scanner/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
