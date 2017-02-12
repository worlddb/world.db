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

  COUNTRY_KEY_PATTERN = '\A[a-z]{2,3}\z'    # allow two AND three letter keys e.g. at, mx, eng, sco, etc.
  COUNTRY_KEY_PATTERN_MESSAGE = "expected two or three lowercase letters a-z /#{COUNTRY_KEY_PATTERN}/"

  COUNTRY_CODE_PATTERN = '\A[A-Z_]{3}\z'
  COUNTRY_CODE_PATTERN_MESSAGE = "expected three uppercase letters A-Z (and _) /#{COUNTRY_CODE_PATTERN}/"


  STATE_KEY_PATTERN = '\A[a-z]+\z'
  STATE_KEY_PATTERN_MESSAGE = "expected one or more lowercase letters a-z /#{STATE_KEY_PATTERN}/"

  STATE_CODE_PATTERN = '\A[A-Z_]{2,3}\z'
  STATE_CODE_PATTERN_MESSAGE = "expected two or three uppercase letters A-Z (and _) /#{STATE_CODE_PATTERN}/"


  CITY_KEY_PATTERN = '\A[a-z]{3,}\z'
  CITY_KEY_PATTERN_MESSAGE = "expected three or more lowercase letters a-z' /#{CITY_KEY_PATTERN}/"
  
  CITY_CODE_PATTERN = '\A[A-Z_]{3}\z'
  CITY_CODE_PATTERN_MESSAGE = "expected three uppercase letters A-Z (and _)' /#{CITY_CODE_PATTERN}/"


  LANG_KEY_PATTERN = '\A[a-z]{2}\z'
  LANG_KEY_PATTERN_MESSAGE = "expected two lowercase letters a-z' /#{LANG_KEY_PATTERN}/"

end # module WorldDb

