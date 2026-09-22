#!/bin/bash
#this is copyExomes.sh
#it takes input (clinical_data.txt) and selects samples with a diameter between 20 and 30 mm (inclusive) that have genomes sequenced.
#then copies matching exomes (by sample code_name) into a new directory exomesCohort/.


#created the directory paths as variables to call later
from_dir="./exomes"
new_dir="./exomesCohort"


#created the directory to place the copied files using -p flag to avoid errors if it exists.
mkdir -p "$new_dir"


#used awk to parse through input file. Needed to remove the spaces in location as it was causing error, -F'\t' allowed white space to stay and made tabs split columns. Next used basic math to figure out columns within the mm range, and found the ones in column 6 that were sequenced. Stored data as a variable and started a while loop from it.
awk -F'\t' '$3 >= "20" && $3 <= "30" && $5 == "Sequenced" {print $6}' clinical_data.txt | while read -r sample_code_name; do
	

	#created a variable that stored matching file name and target directory
	matching_file="${from_dir}/${sample_code_name}.fasta" 


		#copied the matching files and placed the copies into the new directory.
        	cp "$matching_file" "$new_dir/"

#finished loop
done
 


