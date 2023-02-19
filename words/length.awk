{
    Words[length($0)]++
}
END {
    for (i in Words) {
        printf "%2d - %5d\n", i, Words[i]
    }
}
