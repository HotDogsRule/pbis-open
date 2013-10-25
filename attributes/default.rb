#
# Cookbook Name:: pbis-open
# Attributes:: default
#
# Copyright 2013, Noah Mehl
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

default["pbis_open"]["version"] = "7.5.2.1527"
default["pbis_open"]["domain"] = "CONTOSO.COM"
default["pbis_open"]["encryption_key_path"] = ""
default["pbis_open"]["default_domain"] = "true"
default["pbis_open"]["login_shell_template"] = "/bin/bash"
default["pbis_open"]["home_dir_template"] = "%H/%U"

default["pbis_open"]["sudo_groups"] = ["domain^admins"]