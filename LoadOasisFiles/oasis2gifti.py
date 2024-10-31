# -*- coding: utf-8 -*-
"""

"""
import nibabel as nib
surf_file =  'C://Users//12SDa//davenpor//Data//Oasis//oasis_cs_freesurfer_disc1//disc1//OAS1_0001_MR1//surf//lh.sphere'
a = nib.freesurfer.read_geometry(surf_file)
coords = a[0]
faces = a[1]

# %%
a = read_geometry2(surf_file)
