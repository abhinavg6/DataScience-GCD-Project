## Code Book - Project for Getting and Cleaning Data Course

### Key variables

* activities - Data frame for file activity_labels.txt
* features - Data frame for file features.txt
* trngsubdata - Data frame for file subject_train.txt
* trngactdata - Data frame for file y_train.txt
* trngsetdata - Data frame for file X_train.txt
* trngactsetdata - Merged data frame from activities and trngsetdata
* testsubdata - Data frame for file subject_test.txt
* testactdata - Data frame for file y_test.txt
* testsetdata - Data frame for file X_test.txt
* testactsetdata - Merged data frame from activities and testsetdata
* actsetdata - Joined/Merged data frame from trngactsetdata and testactsetdata, transformed to contain only relevant columns
* actsetfinaldata - Final data frame, transformed to contain average of all mean and standard deviation variables by each subject and activity

### Reading and Writing data
* Reading data - [read.table()](http://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html) was used to read all files, with header=FALSE as column names were absent in all input files
* Writing data - [write.table()](http://stat.ethz.ch/R-manual/R-devel/library/utils/html/write.table.html) was used to write the tidy data set to output file

### Key transformations

* Setting column names for reference data sets - [setnames()](http://stat.ethz.ch/R-manual/R-devel/library/stats/html/setNames.html) was used to set column names in all data frames except for trngsetdata and testsetdata data frames
* Mapping column names for actual data sets - [colnames()](http://stat.ethz.ch/R-manual/R-patched/library/base/html/colnames.html) was used to map column names from features data frame to trngsetdata and testsetdata data frames
* Adding columns to data sets - [cbind()](http://stat.ethz.ch/R-manual/R-devel/library/base/html/cbind.html) was used to add activity label and subject columns to trngsetdata and testsetdata data frames
* Merging data sets - [merge()](http://stat.ethz.ch/R-manual/R-devel/library/base/html/merge.html) was used to merge the activites data frame with trngsetdata and testsetdata data frames
* Merging/Joining data sets - [rbind()](http://stat.ethz.ch/R-manual/R-patched/library/base/html/cbind.html) was used to join data from trngsetdata and testsetdata data frames to create actsetdata
* Extracting relevant columns - [grep()](http://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html) was used to find mean and standard deviation variables from the features data frame, which were then extracted from actsetdata data frame using "in" operator
* Reshaped data to get final data set - melt() and dcast() from [reshape2](http://cran.r-project.org/web/packages/reshape2/reshape2.pdf) were used to transform actsetdata data frame to finally have average of each relevant variable by subject and activity

