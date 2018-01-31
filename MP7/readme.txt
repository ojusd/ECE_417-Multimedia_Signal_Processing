MP7: Akhil Alapaty & Ojus Deshmukh

run.m:

This function takes in the data directory.  Since all data files are contained in the same folder as the code, the command "run('.')" works fine.

imagewarp.m:

This function takes in four inputs:
vert: The vertices of the triangles
tri_pts: The points that make up the triangles
lip_pts: This consists of the three visual dimensions: w, h1, h2
input:The original input image

It goes through each frame and obtains the input image's warped equivalent based off of the values of the inputs.