#this is exomeReport.py
#Produce a text report listing, for each organism in the cohort: discoverer name, diameter, code name, environment (all from clinical_data.txt).
#Final line: print the union of gene names observed across the cohort (no duplicates) drawn from the CRISPR‑ready files ({exomename}_precrispr.fasta or {exomename}_postcrispr.fasta).

#imported libraries to allow easier use of dictonaries and use of reqular expression.
from operator import itemgetter
import csv
import re


#added variable for "clinical_data.txt"
file_path = "clinical_data.txt"


#created a dataset dictionary
dataset = []


#used with open 'r' to read the file.
with open(file_path, 'r') as file:


        #this sets up the dictionary by taking the first row and making them the keys, and the column>
        reader = csv.DictReader(file, delimiter="\t")


        #this will allow us to access the keys and vaules from each row by appending them into the da>
        for row in reader:
                dataset.append(dict(row))


#created a variable to get the diameter and status values
get_mm = itemgetter("Diameter (mm)")
get_status = itemgetter("Status")


#this variable will only hold data that has teh correct diameter and status.
cohort_data = [
        x for x in dataset
        if 20 <= float(get_mm(x)) <= 30 and
        get_status(x) == "Sequenced"
]


#this will hold the layout for the information in the report.txt
record_layout = [
        "code_name",
        "Discoverer",
        "Environment",
        "Diameter (mm)",
]


#created a new dictionary to hold the genes
genes = []


#this will write the data to a new file "w"
with open("report.txt", "w") as report:


        #for each of the organisms in the cohort, it will write the following
        for organism in cohort_data:


                #this takes each key and attaches the variable to it
                for key in record_layout:
                        if key in organism:
                                report.write(f"{key}: {organism[key]}\n")


                #created a new variable to hold the "code_name" which is from the dictionary
                code_name = organism.get("code_name")


                #this opens all the postcrispr.fasta files to get the genes out. Using the ">" as the>
                with open(f"{code_name}_postcrispr.fasta", 'r') as fasta:
                        for line in fasta:
                                if line.startswith(">"):


                                        #created a variable to store the gene name and strip the ">" >
                                        gene_name = line.lstrip('>').strip()


                                        #append the genes dictionary with the gene
                                        genes.append(gene_name)


                #create new line for formatting
                report.write("\n")


        #this makes a list from the dictionary and eliminates any duplicates as dictionaries cannot s>
        gene_union = list(dict.fromkeys(genes))


        #this allows the genes to be listed in numarical order. Its simply for ease of reading.
        gene_union.sort(key=lambda x: int(re.search(r'\d+', x).group()) if re.search(r'\d+', x) else >


        #this puts the list into a string separated by a comma.
        gene_final = ", ".join(gene_union)


        #write the genes list to the final line
        report.write(f"Genes: {gene_final}\n\n")
