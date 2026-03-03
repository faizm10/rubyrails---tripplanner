#!/usr/bin/env bash
# Hangman: guess the word letter by letter. 6 wrong guesses and you lose.

words=(BASH SCRIPT TERMINAL HANGMAN GAMES OFFLINE SHELL LINUX APPLE WORDS GUESS LETTER CURSOR KEYBOARD PROMPT COMMAND OUTPUT INPUT FOLDER FILE PATH MENU CHOICE)
word="${words[RANDOM % ${#words[@]}]}"
max_wrong=6
wrong=0
guessed=""
len=${#word}
# Build display: one underscore per letter
display=""
for ((i=0; i<len; i++)); do display="${display}_"; done

echo "Hangman — guess the word (${len} letters). You get $max_wrong wrong guesses."
echo ""

while true; do
  echo "Word: $display"
  echo "Wrong: $wrong/$max_wrong  Guessed: ${guessed:-none}"
  echo ""

  if [ "$wrong" -ge "$max_wrong" ]; then
    echo "You lose! The word was: $word"
    return 0
  fi

  # Check win: no underscores left
  if ! echo "$display" | grep -q '_'; then
    echo "You win! The word was: $word"
    return 0
  fi

  echo -n "Guess a letter: "
  read -r letter
  letter=$(echo "$letter" | tr '[:lower:]' '[:upper:]')
  letter="${letter:0:1}"

  if [ -z "$letter" ] || [ ${#letter} -ne 1 ]; then
    echo "Enter one letter."
    continue
  fi

  if echo "$guessed" | grep -q "$letter"; then
    echo "You already guessed that."
    continue
  fi

  guessed="${guessed}${letter} "

  if echo "$word" | grep -q "$letter"; then
    # Reveal all occurrences
    new_display=""
    for ((i=0; i<len; i++)); do
      c="${word:i:1}"
      if [ "$c" = "$letter" ]; then
        new_display="${new_display}${letter}"
      else
        new_display="${new_display}${display:i:1}"
      fi
    done
    display="$new_display"
    echo "Good guess!"
  else
    wrong=$((wrong + 1))
    echo "Wrong. $((max_wrong - wrong)) wrong guesses left."
  fi
  echo ""
done
