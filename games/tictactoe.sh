#!/usr/bin/env bash
# Tic-Tac-Toe: two players, X and O. Enter position 1–9.

# Board: positions 1–9 as array indices 0–8
# 1 2 3
# 4 5 6
# 7 8 9
board=(. . . . . . . . .)
current="X"

show_board() {
  echo ""
  echo " ${board[0]} | ${board[1]} | ${board[2]} "
  echo "---+---+---"
  echo " ${board[3]} | ${board[4]} | ${board[5]} "
  echo "---+---+---"
  echo " ${board[6]} | ${board[7]} | ${board[8]} "
  echo ""
  echo "Positions: 1 2 3 / 4 5 6 / 7 8 9"
  echo ""
}

check_win() {
  local symbol="$1"
  # rows
  [ "${board[0]}" = "$symbol" ] && [ "${board[1]}" = "$symbol" ] && [ "${board[2]}" = "$symbol" ] && return 0
  [ "${board[3]}" = "$symbol" ] && [ "${board[4]}" = "$symbol" ] && [ "${board[5]}" = "$symbol" ] && return 0
  [ "${board[6]}" = "$symbol" ] && [ "${board[7]}" = "$symbol" ] && [ "${board[8]}" = "$symbol" ] && return 0
  # cols
  [ "${board[0]}" = "$symbol" ] && [ "${board[3]}" = "$symbol" ] && [ "${board[6]}" = "$symbol" ] && return 0
  [ "${board[1]}" = "$symbol" ] && [ "${board[4]}" = "$symbol" ] && [ "${board[7]}" = "$symbol" ] && return 0
  [ "${board[2]}" = "$symbol" ] && [ "${board[5]}" = "$symbol" ] && [ "${board[8]}" = "$symbol" ] && return 0
  # diagonals
  [ "${board[0]}" = "$symbol" ] && [ "${board[4]}" = "$symbol" ] && [ "${board[8]}" = "$symbol" ] && return 0
  [ "${board[2]}" = "$symbol" ] && [ "${board[4]}" = "$symbol" ] && [ "${board[6]}" = "$symbol" ] && return 0
  return 1
}

has_empty() {
  for cell in "${board[@]}"; do
    [ "$cell" = "." ] && return 0
  done
  return 1
}

echo "Tic-Tac-Toe — two players. X goes first."
show_board

while true; do
  echo -n "Player $current, enter position 1–9: "
  read -r pos

  if ! [[ "$pos" =~ ^[1-9]$ ]]; then
    echo "Enter a number from 1 to 9."
    continue
  fi

  idx=$((pos - 1))
  if [ "${board[$idx]}" != "." ]; then
    echo "That spot is taken."
    continue
  fi

  board[$idx]="$current"
  show_board

  if check_win "$current"; then
    echo "Player $current wins!"
    return 0
  fi

  if ! has_empty; then
    echo "Draw!"
    return 0
  fi

  if [ "$current" = "X" ]; then
    current="O"
  else
    current="X"
  fi
done
