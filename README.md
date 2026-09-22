# Motif-Finder
 A small pipeline that filters a cohort, finds high‑frequency motifs, locates CRISPR PAM sites, performs a simple edit, and produces a text report.

HOW-TO-RUN:
Navigate to the week4 folder containing:  copyExomes.sh, createCrisprReady.sh, identifyCrisprSite.sh,>

RUN THE FOLLOWING COMMANDS:
./copyExomes.sh
./createCrisprReady.sh
./identifyCrisprSite.sh
./editGenome.sh
python3 exomeReport.py


EXPECTED INPUTS & OUTPUTS:

-- INPUTS --
clinical_data.txt
motif_list.txt
exomes/chicken.fasta
exomes/dromedary.fasta
exomes/fox.fasta
exomes/goat.fasta
exomes/gopher.fasta
exomes/gorilla.fasta
exomes/lamb.fasta

-- OUTPUTS --
exomesCohort/chicken.fasta
exomesCohort/dromedary.fasta
exomesCohort/fox.fasta
exomesCohort/goat.fasta
exomesCohort/gopher.fasta
exomesCohort/gorilla.fasta
exomesCohort/lamb.fasta
{exomename}_topmotifs.fasta
{exomename}_precrispr.fasta
{exomename}_postcrispr.fasta
report.txt


ASSUMPTIONS & DEPENDENCIES:

For the following code to work, the .fasta files need a specific layout. They must have “>Gene#” on the first line, and the DNA sequence on the next line.
Next, the layout of clinical_data.txt must be identical to the one used in this project.
You may add/remove the data below the header if you were to add more data to the trial, but the layout is pivotal to the code working correctly.


WEEK 4 REFLECTION:

Where did automation (reading columns, globbing files, loops) save you from brittle code?
        I used loops in every script. This was super important to allow me to loop though the contents of each file and do actions for each.
        There were several times where I didn’t want to write each name of a file, so instead I globbed the files, which allowed me not to write specific file names down.
        This saved my code, as any file with the correct extension will be read.

How did splitting the workflow into small scripts + one Python report improve debugging and clarity?
        This was helpful because each script did one thing. So if a file was coming out wrong, or I was getting errors, I was able to track them down quickly.
        It also helped create a sense of progress. As I finished each script, I started to see the whole project come together.

What are tradeoffs you noticed when mixing Bash (text pipelines) and Python (structured parsing)
        I thought Bash was able to read files with less code. Using grep and awk, I was able to read files quicker and extract info directly.
        Python, on the other hand, needed more code to get the information out. I needed to create a dictionary to get data out, then pull it out of the dictionaries to get the strings.


AI USE DISCLOSURE:

What AI tool did you use?
        Google Gemini

What did you use it for?
        I used it for searching and how to use commands. When I came to an issue, I would usually google. “How to extract data from a dictionary,” for example.
        It would either give me links to forums/websites about the same issue, or it would give me blurbs of code, with examples of how to implement it.

How did you verify or edit its output?
        To verify, I needed to trouble shoot the code, as it wasn’t always specific to what I needed.
        Some code worked and others didn't. This would usually result in me going to Stackoverflow, and GeekforGeeks.
