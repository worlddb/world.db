# encoding: utf-8



# our own code

require 'worlddb/compat/version'   # always goes first

require 'worlddb/compat/city'
require 'worlddb/compat/continent'
require 'worlddb/compat/country'
require 'worlddb/compat/lang'
require 'worlddb/compat/state'

require 'worlddb/compat/matcher'


# say hello
puts WorldDbCompat.banner    if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
