#!/bin/bash
#For each FASTA in exomesCohort/, determine the 3 most frequent motifs using motif_list.txt.
#Output only sequences (with headers) that contain ≥1 of those top‑3 motifs to {exomename}_topmotifs.fasta (e.g., fox_topmotifs.fasta) in the current directory.

#set the paths and files as variables
target_dir="./exomesCohort"
motif_list="motif_list.txt"


#starts the loop for each file in the directory
for file in "$target_dir"/*; do


        #isolating just the file name then exome name
        filename="${file##*/}"
        exomename="${filename%.*}"


        #reads motif_list using grep, against the file. sorts all the matching motifs, counts them, then picks the top 3. awk target just the motif not the count. All is set to a variable.
        top_motifs=$(grep -o -F -f motif_list.txt "$file" | sort | uniq -c | sort -rn | head -n 3 | awk '{print $2}')


        #turns the top 3 motrifs into a single line seporated with "|" which is translated to "or"
        motif_regex=$(echo "$top_motifs" | paste -sd '|' -)


        #in order to get the gene header, awk is needed to detect it. the motif_regex is passes in as a variable which will be used to check each line. The record seportor is set to ">" so now the header will>
        awk -v pattern="$motif_regex" '
                BEGIN { RS = ">"; ORS = "" }
                $0 ~ pattern { print ">" $0 }
        ' "$file" > "${exomename}_topmotifs.fasta"



#end of loop
done