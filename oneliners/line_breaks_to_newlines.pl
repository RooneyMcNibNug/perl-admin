# remove linebreaks and replace each with literal \n
perl -pe 's/\n/\\n/g' input.txt > output.txt
