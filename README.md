# saltafoss
Code to help realise an artistic project by Davide Barberi. This repo supports the creation of the project "saltafoss" (temporary name). 

saltafoss.m
The code helps visualizing audio files in a 3D graph.
When running the code a popup windows asks to select an audio file (change file extension on read function to switch between audio formats). The programm plots 6 different angles of the spectral plot. A .tiff file is saved for every audio file at a resolution of 600dpi.

Two images are then exported, one figure with linear scales and one with logaritmic.

stl_file.m
Code imports audio files, calculates the spectrogram and exportsa a STL file ready for 3D printing with the Frequency, Time and Amplitude axis. 

Execute the code in the main folder and select a folder containing the mp3 files that need to be converted. 
