# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Load the activity and feature info
3. Load x test, y test, subject and inertia test datasets and name their columns accordingly
4. Combine all test datasets
5. Add a new categorical column to represent `test` dataset
5. Load x train, y train, subject and inertia train datasets and name their columsn accordingly
6. Combine all train datasets
7. Add a new categorical column to represent `train` dataset
7. Merge test and train datasets
8. Select columns which reflect a mean `mean` or standard deviation `std`
9. Rename columns using descriptive and appropriate labels
10. Create a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file `dataset.txt`.
