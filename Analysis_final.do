
/* Randomization verification tests */
regress nb_meal agequantised
regress nb_meal genderquantised
regress nb_meal occupationquantised
regress nb_meal householdquantised
regress nb_meal cookquantised
regress nb_meal plannerquantised
regress nb_meal selfefficacyquantised
regress nb_meal ingredientstypequantised
regress time_per_meal agequantised
regress time_per_meal genderquantised
regress time_per_meal occupationquantised
regress time_per_meal householdquantised
regress time_per_meal cookquantised
regress time_per_meal plannerquantised
regress time_per_meal selfefficacyquantised
regress time_per_meal ingredientstypequantised


/* Pairwise Correlations */
pwcorr dqii nb_meals genderquantised agequantised occupationquantised householdquantised cookquantised plannerquantised selfeff
> icacyquantised ingredientstypequantised, sig


/* Linear Regression to analyze time per meal */
regress dqii time_per_meal
estat hettest
regress dqii time_per_meal genderquantised

/* Linear Regression to analyze nb_meal */
regress dqii nb_meal
estat hettest
regress dqii nb_meal genderquantised

/* Multilinear regression for interaction effect */
regress dqii time_per_meal nb_meals
estat hettest
regress dqii time_per_meal nb_meals, vce(robust)
generate time_per_mealsNb_meals = time_per_meals*nb_meals
regress dqii nb_meals time_per_meals time_per_mealsNb_meals
estat hettest
regress dqii nb_meals time_per_meals time_per_mealsNb_meals, vce(robust)

/* Exploration analysis on Gender */
betterbar dqii, ci n by(genderquantised) over(nb_meals) legend(on) title("DQI-I")
graph export "C:\Users\flori\Documents\Master\LSE\Dissertation\DQII_GENDER_BOXPLOT.pdf", as(pdf) replace
twoway (histogram dqii if genderquantised==1, freq normal start(20) width(1) color(red%30))(histogram dqii if genderquantised==2, start(20) width(1) color(green%30)),legend(order(1 "Male" 2 "Female" ))
histogram dqii if genderquantised==1, freq normal start(20) width(1)
graph export "C:\Users\flori\Documents\Master\LSE\Dissertation\DQII_Male.pdf", as(pdf)
histogram dqii if genderquantised==2, freq normal start(20) width(1)
graph export "C:\Users\flori\Documents\Master\LSE\Dissertation\DQII_Female.pdf", as(pdf)

regress dqii nb_meals if genderquantised == 1
regress dqii nb_meals if genderquantised == 2

/* Exploration analysis of Real time used for the task */
generate true_time_per_meal = reaction_time/nb_meals
regress dqii true_time_per_meal
tabulate time_per_meals, summarize(true_time_per_meal)
graph box true_time_per_meal, over(time_per_meals)
