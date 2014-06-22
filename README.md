### Introduction

The R script run_analysis.R transforms a [wearable computing raw dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to a tidy dataset. The raw dataset represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full descrioption is available at the site where data was obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The script does the following steps in this order:
<ol>
<li>Reads the reference data files for list of activities and features</li>
<li>Reads the training and test data files, including corresponding subject and activity label files</li>
<li>Transforms the training and test data sets by adding names for existing columns, and adding other required columns</li>
<li>Joins/Merges the training and test data sets into one, and extracting only mean and standard deviation variables, as required</li>
<li>Reshapes the merged data set to contain the average of each mean and standard deviation variable by each subject and activity</li>
<li>Writes the reshaped tidy data set to a output file for further analysis</li>
</ol>

