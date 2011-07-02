# SMPL Server

## Summary

SMPL is used for monitoring tcp connections and gathering stats on those connections. It includes an EventMachine-based tcp server, a web front-end running on Sinatra Synchrony (async), and a pub/sub bayeux server running on Faye. Gems are managed by Bundler. Includes a full RSpec suite of tests.

## Technologies and Gems Used

* Rack
* EventMachine
* Synchrony
* Sinatra
* Faye(bayeux)
* CoffeeScript (through rack-coffee)
* Sass

## Development

This gem is still under active development and is not ready for your use. Please watch the repo, or lend a hand if you like.

## License

SMPL is licensed under the MIT license.

Copyright (c) 2011 Adam Zaninovich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
