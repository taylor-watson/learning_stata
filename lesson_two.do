******************************************
*** Learning Stata Lesson 2: Stata Graphics ***
******************************************

*** This do-file goes over some of the fundamentals of generating graphics with Stata. It roughly follows the later-half of the third of the video tutorials available through BU here: "https://www.bu.edu/econ/students/stata-resources/" ***

*** This do-file uses one datasets as inputs, which is available from the link above. Before using this code, be sure to download the following files:
	*mycleandata-Video-3-Data, available under Stata Instruction #3

*** We can start with our usual Stata opening commands
clear

cd "/Users/taylorwatson/Dropbox/Watson HiWi Files/EC204/Discussion/Discussion 2"

log using "discussion_2.log", replace	
	
*** Next let's bring in the data we'll be using

use mycleandata-Video-3-data



	
*** Graphing Data ***
* Bar Charts in Detail* 
* Twoway Plots in Detail*

* Bar Charts *
* Bar charts are easy to create using the graph command, specifying bar. You can also create them using the drop-down menu. It is often easiest to generate the graph using the drop-down, then copy the code into your do-file.

*Starting off, a simple bar chart of the average of earnings per week
graph bar (mean) earnweek

*We can adjust what summary statistic we're interested in - here we try the median
graph bar (median) earnweek

*We can break out the variable over different categories - here we try race
graph bar (mean) earnweek, over(race)

*Labels in graphs can get too long, overlapping - we can adjust their angle
*Note how this additional code goes inside the "over" we already had, to make it clear that we are adjusting the labels on race.
graph bar (mean) earnweek, over(race, label(angle(forty_five)))

*Let's now look at earnings by years of education
graph bar (mean) earnweek, over(yrs_educ) 

*Adding a title is often helpful, and is a straightforward option for the graph command
graph bar (mean) earnweek, over(yrs_educ) title(Earnings by Education)

*We can add another title for our y-axis variable specifically
graph bar (mean) earnweek, over(yrs_educ) title(Earnings by Education) ytitle(Earnings per Week)

*It may help to look at a variable broken over two different categories - here we take our existing category (yrs_educ) and look at the differences by marriage status as well
graph bar (mean) earnweek, over(yrs_educ) over(married) title(Earnings by Education) ytitle(Earnings per Week)
*If it looks a bit confusing, that's because the variable "married" is not well-labeled. A value of 1 (married == 1) means the observation is married, while a value of 0 (married == 0) means the observation is not married. 
*We cannot fix this directly through the graph - we have to go back to the data and use our label command from the previous Discussion to fix it.

tabulate married	//Tabulate the variable to see the different groups
label define marriage_labels 0 "Not Married" 1 "Married" //Define a set of labels
label values married marriage_labels //Apply our set of labels to the marriage variable
tabulate married	//Tabulate again to make sure our re-labeling worked

*Now when we create the bar graph by education and marriage, it will have nicer labels
graph bar (mean) earnweek, over(yrs_educ) over(married) title(Earnings by Education) ytitle(Earnings per Week)

*Sometimes you may only be interested in a few categories, or a sub-set of your data. This is when adding if-statements can help.
graph bar (mean) earnweek if yrs_educ == 12 | yrs_educ == 16 | yrs_educ == 18, over(yrs_educ) over(married) title(Earnings by Education) ytitle(Earnings per Week)

*The order of our two "over" groups is also important - watch what happens if we reverse it, putting married before yrs_educ.
graph bar (mean) earnweek if yrs_educ == 12 | yrs_educ == 16 | yrs_educ == 18, over(married) over(yrs_educ) title(Earnings by Education) ytitle(Earnings per Week)

*Again, this is a bit hard to read, so we may want to adjust the angles.
graph bar (mean) earnweek if yrs_educ == 12 | yrs_educ == 16 | yrs_educ == 18, over(married, label(angle(forty_five))) over(yrs_educ) title(Earnings by Education) ytitle(Earnings per Week)




* Twoway Plots *
* Scatterplots help us visualize the relationship between two variables. Instead of graph, we have to specify twoway. The "twoway" refers to how we are looking at two variables and their relationship. There are various kinds

*Here is a simple twoway, a scatterplot of earnings per week vs. age
twoway (scatter earnweek age)

*Scatterplots can give a sense of the richness in data, but sometimes with too much data they can get confusing. This is where using a twoway fit can be easier to read. Here we try a quadratic fit (qfit) twoway, which will fit a quadratic function to the raw data.
twoway (qfit earnweek age)

*We can do similar fits, such as linear fits, but it won't make as much sense for age, so let's try a linear fit on earnings and education.
twoway (lfit earnweek yrs_educ)

*It is often helpful to overlay the fitted line onto the raw data. To do so, you simply list both of the plots you want after the twoway command. Here we'll try to add the raw education data as a scatterplot.
twoway (lfit earnweek yrs_educ) (scatter earnweek yrs_educ)


