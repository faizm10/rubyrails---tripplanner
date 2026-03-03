#!/usr/bin/env bash
# Number Guess: guess a number between 1 and 100.

n=$((RANDOM % 100 + 1))
tries=0

echo "I'm thinking of a number between 1 and 100."
echo ""

while true; do
  echo -n "Your guess: "
  read -r guess
  tries=$((tries + 1))

  if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
    echo "Enter a number."
    continue
  fi

  if [ "$guess" -lt "$n" ]; then
    echo "Higher!"
  elif [ "$guess" -gt "$n" ]; then
    echo "Lower!"
  else
    echo "Correct! You got it in $tries tries."
    return 0
  fi
done
