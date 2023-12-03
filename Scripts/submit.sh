# Aruments
YEAR=$1
DAY=$2
PART=$3
ANSWER=$4

# Get cookie from .env file
COOKIE=$(grep AOC_COOKIE .env | cut -d '=' -f2)

# Submit the answer
response=$(curl -s \
        -X POST \
        --data "level=$PART" \
        --data "answer=$ANSWER" \
        --cookie "session=$COOKIE" \
        "https://adventofcode.com/$YEAR/day/$DAY/answer")

# Check the response
if echo "$response" | grep -q "You gave an answer too recently"; then
    echo "VERDICT : TOO MANY REQUESTS"
elif echo "$response" | grep -q "not the right answer"; then
    if echo "$response" | grep -q "too low"; then
        echo "VERDICT : WRONG (TOO LOW)"
    elif echo "$response" | grep -q "too high"; then
        echo "VERDICT : WRONG (TOO HIGH)"
    else
        echo "VERDICT : WRONG (UNKNOWN)"
    fi
elif echo "$response" | grep -q "seem to be solving the right level."; then
    echo "VERDICT : ALREADY SOLVED"
else
    echo "VERDICT : OK !"
fi