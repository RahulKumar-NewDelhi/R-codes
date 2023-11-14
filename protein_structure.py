import Bio
from Bio.PDB import PDBList

#specify the PDB code
pdb_code = "1YY8"

#Create a PDBList object
pdb_list = PDBList()

#Retrieve the PDB file
"""The retrieve pdb file method of the PDBList object is used to download the PDB file associated with
the specified PDB code.
The file format = "pdb"argument specifies that the file should be in the PDB format"""

pdb_list.retrieve_pdb_file(pdb_code, file_format="pdb")
