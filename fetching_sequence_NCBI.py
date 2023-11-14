#Import Biopython
import Bio

#Import Biopython modules
#Import the seqIO modules from Biopython for reading sequences files.
#Import the Entrez module from Biopython, which provide access to the NCBI databases.

from Bio import SeqIO
from Bio import Entrez

#Provide email address for NCBI services
Entrez.email = "abc@mail.com"

#specify the accession number of the nucleotide sequence
accession_number = "NM_001301719.1"

#fetch the sequence from the NCBI nucleotide database
handle = Entrez.efetch(db = "nucleotide", id=accession_number, rettype= "gb", retmode= "text")

"""Use the Entrez.efetch function to retrieve the information from the NCBI nucleotide database.
Parameters include the databases(db), the identifier(id), the return type(rettype), and the return mode
(retmode)."""

"""In the case, it fetches the GenBank-formatted data (rettype="gb") in plain text(retmode="text")"""

#Read the GenBank-formatted data using SeqIO

record = SeqIO.read(handle, "genbank")

#print the sequence
print(record.seq)