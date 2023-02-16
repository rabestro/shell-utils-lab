#!/use/bin/env gawk --exec
BEGIN {
    RS = "[[:space:]]*[;{}][[:space:]]*"
    ClassDefinition = @/^class\>| class\>/
}
$1 == "package" {
    Package = $2
}
$0 ~ ClassDefinition {
    print "---- "Package"."class_name()" ----"
}
$1 == "if" {
    print condition()
}

function condition(   parenthesis,start,i,symbol,expresson) {
    for (start = i = index($0, "("); i <= length($0) ; ++i){
        symbol = substr($0, i, 1)
        if (symbol == "(") ++parenthesis
        else if (symbol == ")") --parenthesis
        if (!parenthesis) break
    }
    expresson = substr($0, start, 1 + i - start)
    return clean_expression(expresson)
}

function clean_expression(expresson) {
    gsub(/[[:space:]]+/, " ", expresson)
    expresson = substr(expresson, 1, length(expresson) - 1)
    return expresson = substr(expresson, 2)
}

function class_name(   name) {
    match($0, /\<class\>[[:space:]]+(\<\w+\>)/, name)
    return name[1]
}
