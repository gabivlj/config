this is just a copy of Prime's lua config and some more spice.

should just be in ~/.config/nvim

also, ripgrep needs to be installed. tree-sitter too.

as well
npm install [-g] @biomejs/biome

tricks:

1.  <ctrl p> for fuzzy find files
1.  <ctrl shift f> for grep across files
1.  leader means \
1.  <leader git> see changed files.
1.  i added visualmulti. Do visual + <ctrl n> to multicursor on the word,
    there is like vscode
1.  to replace across files i grep across files the substring,
    then i do quickfix all (ctrl q) and type
    `:cdo s/StringOne/StringTwo/g | update`
1.  `gd` is go to definition
1.  `\vrr` view references
1.  `\vrn` rename
1.  quickfix list can be closed with `:ccl`
1.  gcc means comment the selected block
