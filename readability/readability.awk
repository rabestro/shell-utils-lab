#!/usr/bin/env gawk -f
#
#
BEGIN {
    IGNORECASE = 1
    CONVFMT = "%.0f"
    OFMT = "%.2f"
    RS = @/[!?.]+[[:space:]]+/
    SyllablePattern = @/[aiouye]+/
    split("5-6 6-7 7-8 8-9 9-10 10-11 11-12 12-13 13-14 14-15 15-16 16-17 17-18 18-22", Ages)
    print "The text is:"
}
NR < 5 {
    gsub(/[[:space:]]+/, " ")
    print
}
NR == 5 {
    print "..."
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
    Score = 4.71 * Characters / Words + 0.5 * Words / Sentences - 21.43;
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
    print "The score is:", Score
    print "This text should be understood by", Ages[""Score], "year-olds."
}
