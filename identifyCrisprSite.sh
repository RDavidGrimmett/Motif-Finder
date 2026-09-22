#!/bin/bash
#this is identifyCrisprSite.sh
#for each {exomename}_topmotifs.fasta, it identifies sequences that have at least 20 nucleotides upstream of an NGG site. (N means it can be A, T, C, or G).
#then writes the candidate headers and sequences to {exomename}_precrispr.fasta.


#set the paths to directories as variables
target_dir="./topmotifs"
new_dir="./precrispr"


#make new directory
mkdir -p "$new_dir"

#created a variable/regex that will hold the pattern need. 20 Bp before the NGG 
NGG_check=".{20}[ATCG]GG"


#start the for loop. It does the following of each file in the directory
for file in "$target_dir"/*; do


        #isolating just the file name then exome name saved for later as variable
        filename="${file##*/}"
        exomename="${filename%_*}"	


	#starting awk with the NGG_check as a variable to check for match in awk
	awk -v nggpat="$NGG_check" '

	#begin record spacer at the >header to capture both lines. ORS is cleared to keep the format the same as original file
	BEGIN { RS = ">"; ORS = "" }

	#NR needs to be set to >1 to skip the header row. Then we check the second line $2 vs the NGG_Check awk variable. If it comes back as true, it prints the current line and inserts the ">" back in to keep the format. 
	NR > 1 && $2 ~ nggpat { print ">" $0 }

	#calls the exomename, attaches it to the file format, and creates the file.
	' "$file" > "${new_dir}/${exomename}_precrispr.fasta"

#finishes loop
done


 
   
