#import Biopython
import Bio

#Import the PDBParser class from Bio.PDB
from Bio.PDB import PDBParser

#Specify the PDB file
pdb_filename = "file.pdb"

#create a PDB Parser object
parser = PDBParser()

#Parse the PDB file and get the structure
"""the get_structure method of the PDBParser object is used to parse the specified PDB file and obtain a
hierchical representation of the structure."""

structure = parser.get_structure("file.pdb", pdb_filename)

#Iterate through the structure
for model in structure:
    #Iterate through the models
    for chain in model:
        #Iterate through the chain
        for residue in chain:
            #print info about each residue
            print(residue)