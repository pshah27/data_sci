---
title: "README.md"
output: html_document
---

Pavan Shah

The file run_Analysis.R loads all the relevant data first.
It loads the training data and then test data.

Then the data is merged.

Then the data is truncated so that only the columns with “mean” and “std and “Mean” are extracted.

Then I named the activities by merging the activity ids with their names.

Then I created a mean and std of each variable for each activity and subject combination.
There are 180 such combinations.
I did so by first grouping the dataset and then using aggregate function.

Then I simply did some cleaning up by adding column names.
Then I wrote the table out to Tidy_Data.txt .
