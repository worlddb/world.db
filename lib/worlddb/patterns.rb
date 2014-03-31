# encoding: utf-8

module WorldDb

# collection of regex patterns for reuse (WorldDb specific)

### todo: add a patterns.md page to  github ??
##  - add regexper pics??

############
# about ruby regexps
#
# try the rubular - Ruby regular expression editor and tester
#  -> http://rubular.com
#   code -> ??  by ??
#
#
# Jeff Avallone's Regexper - Shows State-Automata Diagrams
#  try -> http://regexper.com
#    code -> https://github.com/javallone/regexper
#
#
#  Regular Expressions | The Bastards Book of Ruby by Dan Nguyen
# http://ruby.bastardsbook.com/chapters/regexes/
#
# move to notes  regex|patterns on  geraldb.github.io ??
#

  COUNTRY_KEY_PATTERN = '^[a-z]{2,3}$'    # allow two AND three letter keys e.g. at, mx, eng, sco, etc.
  COUNTRY_KEY_PATTERN_MESSAGE = "expected two or three lowercase letters a-z /#{COUNTRY_KEY_PATTERN}/"

  COUNTRY_CODE_PATTERN = '^[A-Z_]{3}$'
  COUNTRY_CODE_PATTERN_MESSAGE = "expected three uppercase letters A-Z (and _) /#{COUNTRY_CODE_PATTERN}/"


  REGION_KEY_PATTERN = '^[a-z]+$'
  REGION_KEY_PATTERN_MESSAGE = "expected one or more lowercase letters a-z /#{REGION_KEY_PATTERN}/"

  REGION_CODE_PATTERN = '^[A-Z_]{2,3}$'
  REGION_CODE_PATTERN_MESSAGE = "expected two or three uppercase letters A-Z (and _) /#{REGION_CODE_PATTERN}/"


  CITY_KEY_PATTERN = '^[a-z]{3,}$'
  CITY_KEY_PATTERN_MESSAGE = "expected three or more lowercase letters a-z' /#{CITY_KEY_PATTERN}/"
  
  CITY_CODE_PATTERN = '^[A-Z_]{3}$'
  CITY_CODE_PATTERN_MESSAGE = "expected three uppercase letters A-Z (and _)' /#{CITY_CODE_PATTERN}/"


  LANG_KEY_PATTERN = '^[a-z]{2}$'
  LANG_KEY_PATTERN_MESSAGE = "expected two lowercase letters a-z' /#{LANG_KEY_PATTERN}/"

end # module WorldDb

