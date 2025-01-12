# Solo code for assignment 5 - more for proof of concept and strategizing

## Part 1 - Create file containing the unique gender-yearsExperience combinations from /wages.csv/
#	    The file should contain gender in the first column and years in a second column (space delimited)
#	    Rows should be sorted first by gender and then by years, but pairings should be kept intact

# Inputs: None
# Usage: bash Ex5_codeS.sh

## Part 1 ----------------------------------------------------------------------------------------------------------
cat wages.csv | tail -n $(($(wc -l wages.csv | cut -d ' ' -f 1)-1)) | tr ',' ' ' | cut -d ' ' -f 1,2 |
	sort -k1,1 -k2,2n > output.csv

## Part 2 ----------------------------------------------------------------------------------------------------------
for file in wages.csv
do
	cat $file | tail -n $(($(wc -l $file | cut -d ' ' -f 1)-1)) | cut -d ',' -f 4 | sort -n > temp.txt
done
high=$(cat $file | grep -E $(cat temp.txt | tail -n 1) | cut -d ',' -f 1,2,4)
low=$(cat $file | grep -E $(cat temp.txt | head -n 1) | cut -d ',' -f 1,2,4)
fem=0
for i in {1..10}
do
	fem=$(($fem+$(cat $file | grep -E $(cat temp.txt | tail -n $i | head -n 1) | grep -c -E female)))
done
echo "The highest earner is a $(echo $high | grep -o -E [a-z]+) with " \
	"$(echo $high | grep -o -E [,][1-9][,] | grep -o -E [^,]) years of experience making " \
	"$(echo $high | grep -o -E [0-9]+\\.[0-9]+) money"
echo "The lowest earner is a $(echo $low | grep -o -E [a-z]+) with " \
	"$(echo $low | grep -o -E [,][1-9][,] | grep -o -E [^,]) years of experience making " \
	"$(echo $low | grep -o -E [0-9]+\\.[0-9]+) money"
echo "The number of females among the top 10 most paid is $fem"

## Part 3 ----------------------------------------------------------------------------------------------------------
