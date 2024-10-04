this is just a copy of Prime's lua config and some more spice.

should just be in ~/.config/nvim

also, ripgrep needs to be installed. tree-sitter too.

tricks:
 1. <ctrl p> for fuzzy find files
 1. <ctrl shift f> for grep across files
 1. leader means \
 1. <leader git> see changed files.
 1. i added visualmulti. Do <ctrl n> to multicursor on the word
 1. to replace across files i grep across files the substring,
    then i do quickfix all (ctrl q) and type
     `:cdo s/StringOne/StringTwo/g | update`
