#!/bin/bash
#Script takes input (clinical_data.txt) and selects samples with a diameter between 20 and 30 mm (inc>
#Copy matching exomes (by sample code name) from /home/rbif/week4/exomes/ into a new directory exomes>


#created the directory paths as variables to call later
ex_DIR="./exomes"
ex_Co_DIR="./exomesCohort"


#created the directory to place the copied files using -p flag to avoid errors if it exists.
mkdir -p "$ex_Co_DIR"


#used awk to parse through input file. Needed to remove the spaces in location as it was causing erro>
awk -F'\t' '$3 >= "20" && $3 <= "30" && $5 == "Sequenced" {print $6}' clinical_data.txt | while read >


        #created a variable that stored matching file name and target directory
        matching_file="${ex_DIR}/${sample_code_name}.fasta"


                #copied the matching files and placed the copies into the new directory.
                cp "$matching_file" "$ex_Co_DIR/"

#finished loop
done

