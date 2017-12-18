# Big Project
### Devlopers
Apolinar Ortega | Antonio Ruiz | Jacob C Darling
--- | --- | --- 

## About
This program will provide a user-friendly interface to access the NHANES data set. The interface would allow users to select and combine different data sets. The user would then download a file with the format of their choice with the selected data.

## Stories?
**A)** The user selects a table and selects properties of that table. These properties could be any combination of the columns within the given data set.
- *Risk*: low
- *Time*: 2 Days
- *Tests*: Test that the right columns are selected.


**B)** The user selects other tables to combine with the current data set. The table can be combined any number of ways. By default, it combines using the id number.
- *Risk*: mid
- *Time*: 4 Days
- *Tests*: Test that the same table cannot combine with itself.

**C)** When the user has selected the tables and the properties of those tables, they are able to download it into the file format of their choice.
- *Risk*: low
- *Time*: 2 Days
- *Tests*: Test that the downloaded formats has the same data when turned back into the RDA format.

**D)** Once the user has downloaded their data, they can view the data being visualized in a series of different plots using the GGPlot library.
- *Risk*: high
- *Time*: 1 week
- *Tests*: Test that the plot works on extrordinary cases such as not having data to plot.
