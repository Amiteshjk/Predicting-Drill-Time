# Predicting-Drill-Time

Question and background:

In mining engineering, holes are often drilled through rock, using drill bits. As a drill hole gets deeper, additional rods are added to the drill bit to enable additional drilling to take place.  It is expected that drilling time increases with depth. This increased drilling time could be caused by several factors, including the mass of the drill rods that are strung together. The business problem relates to whether drilling is faster using dry drilling holes or wet drilling holes. Data have been collected from a sample of 50 drill holes that contains measurements of the time to drill each additional 5 feet (in minutes), the depth (in feet), and whether the hole was a dry drilling hole or a wet drilling hole. A LR model is created to predict additional drilling time, based on depth and type of drilling hole (dry or wet).


Using the drill dataset, predict the drill time and answer following questions.


a. State the multiple regression equation.

1.	y=lm(time~depth+type)
2.	y=b0+b1*depth+b2*type
a.	b0=8.010; b1=0.005; b2= -2.105
3.	y=8.010+(0.005*depth)-(2.105*type)
 

b. Interpret the regression coefficients in (a).

    Considered dry=1 and wet=0
1.	Type - This means that dry drilling holes takes 2.105 mins lesser than wet drilling holes take.
2.	Depth – This means that increase in depth by 1 feet increases the drilling time by 0.005 mins.
The intercept alone in isolation here does not make sense since there will be no time without drilling (dry, wet) and depth.

c. Predict the mean additional drilling time for a dry drilling hole at a depth of 100 feet. Construct 
a 95% confidence interval estimate and a 95% prediction interval.

Mean additional drilling time = 6.427634 mins

Prediction and Confidence intervals at 95%
	fit     	lwr      	upr
Prediction interval	6.427634	4.92304	7.932228

Confidence interval	6.427634	6.209587	6.645681



d. Perform a residual analysis on the results and determine whether the regression assumptions are valid.
LINE Assumption plots 
 

Linearity – Residual vs Fitted plot does not have any specific pattern and hence can be considered the residuals to be linear.
Independence of errors – Based on Durbin Watson test, DW = 1.3577. Since its closer to 2, we can consider that it does not have much autocorrelation. (Actually Slightly positive autocorrelation)
Normality – Normal Q-Q - The residuals follow a normal distribution since clearly almost all the points fall approximately on the line.
Equal Variance – Scale-Location shows Homoscedasticity since amount of error in the residuals is almost similar at each point.
Therefore the regression assumptions are valid since all the LINE are followed. 

e. Is there a significant relationship between additional drilling time and the two independent variables (depth and type of drilling hole) at the 0.05 level of significance?
As per answer in (a), the p value is <0.05 for both depth and type. Hence there is a significant relationship between additional drilling time and the two independent variables (depth and type of drilling hole).

f. At the 0.05 level of significance, determine whether each independent variable makes a contribution to the regression model. Indicate the most appropriate regression model for this set of data.
Both type and depth makes a contribution to the regression model because of their p-value at 0.05 level of significance. Moreover, there is no multicollinearity for type and depth with time since VIF is equal to approximately 1 for both. 

g. Construct a 95% confidence interval estimate of the population slope for the relationship between additional drilling time and depth.
 	2.50%	97.50%
(Intercept)	7.673111709	8.34698625
depth	0.003164621	0.007291082
type	-2.402942087	-1.807457913

The 95% confidence interval for the regression slope is [0.003164621, 0.007291082]. Since this confidence interval doesn’t contain the value 0, we can conclude that there is a statistically significant association between depth and additional drilling time.

h. Construct a 95% confidence interval estimate of the population slope for the relationship between additional drilling time and the type of hole drilled.
 	2.50%	97.50%
(Intercept)	7.673111709	8.34698625
depth	0.003164621	0.007291082
type	-2.402942087	-1.807457913
		

The 95% confidence interval for the regression slope is [-2.402942087, -1.807457913]. Since this confidence interval doesn’t contain the value 0, we can conclude that there is a statistically significant association between type of hole drilled and additional drilling time.

i. Compute and interpret the adjusted r2.
The adjusted R^2 is 69% which means that 69% of the variation in Time is explained by Depth and Type of drilling holes. In this case, it means that there are some additional variables that we are missing out in the model which is impacting the time directly.

j. Compute the coefficients of partial determination and interpret their meaning.
This partial correlation between all independent variables and dependent variables. Time is correlated well with depth and type individually after controlling the other variable.

	time     	depth       	            type
time   	1.0000000	0.4547574	-0.8185271
depth  	0.4547574	1.0000000	0.3722312
type  	-0.8185271	0.3722312	1.0000000

k. What assumption do you need to make about the slope of additional drilling time with depth?
The slope of drilling time with depth is about 0.005 which means that when there is a 1 feet change in depth , there is 0.005 mins increase in time. This is negligible.

l. Add an interaction term to the model and, at the 0.05 level of significance, determine whether it makes a significant contribution to the model.
The interaction term doesn't make a significant contribution to the model since it is >0.05 and even adjusted R^2 remains the same. 
 

m. On the basis of the results of (f) and (l), which model is most appropriate? Explain.
Comparing the RMSE, MAE and Prediction error rate – 

	Interactive model	Additive model
RMSE	0.7178519	0.7210062
MSE	0.5746034	0.5754619
Pred. Error rate	0.09315493	0.09356426

The RMSE, MSE and Prediction error rate is slightly lesser in the case of interactive model. However this will not create a major difference. Also, the interaction term was not significant during the interaction model. Hence I would still go ahead with additive model for the main effects because there is only a very mild difference.

n. What conclusions can you reach concerning the effect of depth and type of drilling hole on drilling time?
Considered dry=1 and wet=0
1.	Type - This means that dry drilling holes takes 2.105 mins lesser than wet drilling holes take.
2.	Depth – This means that increase in depth by 1 feet increases the drilling time by 0.005 mins.
The intercept alone in isolation here does not make sense since there will be no time without drilling (dry, wet) and depth.





