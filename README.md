[![Build Status](https://travis-ci.org/SobanVuex/chef-nginx.png)](https://travis-ci.org/SobanVuex/chef-nginx)

What does it do
---------------

Install Nginx and modules from source using @opscode/chef

Attributes
----------

You can customize almost all nginx configurations using attributes.
Sample json for chef-solo is provided

Modules
-------

Both core and user modules can be added/removed using attributes

**Core modules**

    ...
      "nginx": {
        "core_modules": ["--with-http_ssl_module", "--without-http_memcached_module"]
      },
    ....

**User modules** [identifier, [source, version]]

    ...
      "nginx": {
        "user_modules": [["devel-kit", ["https://github.com/simpl/ngx_devel_kit.git", "master"]]]
      },
    ....

TODO
----

- Sleep (4am)
- Provide attributes for more nginx directives and modules

If you have ideas, share them!

License and Author
------------------

Author: Alex Soban - Planbox Inc. (<soban@planbox.com>)  
Copyright: 2012, Alex Soban - Planbox Inc.  
Copyright: 2012, Planbox Inc.

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software
and associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
OR OTHER DEALINGS IN THE SOFTWARE.
