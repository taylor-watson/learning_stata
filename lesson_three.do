**************************************************
*** Learning Stata Lesson 3: The Regression Command ***
**************************************************

*** This do-file goes over the regression command.

*** This do-file uses one dataset as an input. Before using this code, be sure to go to the link below and download the following file:
*https://www.bu.edu/econ/students/stata-resources/
*mycleandata-Video-3-Data, available under Stata Instruction #3

*** We can start with our usual Stata opening commands
clear

cd "/Users/taylorwatson/Dropbox/Watson HiWi Files/EC204/Discussion/Discussion 3" // Be sure to change the directory to your local working space

log using "discussion_3.log", replace	
	
*** Next let's bring in the data we'll be using

use mycleandata-Video-3-data


	
*** Regression Command ***

*The reg command is a versatile tool for running ordinary least squares linear regressions in Stata. Today we will focus on the simplest form of the command and go over how to read the output that Stata gives you after you use it. The command has a lot of additional options, but we won't need to cover those yet.

*For our example, we will be regressing income on education, a classic economic relationship of interest. In particular, we will use the log of income as our depdent variable and years of education as our independent variable. Unfortunately, our dataset only has the raw income values, so we must first generate a new variable equal to the log of the raw income variable:

gen log_income = log(earnweek)

*With our Y variable settled, we can proceed to running the regression. The syntax we will use today is simple:
*"reg Y X", or put another way "reg dependent_var independent_var"

reg log_income yrs_educ

*This command produces an output table in the Stata results window.
