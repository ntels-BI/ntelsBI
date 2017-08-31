# Analysis R package for ntels Business Intelligence Team

## Tutorial

### Machine learning

`ml()` 함수를 이용하여 기계학습 훈련 및 평가를 수행할 수 있습니다.  

* CART 를 통한 `iris` 꽃잎분류


```r
ml(iris, "Species", method = "rpart") %>% fitSummary(type = "cla")
```

```
## Confusion Matrix and Statistics
## 
##             Reference
## Prediction   setosa versicolor virginica
##   setosa         15          0         0
##   versicolor      0         14         5
##   virginica       0          1        10
## 
## Overall Statistics
##                                             
##                Accuracy : 0.8667            
##                  95% CI : (0.7321, 0.9495)  
##     No Information Rate : 0.3333            
##     P-Value [Acc > NIR] : 0.0000000000001905
##                                             
##                   Kappa : 0.8               
##  Mcnemar's Test P-Value : NA                
## 
## Statistics by Class:
## 
##                      Class: setosa Class: versicolor Class: virginica
## Sensitivity                 1.0000            0.9333           0.6667
## Specificity                 1.0000            0.8333           0.9667
## Pos Pred Value              1.0000            0.7368           0.9091
## Neg Pred Value              1.0000            0.9615           0.8529
## Prevalence                  0.3333            0.3333           0.3333
## Detection Rate              0.3333            0.3111           0.2222
## Detection Prevalence        0.3333            0.4222           0.2444
## Balanced Accuracy           1.0000            0.8833           0.8167
```

* GLM 을 통한 `Sonar` 의 `Class` 분류 (Class = "R" 이 주관심사일 경우)


```r
data(Sonar, package = "mlbench")
ml(Sonar, "Class", method = "glm") %>% fitSummary(type = "cla", positive = "R")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction  M  R
##          M 26 12
##          R  7 17
##                                           
##                Accuracy : 0.6935          
##                  95% CI : (0.5635, 0.8044)
##     No Information Rate : 0.5323          
##     P-Value [Acc > NIR] : 0.007171        
##                                           
##                   Kappa : 0.378           
##  Mcnemar's Test P-Value : 0.358795        
##                                           
##             Sensitivity : 0.5862          
##             Specificity : 0.7879          
##          Pos Pred Value : 0.7083          
##          Neg Pred Value : 0.6842          
##              Prevalence : 0.4677          
##          Detection Rate : 0.2742          
##    Detection Prevalence : 0.3871          
##       Balanced Accuracy : 0.6870          
##                                           
##        'Positive' Class : R               
## 
```

* Random forest 를 통한 `mtcars` mpg 예측


```r
ml(mtcars, "mpg", method = "rf") %>% fitSummary(type = "reg")
```

```
## [1] 5.675074
```

<br>

### Useful preprocessing

* `range01()` function : Standardization 0 to 100


```r
x <- c(0, 4, 7, 9, 10)
range01(x) * 100 
```

```
## [1]   0  40  70  90 100
```

## Install


```r
devtools::install_github("ntels-BI/ntelsBI")
```

<br>

## License

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
