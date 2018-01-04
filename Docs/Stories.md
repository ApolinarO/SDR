# Big Project
## About
This program provides a user-friendly interface to access the NHANES data sets. The interface allows users to select and combine different data sets. The user would then download the data into a file in the format of their choice.

## Stories
**A)** The user selects a data set along with some of its properties. These properties could be any combination of the columns within the given data set.
- *Risk*: low
- *Time*: 2 Days
- *Tests*: Test that the way of extracting the tables is consistent.


**B)** The user selects other tables to combine with the current data set. The table can be combined any number of ways. By default, it combines using the id number.
- *Risk*: mid
- *Time*: 4 Days
- *Tests*: Test that the same table is not allowed to combine with itself.

**C)** When the user has selected the tables and the properties of those tables, they are able to download it into the file format of their choice.
- *Risk*: low
- *Time*: 2 Days
- *Tests*: Test that the downloaded formats has the same data when converted back into the RDA format.

___
**D)** Once the user has downloaded their data, they can view the data being visualized in a series of different plots using the GGPlot library.
- *Risk*: high
- *Time*: 1 week
- *Tests*: Test that the plot works on extrordinary cases such as not having data to plot.

### Devlopers
Apolinar Ortega | Antonio Ruiz | Jacob C Darling
--- | --- | --- 
