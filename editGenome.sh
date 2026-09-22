#!/bin/bash
#this is editGenome.sh
#for each {exomename}_precrispr.fasta it inserts an "A" directly before the NGG site and writes to {exomename}_postcrispr.fasta.


#set the paths to directories as variables
target_dir="./precrispr"
new_dir="./postcrispr"


#make new directory
mkdir -p "$new_dir"


#created a variable/regex that will hold the target NGG.
PAM_site="[ATCG]GG"


#start the for loop. It does the following of each file in the directory
for file in "$target_dir"/*; do


        #isolating just the file name then exome name saved for later as variable
        filename="${file##*/}"
        exomename="${filename%_*}"


        #starting awk with /^>/. This begins the record at ">" which is the header. Then "print" "next" to capture that line and move on as this line will not need to be edited.
	awk '
	/^>/ {
		print
		next
	}

	{	
		#then call the next line read ($0) as sequence as this is the DNA sequence line.
		sequence = $0

		
		#this creates a search varaible that will subtract the basepairs before the NGG site.
		search = substr(sequence, 21)

		#then if there is a match after the 20 base pairs we continue.
		if (match(search, /[ATCG]GG/)) {

			#this is the position of the match
			position = 20 + RSTART

			#this keep everything before the "A" the same, then inserts the "A", then appends the rest of the sequence after the "A"
			sequence = substr(sequence, 1, position - 1) \
				"A" \
				substr(sequence, position)
		}
	
		print sequence

	}

	#create a new file and send headers and edited sequences there.
	' "$file" > "${new_dir}/${exomename}_postcrispr.fasta"

#end of loop
done
