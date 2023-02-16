************************************************
*** Learning Stata Lesson 4: pwcorr and estat vif ***
************************************************

*** This do-file goes over two commands, pwcorr and estat vif, both of which are useful in assessing multicollinearity. 

*** This do-file uses one dataset as an input, which is available from the link below. Before using this code, be sure to download the following files:
*mycleandata-Video-3-Data, available under Stata Instruction #3 Data
*LINK: https://www.bu.edu/econ/students/stata-resources/stata-instruction-3/stata-instructional-video/

*** We can start with our usual Stata opening commands
clear

cd "/Users/taylorwatson/Dropbox/Watson HiWi Files/EC204/Discussion/Discussion 4"

log using "discussion_4.log", replace	
	
*** Next let's bring in the data we'll be using

use mycleandata-Video-3-data


*** Motivation - Multicollinearity *******************
*When running regressions, one thing to look for is multicollinearity between explanatory variables. In other words, you want to avoid regressing an outcome on two or more X variables which are collinear with each other. This can happen when two X variables are basically measuring the same thing, but in different ways (e.g., Years of Education and Education Categories are both variables which track how much education someone has). It can also happen when one variable is basically a transformed version of another (e.g., Income and Income Squared). The two commands covered in this session will provide helpful ways to diagnose whether your variables suffer from multicollinearity.


*** pwcorr *******************
*** Syntax: pwcorr varlist ***
******************************
* pwcorr stands for "Pairwise Correlation", meaning that it will calculate the correlation of each pair of variables you enter. It is fairly straightforward to implement, simply writing pwcorr and then listing all of the variables you want to see correlated.

*Let's start with an easy example of just two variables that we've seen before, income (via earnweek) and education (via yrs_educ)
pwcorr earnweek yrs_educ

*Note that we get a table of 3 resulting correlations: Two of them are 1.000, these are the "self-correlation" values for each variable. Stata will tell us these, even though they should be 1.0000, because the correlation of a variable to itself should always be 1.0000. The more interesting number is the correlation between the two different variables, which we see at 0.4517. You may notice a "blank" in the output table, in the row of earnweek and column of yrs_educ. This is not a mistake, but rather it is left blank on purpose, as the value is already given for this "pair" of variables in the row for yrs_educ and column for earnweek (0.4517). Stata doesn't want to repeat itself, so it leaves one of the two entries blank instead.

*Let's try an example with many more variables
pwcorr earnweek yrs_educ age year

*Now we get 6 different correlation estimates, one for each "pair" of these 4 variables. We can see for example that age is better-correlated with earnweek (0.239) than it is with yrs_educ (0.1276). We can now see several more blanks as well.

*We want to use this command to diagnose multicollinearity. In this dataset are two variables which are already well-correlated: yrs_educ and educ_cat. These are highly-correlated because they are measuring the same thing, amount of education, but in different ways. We can see that the correlation estimate is very high, close to 1.0:
pwcorr yrs_educ educ_cat

*We can also see high correlation if we create some new variables which are just transformations of existing variables. For example, let us create some variables which we know will be nearly collinear, and then compute the correlation. Let's try creating a variable of the square and the cube of earnweek.
gen earnweek_sq = earnweek^2
gen earnweek_cube = earnweek^3

pwcorr earnweek earnweek_sq earnweek_cube


*** estat vif ***********
*** Syntax: estat vif ***
*************************
* "estat" is a name for a group of commands in Stata, all related to "Estimation Statistics", giving us the name. When using these commands, they always calculate statistics for the last estimation / regression that Stata ran. In other words, you cannot run this by itself - you have to first run a regression, and then these commands.
*In particular, "estat vif" calculates the Variance Inflation Factors. This tests for multicollinearity between variables. In particular, when you use it in Stata, it will calculate the VIF of every independent variable used in the last regression you ran.

*Here's an example with a simple regression of earnings on some of the variables in our dataset. First we run the regression:
reg earnweek yrs_educ educ_cat married black

*Now we can run estat vif:
estat vif

*We can see from the output that two of our variables, educ_cat and yrs_educ have high VIF - about 8.35 for each. In contrast, the other two variables in the regression have low VIFs of 1.03 (married) and 1.01 (black). This tells us that the two education variables may suffer from multicollinearity, but the other two probably do not.

*Running this kind of a test can help you identify which variables you might be worried about for multicollinearity, and how you might need to change your regression approach to avoid misinterpretation.


*** Regressing with Categories - Example ***********
*Another kind of variable that can cause multicollinearity is categorical variables. For an example in this dataset, consider the four dummy variables for regions of the country: midwest, south, west, northeast. Each of these is a dummy (1 or 0) indicating whether an individual lives in the relevant region. It is easy to see that, for any given individual, if you know the value of the other three region variables, you will automatically know the fourth one. For example, if you know that someone has the following values: Midwest = 1, South = 0, West = 0, you will know that Northeast = 0 as well, as they cannot live in both the Midwest and the Northeast. This kind of collinearity is not allowed in regressions.
*Thankfully, Stata knows this, and will help you avoid this issue in cases of categorical variables. Watch what happens when we regress income on the full set of regional dummy variables:

regress earnweek midwest south west northeast

*You can see in the output that Stata has ignored one of the variables (it chose West, but it could have chosen any one of them). This prevents the regression from having perfect multicollinearity, as one of the dummies is not present in the regression. Stata even tells us this, listing the varible with "(omitted)" to let us know it left the variable out. This is also noted under the command in our log, as a brief note.
*Stata is good at recognizing perfect multicollinearity in cases like this, but note that in cases where there is just "very high" collinearity, it will not automatically drop one of the variables for us. This is why it is important to use the commands described above to diagnose situations of potential collinearity, and think carefully about what variables we include in a regression.


*********
log close
