#!/usr/bin/env bats
load bats-extra

setup() {

    cat > exercism.txt <<EOF
Exercism is an online, open-source, free coding platform
that offers code practice and mentorship on 62 different
programming languages.

Software developer Katrina Owen created Exercism while
she was teaching programming at Jumpstart Labs.
The platform was developed as an internal tool to solve
the problem of her own students not receiving feedback
on the coding problems they were practicing. Katrina put
the site publicly online and found that people were sharing
it with their friends, practicing together and giving
each other feedback. Within 12 months, the site had
organically grown to see over 6,000 users had submitted
code or feedback, and hundreds of volunteers contribute
to the languages or tooling on the platform.
EOF

    cat > ari.txt <<EOF
Unlike the other indices, the ARI, along with the Coleman-Liau,
relies on a factor of characters per word, instead of the usual
syllables per word. The number of characters is more readily and
accurately counted by computer programs than syllables.

The readability of most written material varies considerably
from passage to passage. As a result, the reliability of any
readability index is limited by the length of the text sample.
Many factors affect the evaluation of any result from a readability
formula, especially when you consider who will be reading your text,
a child or an adult reader, as well as his background in the content
area. If the written material is in his area of competency, readability
is less important than if your text focused on a subject matter area
with which he had little knowledge. Thus, a new employee may have
difficulty reading a manual that is easily read by more experienced
persons. An economist may be able to read most written material
dealing with his specialty, yet, have difficulty reading comparatively
introductory texts in electronics. Conversely, the electronics engineer
might find his first encounter with a volume on economics to be difficult
reading. In many ways this is similar to learning a foreign language.
EOF

    cat > billy.txt <<EOF
Billy always listens to his mother. He always does what she says.
If his mother says, "Brush your teeth," Billy brushes his teeth.
If his mother says, "Go to bed," Billy goes to bed. Billy is
a very good boy. A good boy listens to his mother. His mother
doesn't have to ask him again. She asks him to do something one time,
and she doesn't ask again. Billy is a good boy. He does what his
mother asks the first time. She doesn't have to ask again. She
tells Billy, "You are my best child." Of course Billy is her
best child. Billy is her only child.
EOF
}

teardown() {
    rm -f exercism.txt billy.txt ari.txt
}

# Test grepping a single file

@test "Exercism is an online, open-source, free coding platform" {
#    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f ari.awk exercism.txt

    assert_success
    assert_line --index 0 "The text is:"
    assert_line --index 1 "Exercism is an online, open-source, free..."
    assert_line --index 2 "Software developer Katrina Owen created ..."
    assert_line --index 3 "The platform was developed as an interna..."
    assert_line --index 4 "..."
    assert_line --index 5 "Words: 113"
    assert_line --index 6 "Sentences: 5"
    assert_line --index 7 "Characters: 618"
    assert_line --index 8 "The score is: 15.63"
    assert_line --index 9 "This text should be understood by 18-22 year-olds."
}

@test "Billy always listens to his mother" {
#    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f ari.awk billy.txt

    assert_success
    assert_line --index 0 "The text is:"
    assert_line --partial --index 1 "Billy always listens to his mother"
    assert_line --partial --index 2 "He always does what she says"
    assert_line --partial --index 3 "If his mother says, \"Brush your teeth,\" ..."
    assert_line --index 4 "..."
    assert_line --index 5 "Words: 108"
    assert_line --index 6 "Sentences: 13"
    assert_line --index 7 "Characters: 442"
    assert_line --index 8 "The score is: 2.00"
    assert_line --index 9 "This text should be understood by 6-7 year-olds."
}
