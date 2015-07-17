_ = require 'underscore'
fs = require 'fs'

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

letter = (l) ->
  best = _.reduce (Object.keys words), (m, n) ->
    ndx = n.indexOf(l)
    total = ndx + words[n].length
    if ndx > -1
      if total < m[0] 
        [total, ndx, words[n]]
      else m
    else m
  , [Infinity, '']

  if best[0] is Infinity
    "'\\u#{('0000' + l.charCodeAt(0).toString(16)).substr - 4}'"
  else
    "(#{best[2]})[#{nums[best[1]]}]"

stringit = (str) ->
  _.map str, letter
  .join '+'

word = stringit 'js is dead cool'

console.log word
console.log word.length
console.log eval word

fs.writeFileSync 'output.txt', word