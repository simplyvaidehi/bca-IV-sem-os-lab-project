#!/bin/bash

file="score.txt"

menu() {
while true
do
    echo "=============================="
    echo "        QUIZ GAME MENU        "
    echo "=============================="
    echo "1. Start Quiz"
    echo "2. View Leaderboard"
    echo "3. Exit"
    echo "Enter your choice:"
    read choice

    case $choice in
        1) start_quiz ;;
        2) leaderboard ;;
        3) echo "Exiting..."; exit ;;
        *) echo "Invalid choice!" ;;
    esac
done
}

ask_question() {
question=$1
option1=$2
option2=$3
option3=$4
correct=$5

echo ""
echo "$question"
echo "a) $option1"
echo "b) $option2"
echo "c) $option3"

echo "⏳ You have 5 seconds:"
read -t 5 answer

if [ $? -eq 0 ]; then
    if [ "$answer" == "$correct" ]; then
        echo "✅ Correct!"
        score=$((score+1))
    else
        echo "❌ Wrong!"
    fi
else
    echo "⏰ Time's up!"
fi
}

start_quiz() {

echo "Enter your name:"
read name
score=0

echo "Quiz starting... You have TOTAL 30 seconds!"
start_time=$(date +%s)

ask_question "Q1: Capital of India?" "Mumbai" "Delhi" "Kolkata" "b"
ask_question "Q2: 5 + 3 = ?" "6" "8" "9" "b"
ask_question "Q3: Shell scripting language?" "Python" "Bash" "Java" "b"
ask_question "Q4: Father of Computer?" "Charles Babbage" "Newton" "Einstein" "a"
ask_question "Q5: Linux list files command?" "ls" "pwd" "cd" "a"

end_time=$(date +%s)
total_time=$((end_time - start_time))

echo ""
echo "=============================="
echo "       QUIZ FINISHED          "
echo "=============================="

echo "$name, your score: $score"
echo "⏱ Total time taken: $total_time seconds"

echo "$name - $score - ${total_time}s" >> $file
}

leaderboard() {
echo ""
echo "====== LEADERBOARD ======"

if [ -f $file ]; then
    sort -t "-" -k2 -nr $file
else
    echo "No scores yet!"
fi

echo "=========================="
}

menu
