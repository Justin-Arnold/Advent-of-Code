# Arguments
YEAR=$1
DAY=$2

# Defaults to current year and day
if [ -z "$YEAR" ]
then
    YEAR=$(date +%Y)
fi
if [ -z "$DAY" ]
then
    # should not have leading 0
    DAY=$(date +%d | sed 's/^0*//')
    echo "DAY : $DAY"
fi

#Get cookie from .env file
COOKIE=$(grep AOC_COOKIE .env | cut -d '=' -f2)

# Gets the input for the day and puts it in Inputs/[year]/Day[day]Input.txt
mkdir -p Inputs/$YEAR/
curl --cookie "session=$COOKIE" https://adventofcode.com/$YEAR/day/$DAY/input > Inputs/$YEAR/Day$DAY\Input.txt

# Creates the file for the day
mkdir -p Sources/$YEAR/
touch Sources/$YEAR/Day$DAY\Solutions.swift

# Writes the template for the day
echo """
    import Foundation

    struct Day${DAY}_$YEAR: DayChallenge {
        static func partOne(input: String) -> String {
            return input
        }
        static func partTwo(input: String) -> String {
            return input
        }
    }
""" > Sources/$YEAR/Day$DAY\Solutions.swift
