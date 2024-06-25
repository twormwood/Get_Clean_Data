## **Code book for Getting and Cleaning Data Course Project**

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here is the data used for the project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

#### An R script called run_analysis.R was created that does the following:

1.  Merges the training and the test sets to create one data set.

2.  Extracts only the measurements on the mean and standard deviation for each measurement.

3.  Uses descriptive activity names to name the activities in the data set

4.  Appropriately labels the data set with descriptive variable names.

5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The run_analysis.R file attempts to explain the transformations performed as denoted by \## but I will also explain the transformations performed here in detailed sequential steps.

1.  Zip file is downloaded from cloud source

2.  Zip file is unzipped and stored in a folder called "UCI HAR Dataset". The files used in this script are:

    -   README.txt

    -   features_info.txt: Shows information about the variables used on the feature vector.

    -   features.txt: List of all features.

    -   activity_labels.txt: Links the class labels with their activity name.

    -   train/X_train.txt: Training set.

    -   train/y_train.txt: Training labels.

    -   test/X_test.txt: Test set.

    -   test/y_test.txt: Test labels.

        The following is available for the train and test data. Their descriptions are equivalent.

        -   train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

3.  Working directory is changed to the folder where data was downloaded

4.  Txt formatted files are read into data frames in R:

    -   The features.txt file contains the column names for the X_test and X_train data frames, so these column names are added.
    -   The y_test and y_train files contain the activity id number that corresponds to each measurement in X_test and X_train.
    -   The subject_test and subject_train files contain the subject id number that corresponds to each measurement in X_test and X_train.
    -   The activity_labels file matches the activity id number to the descriptive activity label.

5.  The activity ids from y_test and y_train are added to the X_test and X_train data files

6.  The subject ids from subject_test and subject_train are added to the X_test and X_train data files

7.  A label "test" or "train" is added to the corresponding data tables to differentiate between the two groups later on.

8.  The testing and training datasets are merged

9.  The descriptive activity labels are added to the merged dataset

10. Columns are reorganized so that the characteristic variables are listed in columns 1:4, while the measurements are in columns 5:565

11. "tBody", "tGravity", and "fBody" variable names are changed to "TimeBody", "TimeGravity", and "FrequencyBody". These variables are changed because t and f and explained in the features_info.txt file. Apart from this, variable names remain untouched because the variable names are already very long. The features_info.txt file contains the complete explanation for each measurement. The most common abbreviations in the measurement names are explained here:

    -   mean(): Mean value

    -   std(): Standard deviation

    -   mad(): Median absolute deviation

    -   max(): Largest value in array

    -   min(): Smallest value in array

    -   sma(): Signal magnitude area

    -   energy(): Energy measure. Sum of the squares divided by the number of values.

    -   iqr(): Interquartile range

    -   entropy(): Signal entropy

    -   arCoeff(): Autorregresion coefficients with Burg order equal to 4

    -   correlation(): correlation coefficient between two signals

    -   maxInds(): index of the frequency component with largest magnitude

    -   meanFreq(): Weighted average of the frequency components to obtain a mean frequency

    -   skewness(): skewness of the frequency domain signal

    -   kurtosis(): kurtosis of the frequency domain signal

    -   bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.

    -   angle(): Angle between to vectors.

12. The complete_data dataset is written to a csv. The code must be run to access this csv, as GitHub is not for storing large data files.

13. A subset of the complete_data is created which only includes measurements that are a mean or standard deviation.

14. The subset_cd is written to a csv.

15. Mean by subject id and mean by activity label are calculated, and both are combined into one table called tidy_means.

16. The tidy_means dataset is written to a csv.
