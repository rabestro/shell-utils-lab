#!/usr/bin/env gawk -f
BEGIN {
    IGNORECASE = 1
    RS = @/[!?.]+[[:space:]]+/
    SyllablePattern = @/[aiouye]+/
}
NR < 5 {
    gsub(/[[:space:]]+/, " ")
    print
}
NF {
    ++Sentences
    ++Characters
    Words += NF
    for (i = 1; i <= NF; ++i) {
        Characters += length($i)
        s = syllables($i)
        if (s > 2) ++Polysyllables
        Syllables += s
    }
}

END {
    print_stats()
}

function syllables(word,   count) {
    if (word !~ /[[:alpha:]]/) return 0
    sub(/e$/, "", word)
    count = gsub(SyllablePattern, "", word)
    return count ? count : 1
}

function print_stats() {
    print ""
    print "Words:", Words
    print "Sentences:", Sentences
    print "Characters:", Characters
    print "Syllables:", Syllables
    print "Polysyllables:", Polysyllables
}
#    180,
#    982,
#    13,
#    317,
#    34,
#    11.19,
#    10.59,
#    12.37,
#    14.14
