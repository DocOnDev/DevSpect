exports.upperFirst = (phrase) -> 
  (phrase.split(' ').map (word) -> word[0].toUpperCase() + word[1..-1].toLowerCase()).join ' '

exports.toDateFormat = (dt) -> 
  dt.getTime()
