= gem-tldr

* https://github.com/drbrain/gem-tldr

== DESCRIPTION:

Are your gems taking up too much disk space?  Documentation got you down?
Comments stuck in your craw?  Tests taking too much space?  Fix all that by
with <tt>gem tldr</tt>.

I know that disk space is at a premium these days with an introductory netbook
or a small AWS EC2 instance containing a mere 160GB.  <tt>gem tldr</tt>
removes the test directory, build artifacts like .c and .h files, comments in
your ruby source files and comments in your ruby source.

== FEATURES/PROBLEMS:

* May destroy strings with embedded # characters
* There's no way to know something is broken as tests have been deleted

== SYNOPSIS:

  gem tldr

If you don't want the TL;DR you can provide -V.

If you want to see what <tt>gem tldr</tt> would do to your installed gems
provide <tt>--dry-run</tt>.

You can restore your installed gems through

  gem pristine

== REQUIREMENTS:

* Fearlessness

== INSTALL:

Don't

== DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

== LICENSE:

(The MIT License)

Copyright (c) 2011 Eric Hodel

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
