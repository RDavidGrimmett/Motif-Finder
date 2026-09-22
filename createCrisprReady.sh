#!/bin/bash
#this is createCrisprReady.sh
#for each .fasta in exomesCohort/, it determines the 3 most frequent motifs using (motif_list.txt) as input.
#then outputs only sequences and corresponding headers that contain ≥1 of those top‑3 motifs to {exomename}_topmotifs.fasta in the current directory.


#set the paths and files as variables
target_dir="./exomesCohort"
motif_list="motif_list.txt"
new_dir="./topmotifs"


#make new directory
mkdir -p "$new_dir"


#starts the loop for each file in the directory
for file in "$target_dir"/*; do


	#isolating just the file name then exome name		
	filename="${file##*/}"
	exomename="${filename%.*}"


	#reads motif_list using grep, against the file. sorts all the matching motifs, counts them, then picks the top 3. awk target just the motif not the count. All is set to a variable.
	top_motifs=$(grep -o -F -f motif_list.txt "$file" | sort | uniq -c | sort -rn | head -n 3 | awk '{print $2}')
	

	#turns the top 3 motrifs into a single line seporated with "|" which is translated to "or"
	motif_regex=$(echo "$top_motifs" | paste -sd '|' -)


	#in order to get the gene header, awk is needed to detect it. the motif_regex is passed in as a variable which will be used to check each line. The record separator is set to ">" so now the header will be attached to the same block. The ">" is returned on the print allowing it to keep the same format. Finally the file is exported with a new name in a new directory.
	awk -v pattern="$motif_regex" '
		BEGIN { RS = ">"; ORS = "" } 
		$0 ~ pattern { print ">" $0 }
	' "$file" > "${new_dir}/${exomename}_topmotifs.fasta"


	
#end of loop
done
