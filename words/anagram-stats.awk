#!/usr/bin/env gawk -f
@load "rwarray"

BEGIN {
    PROCINFO["sorted_in"] = "@val_str_asc"
}
{
    split($1, chars, "")
    word = ""
    for (i in chars) {
        word = word chars[i]
    }
    Anagram[word]++
}

END {
    ret = writea("anagram.data", Anagram)
    for (word in Anagram) print word, Anagram[word]
}
