library(readxl)
library(fastDummies)
library(jtools)
require (ppcor)

## Read file
setwd("/Users/amiteshjk/Desktop/JGBS/Term 3/Predictive Analytics/Datasets/")
drill_original=read_excel("Drill.xlsx",sheet = 1,col_names=TRUE)
drill_original

drill=drill_original
drill
drill=as.data.frame(drill)
drill

drill2=drill

## Create dummy using fastdummies - Method 1
library(fastDummies)
drill2=dummy_cols(drill2,select_columns = "Type")
str(drill2)

## Remove categorical column from updated dataframe and pass this for model
drill2
drill2_updated=data.frame(drill2$Depth,drill2$Time,drill2$Type_dry,drill2$Type_wet)
drill2_updated


## Dummy variable is just 2 category -Converting categorical variable into 1 for dry and 0 for wet - Method 2
for (i in 1:nrow(drill))
{
  if (drill$Type[i]=='dry')
  {
    drill$Type[i]=1
  }else
  {
    drill$Type[i]=0
  }
}

drill

## Use same variable name as in original data (ex - Depth=drill$Depth)
depth=drill$Depth
time=drill$Time
type=drill$Type



hist(time)

type=as.numeric(type)
type

##correlation between dependent and independent
cor(type,time)
plot(type,time)

cor(depth,time)
plot(depth,time)


a=data.frame(time,depth,type)
pairs(a)

## Partial correlation

ppcor::pcor(a)

## Regression model development using full data

y=lm(time~depth+type)
summ(y)
summary(y)

## CHECK if p value for any variable is not significant or >0.05 - then remove that variable from 
## the model and re-run model without that variable

## Adding VIF values in model - VIF to test multicollinearity for independent variables
#1 = not correlated, Between 1 and 5 = moderately correlated; Greater than 5/10 = highly correlated.
summ (y, vifs=T,confint = T) 

# set in jtools for 3 decimal places
options ("jtools-digits"=3)

## Adding part and partial correlation values in model
summ (y, vifs=T,part.corr=T,confint = T)


## Predicting using the overall model - should do this using training data model
newdata=data.frame(type=1,depth=100)
predict(y,newdata, interval="predict")
predict(y, newdata, interval="confidence")

?predict()

##Residual analysis - LINE assumption 
## Residuals vs Fitted (Linearity) -  A horizontal line, without distinct patterns is an indication for a linear relationship, what is good.
## Residuals vs Leverage (Independence of error) - Shows outliers, check durbin watson for this. Value should be close to 2 for no autocorrelation
## Normal Q-Q (Normality) - Dots should be on or close to the line
## Scale-Location (Equal variance) - Homescedastic if points are random or equally spread. Should not follow fan shape then it is heteroscadastic

## LINE plots
par(mfrow=c(2,2))
plot(y)

## Durbin watson to check ## Residuals vs Leverage (Independence of error)

## Range= 0 to 4;value of 0 to 2 shows positive autocorrelation,
## values from 2 to 4 show negative autocorrelation ; 
## Value of 2, shows that there is no autocorrelation ; 

## It needs to be closer to 2

require(lmtest)
dwtest(y)


## Standardizing coefficients - Shows which variable is a better predictor
require (lm.beta)
lm.beta(y) 
print(lm.beta(y), digits = 2)


#plotting coefficients
require (ggstance)
plot_coefs(y)

##95% confidence interval
library(stats)
library("MASS")
confint(y)

## Data partitioning into training and testing
set.seed(1234)


## Method 1 - not exactly splitting
drill
cv <- sample(2, nrow(drill),replace = TRUE,prob = c(0.8, 0.2))
cv

Training_Data=drill[cv==1,]
Testing_Data=drill[cv==2,]

## Method 2 - use this
cv = sort(sample(nrow(drill), nrow(drill)*.8))
train<-drill[cv,]
test<-drill[-cv,]

test
train

nrow(Training_Data)
nrow(Testing_Data)

nrow(test)
nrow(train)



## Training - Additive model

## Creating model using training data - name of columns should be same as original data or col names which is in train 
j=lm(Time~Depth+Type,data=train) 
summ(j)


#Predicting test data values using training model

pred=predict(j,test) ## Predicting value of y of test data based on the regression model formed with training data
round(pred,2)
test$Time ## col name same as in test data

## Prediction error metrics
require (Metrics)

rmse(test$Time,pred)
mae(test$Time,pred)

#prediction error rate - has to be closer to 0 - as low as possible
rmse(test$Time,pred)/mean(test$Time) ## Compare this with interactive model and decide which is better



## Interactive model - Follow same steps with interaction term

i=lm(Time~Depth+Type+Depth:Type,data=train) 
summ(i)

summ (i, vifs=T,part.corr=T,confint = T)
i

#prediction

pred_interactive=predict(i,test) ## Predicting value of y of test data based on the regression model formed with training data
round(pred_interactive,2)
test$Time

require (Metrics)
rmse(test$Time,pred_interactive)
mae(test$Time,pred_interactive)
#prediction error rate
rmse(test$Time,pred_interactive)/mean(test$Time)





