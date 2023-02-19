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

Question in Animals[CurrentNode] {
    print Animals[CurrentNode][Question]
}
AnimalName in Animals[CurrentNode] {
    print "Is it", Animals[CurrentNode][AnimalName], "?"
}
{
    getline
}
/yes/ && AnimalName in Animals[CurrentNode] {
    print "It's great that I got it right!"
    exit
}
/no/ && AnimalName in Animals[CurrentNode] {
    give_up()
}
Question in Animals[CurrentNode] {
    CurrentNode = Animals[CurrentNode][$1 ~ /yes/]
}

END {
    print "Saving database...", writeall(DB) ? "Success!" : "Faild..."
    print ""
    print "Good bye!"
}

function load_database() {
    AnimalName = "name"
    Question = "question"
    Response = "response"
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
    State = "question"
}

function give_up(   animal_guessed,animal_in_mind,question,answer,size) {
    animal_guessed = Animals[CurrentNode][AnimalName]
    print "I give up. What animal do you have in mind?"
    getline animal_in_mind

    print "Write a closed question by answering which I can distinguish "animal_in_mind" from "animal_guessed
    print "Examples: 'Can/Have/Is it ...?'"
    getline question
    print "What is the correct answer for "animal_in_mind" ?"
    getline answer
    delete Animals[CurrentNode][AnimalName]
    Animals[CurrentNode][Question] = question
    size = length(Animals)
    Animals[++size][AnimalName] = animal_in_mind
    Animals[CurrentNode][answer ~ /yes/] = size
    Animals[++size][AnimalName] = animal_guessed
    Animals[CurrentNode][answer !~ /yes/] = size
    exit
}
