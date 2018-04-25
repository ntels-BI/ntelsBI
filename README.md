<br><br>

Install
-------

    devtools::install_github("ntels-BI/ntelsBI")

<br><br>

Tutorial
--------

### Machine learning

`ml()` 함수를 이용하여 기계학습 훈련 및 평가를 수행

-   CART 를 통한 `iris` 꽃잎분류

<!-- -->

    ml(iris, "Species", method = "rpart") %>% fitSummary(type = "cla")

    ## Confusion Matrix and Statistics
    ## 
    ##             Reference
    ## Prediction   setosa versicolor virginica
    ##   setosa         15          0         0
    ##   versicolor      0         12         1
    ##   virginica       0          3        14
    ## 
    ## Overall Statistics
    ##                                           
    ##                Accuracy : 0.9111          
    ##                  95% CI : (0.7878, 0.9752)
    ##     No Information Rate : 0.3333          
    ##     P-Value [Acc > NIR] : 8.467e-16       
    ##                                           
    ##                   Kappa : 0.8667          
    ##  Mcnemar's Test P-Value : NA              
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: setosa Class: versicolor Class: virginica
    ## Sensitivity                 1.0000            0.8000           0.9333
    ## Specificity                 1.0000            0.9667           0.9000
    ## Pos Pred Value              1.0000            0.9231           0.8235
    ## Neg Pred Value              1.0000            0.9062           0.9643
    ## Prevalence                  0.3333            0.3333           0.3333
    ## Detection Rate              0.3333            0.2667           0.3111
    ## Detection Prevalence        0.3333            0.2889           0.3778
    ## Balanced Accuracy           1.0000            0.8833           0.9167

-   GLM 을 통한 `Sonar` 의 `Class` 분류 (Class = "R" 이 주관심사일 경우)

<!-- -->

    data(Sonar, package = "mlbench")
    ml(Sonar, "Class", method = "glm") %>% fitSummary(type = "cla", positive = "R")

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction  M  R
    ##          M 22  9
    ##          R 11 20
    ##                                           
    ##                Accuracy : 0.6774          
    ##                  95% CI : (0.5466, 0.7906)
    ##     No Information Rate : 0.5323          
    ##     P-Value [Acc > NIR] : 0.01444         
    ##                                           
    ##                   Kappa : 0.3548          
    ##  Mcnemar's Test P-Value : 0.82306         
    ##                                           
    ##             Sensitivity : 0.6897          
    ##             Specificity : 0.6667          
    ##          Pos Pred Value : 0.6452          
    ##          Neg Pred Value : 0.7097          
    ##              Prevalence : 0.4677          
    ##          Detection Rate : 0.3226          
    ##    Detection Prevalence : 0.5000          
    ##       Balanced Accuracy : 0.6782          
    ##                                           
    ##        'Positive' Class : R               
    ## 

-   Random forest 를 통한 `mtcars` mpg 예측

<!-- -->

    ml(mtcars, "mpg", method = "rf") %>% fitSummary(type = "reg")

    ## [1] 10.91898

<br>

### Useful Preprocessing

-   `spCoordinateTrans()` function : 위경도 좌표변환

<!-- -->

    exdata <- data.frame(long = c(1039197, 1041137, 1039216, 1037176), 
                         lat = c(1926417, 1927056, 1927526, 1924963))

    exdata # UTM-K(GRS-80)

    ##      long     lat
    ## 1 1039197 1926417
    ## 2 1041137 1927056
    ## 3 1039216 1927526
    ## 4 1037176 1924963

    spCoordinateTrans(exdata$long, exdata$lat) # To WGS84

    ##       long      lat
    ## 1 127.9425 37.33594
    ## 2 127.9644 37.34161
    ## 3 127.9428 37.34593
    ## 4 127.9196 37.32292

<br><br>

License
-------

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
