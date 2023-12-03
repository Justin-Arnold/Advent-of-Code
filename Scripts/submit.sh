# Aruments
YEAR=$1
DAY=$2
PART=$3
ANSWER=$4
# Check if the answer is already cached
if [ -f "Solutions/$YEAR/Day${DAY}Part${PART}Solution.txt" ]; then
    # Get the cached answer and compare it to the submitted answer
    CACHED_ANSWER=$(cat "Solutions/$YEAR/Day${DAY}Part${PART}Solution.txt")
    # Check if the answer is correct
    if [ "$ANSWER" == "$CACHED_ANSWER" ]; then
        echo "VERDICT : CORRECT!"
        exit 0
    # Or if it is wrong
    else
        echo "VERDICT : WRONG ANSWER! (CACHED ANSWER: $CACHED_ANSWER)"
        exit 1
    fi
# If the answer is not cached, submit it
else {
    # Get cookie from .env file
    COOKIE=$(grep AOC_COOKIE .env | cut -d '=' -f2)
    # Submit the answer
    response=$(curl -s \
            -X POST \
            --data "level=$PART" \
            --data "answer=$ANSWER" \
            --cookie "session=$COOKIE" \
            "https://adventofcode.com/$YEAR/day/$DAY/answer")\
    # check if answering too quickly
    if echo "$response" | grep -q "You gave an answer too recently"; then
        echo "VERDICT : TOO MANY REQUESTS"
    # check if the answer is wrong
    elif echo "$response" | grep -q "not the right answer"; then
        if echo "$response" | grep -q "too low"; then
            echo "VERDICT : WRONG (TOO LOW)"
        elif echo "$response" | grep -q "too high"; then
            echo "VERDICT : WRONG (TOO HIGH)"
        else
            echo "VERDICT : WRONG (UNKNOWN)"
        fi
    # check if already solved
    elif echo "$response" | grep -q "seem to be solving the right level."; then
        echo "VERDICT : ALREADY SOLVED"
        #cache the asnwer
        mkdir -p "Solutions/$YEAR/"
        echo "$ANSWER" > "Solutions/$YEAR/Day${DAY}Part${PART}Solution.txt"
    # the asnwer is correct at this point
    elif echo "$response" | grep -q "That's the right answer"; then
        echo "VERDICT : CORRECT!"
        # Cache the answer
        mkdir -p "Solutions/$YEAR/"
        echo "$ANSWER" > "Solutions/$YEAR/Day${DAY}Part${PART}Solution.txt"
    # unknown response
    else
        echo "VERDICT : UNKNOWN RESPONSE"
        echo $response
    fi
}
fi
