#!/usr/bin/env gawk -f
@load "rwarray"

BEGIN {
    DB = DB ? DB : "animals.data"

    load_database()
    welcome_user()

    if (!(RootNode in Animals))
        ask_favorite_animal()

    start_game()
}

NF == 0 {
    printf "Is it a %s? ", Animals[CurrentNode][AnimalName]
}

/quit/ {exit}

END {
    print "Saving database...", writeall(DB) ? "Success!" : "Faild..."
    print ""
    print "Good bye!"
}

function load_database() {
    AnimalName = "name"
    Question = "question"
    RootNode = 1
    print "Loading database... ", readall(DB) ? "Success!" : "Faild..."
}

function welcome_user() {
    print "Hello!"
    print ""
}

function ask_favorite_animal() {
    print "I want to learn about animals."
    print "Which animal do you like most?"
    getline Animals[RootNode][AnimalName]
    print "Wonderful! I've learned so much about animals!"
}

function start_game() {
    print "Let's play a game!"
    print ""
    print "You think of an animal, and I guess it."
    print "Press enter when you're ready."
    CurrentNode = RootNode
}
