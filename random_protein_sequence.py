import Bio
from Bio.Seq import Seq
import random

amino_acids = "ATGCATGCATGCATGCATGC"

#random.choice is used to create random sequence of amino acids.
#Convert the generated sequence(a string) into a Biopython 'Seq' object.

random_protein_sequence  = Seq("".join(random.choice(amino_acids)for _ in range(50)))

#Print the random protein sequence
print(random_protein_sequence)
