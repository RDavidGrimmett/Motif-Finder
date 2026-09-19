#!/bin/bash
#For each {exomename}_topmotifs.fasta, identify sequences that have at least 20 nucleotides upstream of an NGG site. (N means it can be A, T, C, or G0.
#Example: ATGAACGTCTGTAAGAACTGCGGATCTGTCA (Everything left of CGG is upstream of the DNA) 

#Write candidate headers and sequences to {exomename}_precrispr.fasta.

#created a variable/regex that will hold the pattern need. 20 Bp before the NGG
NGG_check=".{20}[ATCG]GG"


#start the for loop. It does the following of each file that matches the text following the *
for file in *_topmotifs.fasta; do


        #isolating just the file name then exome name saved for later as variable
        filename="${file##*/}"
        exomename="${filename%.*}"


        #starting awk with the NGG_check as a variable to check for match in awk.
        awk -v nggpat="$NGG_check" '

        #begin record spacer at the >header to capture both lines. ORS is cleared to keep the format the same as original file
        BEGIN { RS = ">"; ORS = "" }

        #NR needs to be set to >1 to skip the header row. Then we check the second line $2 vs the NGG_Check awk variable. If it comes back as true, it prints the current line and inserts the ">" back in to ke>
        NR > 1 && $2 ~ nggpat { print ">" $0 }

        #calls the exomename, attaches it to the faile format, and creates the file.
        ' "$file" > "${exomename}_precrisper.fasta"

#finishes loop
done