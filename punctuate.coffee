_ = require 'underscore'

nums = [
  '+[]'
  '+!![]'
  '-~!![]'
  '-~-~!![]'
  '-~-~-~!![]'
  '-~-~-~-~!![]'
  '-~-~!![]<<!![]'
  '-~-~-~-~-~-~!![]'
  '-~-~-~!![]<<!![]'
  '-~-~!![]*-~-~!![]'
]

words = 
  'false' : '[]+![]'
  'true' : '[]+!![]'
  'undefined' : '[]+[][+[]]'
  'Infinity' : '[]+!![]/+[]'
  '[object Object]' : '[]+{}'
  'NaN' : '[]+{}/!![]'

wrap = (t) -> "(#{t})"

letter = (l) ->
  _.chain Object.keys words
  .reduce (m, n) ->
    tuple = m[0]
    ndx = n.indexOf(l) - 1 # why does this have to have a -1?
    total = ndx + l.length
    if ndx > -1
      if total < tuple[0] then [[total, words[n]]] else m
    else m
  , [[Infinity, '']]
  .map (tuple) ->
    if tuple[0] is Infinity
      # this turns any character we cant punctuate into a \uXXXX char
      "'\\u#{('0000' + l.charCodeAt(0).toString(16)).substr -4}'"
    else
      "(#{tuple[1]})[#{nums[tuple[0]]}]"
  .value()[0]

stringit = (str) ->
  _.chain str.split ''
  .map (l) ->
    letter l
  .value()
  .join '+'

foo = stringit 'x'

console.log foo
console.log foo.length
console.log eval foo