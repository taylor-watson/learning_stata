*********************************************
*** Learning Stata Lesson 1: Stata Basics ***
*********************************************

*** This do-file reviews some of the fundamental Stata commands to begin working in Stata. It roughly follows the video tutorials available through BU here: "https://www.bu.edu/econ/students/stata-resources/" ***

*** This do-file uses two datasets as inputs, both of which are available from the link above. Before using this code, be sure to download the following two files:
	* File 1: IPUMS-Clean-Excel-to-Import.xlsx, available under Stata Instruction #1
	* File 2: Stata-Instructional-Video-2-Data.dta, available under Stata Instruction #2


*** Getting Started ***
* Clearing *
* Setting Directory *
* Logging *

* 1) clear command *
* This command clears or erases the data currently held in Stata's memory. It is a good practice to do this at the beginning of every Stata code, to ensure that Stata's memory is empty when we start working.

clear all


* 2) cd command *
* The cd command changes the working directory - the directory on your computer that Stata is working in. This is the folder / location on your computer that Stata looks to for inputs and sends outputs to. You can always specify where you want Stata to look for inputs or send outputs in the code, but setting the working directory can save time from having to do this over and over.

cd "/Users/taylorwatson/Dropbox/Watson HiWi Files/EC204/Discussion/Discussion 1"

pwd // Print Working Directory can be used to confirm what the current WD is


* 3) log command *
* A log file is a record of everything you do in a session of Stata work, saved as a .txt file. These can be very helpful for reviewing your code or finding bugs. When we use the log command, we have to also tell Stata what to use as the location / name of the log file. 

log using "/Users/taylorwatson/Dropbox/Watson Hiwi Files/EC204/Discussion/Discussion 1/discussion_1.log", replace // Start our log file, save it in the folder we want, and name it "discussion_1"



*** Exploring Data ***
* Using *
* Importing *
* List Labels * 
* Summarizing *
* Tabulating*
	
* 4) import command *
* To analyze a dataset in Stata, we have two options: we can use a dataset that is already in the Stata-format, or we can import a dataset that is not in the Stata-format and reformat it. Let's look at the second option first, as it's most common. We will import an Excel file from our working space into Stata.

import excel using "/Users/taylorwatson/Dropbox/Watson Hiwi Files/EC204/Discussion/Discussion 1/IPUMS-Clean-Excel-to-Import.xlsx", sheet("Sheet1") firstrow clear // Import Excel-format data

browse	// Browse to confirm the data look right

save "/Users/taylorwatson/Dropbox/Watson Hiwi Files/EC204/Discussion/Discussion 1/IPUMS clean.dta", replace // Save this data as a Stata-format dataset


* 5) using command *
* If we have a dataset which is already formatted for Stata, then we don't have to import it. We can instead just "use" the dataset with the using command.

use "Stata-Instructional-Video-2-Data.dta", replace

* Note that we can simply say use and the name of the file itself, rather than specifying the full file path to the location of the file. This is because the file is in our Working Directory that we set earlier, so Stata knows where to look for it. If the file was not in our Working Directory, but was somewhere else on our computer, then we would have to be more specific in telling Stata where to find the file we want, like this:

use "/Users/taylorwatson/Dropbox/Watson HiWi Files/EC204/Discussion/Discussion 1/Stata-Instructional-Video-2-Data.dta", replace

* A brief note on this dataset: this data is from IPUMS-CPS for March 2000 and March 2014 on year, weekly earnings (earnweek), sex, race, marital status (marst), region, # years of education (educ) and age. Apart from that, there are some variables like "serial, month, hwtfinl, cpsid, asecflag, pernum, wtfinl, cpsidp" that CPS preselects for us. They are identifier and statistical weight variables. We don't need these variables.


* 6) label list command *
* For any variable, Stata will display the variable's name and the variable's label. The name is how Stata calls the variable, while the label is useful for us as users to understand what the variable is representing. This command lists all the variables and labels to see them more clearly.

label list


* 7) summarize command *
* Stata will summarize a variable for us using the summarize command, giving some basic facts about a variable

sum age // Summarize the Age variable

sum earnweek // Summarize the Earnings per Week variable


* 8) tabulate command *
* (STATA syntax: tabulate varname or tab varname or ta varname) *
* This command creates a frequency table of a variable, showing you how often each value of that variable occurs across all observations in the dataset.

tabulate educ



*** Editing Data ***
* Renaming * 
* Relpacing * 
* Generating *
* Labeling *
* Dropping *
* Keeping *
* Saving *

* 9) rename command *
* (STATA syntax: rename old_varname new_varname) *
* This command lets us change the names of variables in Stata. We often do this if the name is confusing, or we want to make the name more specific.

rename month cps_month // Rename the existing variable called "month" to now be called "cps_month"


* 10) replace command *
* (STATA syntax: replace oldvar = exp [if] [in]) *
* This command lets you replace some values of a variable with new values. In this example, we'll replace values of the education variable. Stata likes to use a period (.) to identify missing values, but the dataset we're using has used the number 1. Therefore, we're going to tell Stata to replace the education variable with a period if the education variable equals 1 for each observation.

replace educ = . if educ == 1 // Replace education with . if education is 1


* 11) generate command *
* (STATA syntax: generate newvar = oldvar or gen newvar = oldvar) *
* Generate lets us create new variables. In this example, we will create a variable for the years of education somebody has, building off of the existing variable education.

cap generate yrs_educ = educ	// Generate the new variable called "yrs_educ"

* So far we have just made a duplicate variable - for every observation, their value of yrs_educ is the same as their value of educ. What we want to do is "translate" the values of educ into the values we want - years of education. We can do this using the replace command as follows: 

replace yrs_educ = 0 if educ == 2 // Replace yrs_educ with 0 if the educ variable is 2
replace yrs_educ = 4 if educ == 10 // Replace yrs_educ with 4 if the educ variable is 10
replace yrs_educ = 6 if educ == 20 // etc etc
replace yrs_educ = 8 if educ == 30
replace yrs_educ = 9 if educ == 40
replace yrs_educ = 10 if educ == 50
replace yrs_educ = 11 if educ == 60 | educ == 71
replace yrs_educ = 12 if educ == 73
replace yrs_educ = 13 if educ == 81
replace yrs_educ = 14 if educ == 91 | educ == 92
replace yrs_educ = 16 if educ == 111
replace yrs_educ = 18 if educ == 123
replace yrs_educ = 21 if educ == 124 | educ == 125
replace yrs_educ = . if educ == .


* 12) label  command *
* Similar to the rename command, we can change the label of a variable. This can make it more clear what a variable really is, versus what we call it for convenience.
* We will do two kinds of labeling: i. labelling a variable itself, ii. labelling the codes of a variable.

* i) labeling variable *
* (STATA syntax: label variable varname ["label"]) *

label variable yrs_educ "number of years of completed schooling" // Label the variable we generated earlier

* ii) labeling codes *
* This part uses two steps *
 
* Step 1: Define the label values (STATA syntax: label define lblname # "label")

label define yrs_educl 0 "less than HS" 4 "less than HS" 6 "less than HS" 8 "less than HS" 9 "less than HS" 10 "less than HS" 11 "less than HS" 12 "HS graduate" 13 "some college" 14 "some college" 16 "college graduate" 18 "grad school" 21 "grad school"

* Step 2: Assign label to variables (STATA syntax: label values varlist lblname)

label values yrs_educ yrs_educl // Label the values of the variable yrs_educ with the code labels stored in yrs_educl

tabulate yrs_educ // Tabulate the variable to see the labels


* 13) drop command *
* Drop lets us delete data from our dataset. 
* We can delete in two ways: i. deleting entire variables, ii. deleting observations.

* i) drop entire variables 
* (STATA syntax: drop variable name(s)) *

drop serial // Drop the variable serial

drop hwtfinl asecflag // Drop the variables hwtfinl and asecflag

* ii) dropping certain observations within variables 
* (STATA syntax: drop if ) * 

drop if educ == . // Drop observations if their education value is missing


* 14) keep command *
* (STATA syntax: keep variable name(s)) *
* The opposite of drop, the keep command will keep only the variables specified, and will therefore drop all the other variables. In this example, we will keep only the variables year age race earnweek sex marst region and yrs_educ

keep year age race earnweek sex marst region yrs_educ // Keep variables


* 15) save command *
* After we do a lot of data editing, we usually want to save the dataset under a new name, to separate the clean version from the original version. 

save "/Users/taylorwatson/Dropbox/Watson HiWi Files/EC204/Discussion/Discussion 1/Stata-Instructional-Video-2-Data-Clean.dta", replace 

* As a reminder, if we have set the Working Directory correctly, then we do not need to tell stata this long file path of where to save the file. We can instead simply tell Stata to save the file, and it will automatically save it in our Working Directory, like this:

save "Stata-Instructional-Video-2-Data-Clean.dta", replace



*** Graphing Data ***
* Bar Charts * 
* Pie Charts *
* Histograms *
* Scatterplots *

* 16) graph bar command *
* Bar charts are easy to create using the graph bar command. You can also create them using the drop-down menu. My preference is usually to start with the drop-down, then customize using the command itself.

graph bar, over(sex) // Simple bar graph of percentages

graph bar (count), over(sex) // Bar graph of raw count values


* 17) graph pie command *
* Pie charts are also easy to create.

graph pie, over(race) // Simple pie chart

graph pie, over(race) plabel(_all percent) // Add some labels


* 18) histogram command *
* Histograms are great for visualizing the distribution of a variable.

histogram earnweek // Simple histogram 

histogram earnweek if earnweek < 9999 // Simple histogram (ignoring the top-coded values)

histogram earnweek if earnweek < 9999, percent bin(10) // Specify the number of bins


* 19) graph twoway scatter command *
* (STATA syntax: graph twoway scatter y-variable x-variable) *
* Scatterplots help us visualize the relationship between two variables.

graph twoway scatter earnweek age // Simple scatterplot

graph twoway scatter earnweek age if earnweek < 9999 // Simple scatterplot (ignoring top-coded values)



*** Ending ***

* 20) log close command *
* You should tell Stata to close the logfile at the end of your session, otherwise it will keep recording.
 
log close



