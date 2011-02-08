Dydra Docs Application
======================

Ultrasimple CMS and content for documentation of the Dydra platform. The
production site is at <http://docs.dydra.com/>.

If you'd like to propose an edit to the Dydra docs, fork this repo, then
send us a pull request.

Dependencies
------------

The application presently requires Ruby 1.8.7, and will not work on Ruby
1.9.2. To be remedied.

Required Ruby gems:

* [Sinatra](http://rubygems.org/gems/sinatra)
* [RDiscount](http://rubygems.org/gems/rdiscount)

The application loads content from the `docs/` subdirectory. Pages are
served with a one-hour cache setting.

Kudos
-----

Implemented using the excellent <http://github.com/heroku/heroku-docs>
application. The CMS was written by Ryan Tomayko and Adam Wiggins. The code
is released under the MIT License.

License
-------

All rights reserved on the content (text files in the `docs/` subdirectory),
although you're welcome to modify these for the purpose of suggesting edits.
