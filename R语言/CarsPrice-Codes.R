# 二手汽车价格问题：回归预测
# 数据样本：804个样本，18个变量

library(caret)
library(dplyr)
data(cars, package = "caret")


## 描述性统计分析
library(gridExtra)
p1 = ggplot(cars, aes(as.factor(Cylinder), Price)) + geom_boxplot() + xlab("Cylinder")
p2 = ggplot(cars, aes(as.factor(Doors), Price)) + geom_boxplot() + xlab("Doors")
p3 = ggplot(cars, aes(as.factor(Buick), Price)) + geom_boxplot() + xlab("Buick")
p4 = ggplot(cars, aes(as.factor(convertible), Price)) + geom_boxplot() + xlab("convertible")
grid.arrange(p1, p2, p3, p4, ncol = 2)

## 定量输入、输出变量
ggplot(cars, aes(Mileage, Price)) + geom_hex(bins = 50)


## 特征选择：去除相关性较高的变量
cars.feature <- cars[, 2:18]
cars.price <- cars[,1]
cars_cor <- cor(cars.feature)
findCorrelation(cars_cor, cutoff=0.75)
corrplot::corrplot(cars_cor, method = "color", addCoef.col = "black")

## 线性组合的特征
# 是否存在特征是其他特征的完全线性组合
findLinearCombos(cars.feature)
cars.feature.new <- cars.feature[,c(-14, -17)]
cars.new <- cars[,c(-15, -18)]
names(cars)[c(15,18)]

# 划分85$\%$的数据为训练集，15$\%$的数据为测试集。
set.seed(115511)
cars.smp <- createDataPartition(cars$Price, p=0.85, list=FALSE)
cars.train <- cars.new[cars.smp,]
cars.train.features <- cars.new[cars.smp,-1]
cars.train.lab <- cars.new$Price[cars.smp]
cars.test <- cars.new[-cars.smp,]
cars.test.features <- cars.new[-cars.smp, -1]
cars.test.lab <- cars.new$Price[cars.smp]
dim(cars.train)
dim(cars.test)


## 线性回归模型
cars.model1 <- lm(Price ~ ., data=cars.train)
summary(cars.model1)
## 结果分析
alias(cars.model1)

## 重新拟合回归
cars.model2 <- lm(Price ~. -Saturn, data=cars.train)
summary(cars.model2)

## 残差分析
par(mfrow=c(2,2))
plot(cars.model2)

## 特征选择：向前选择，向后选择
# 选择特征子集建立新的模型，模型中涉及部分特征，模型更简单、更易于训练和解释
# 向后选择：从一个完整的模型开始，根据去除的特征能最大改善模型评分逐个去除特征，得到一个新的模型
cars.model0 <- lm(Price ~ 1, data=cars.train)
cars.model3 <- step(cars.model2, scope = list(lower=cars.model0, upper=cars.model2),
                    direction = "backward")

#最终丢弃的特征：Cruise、Sound、Chevy, Saturn, coupe, wagon

## 残差分析
par(mfrow=c(2,2))
plot(cars.model3)


## 预测数据：均方差
## 去除Saturn, coupe, wagon后得到的模型预测的均方差：
cars.test.pred2 <- predict(cars.model2, cars.test)
computeMse <- function(pred, y){
  mean((pred-y)^2)
}
model2.mse <- computeMse(cars.test.pred2, cars.test$Price)
model2.mse

## 去除Cruise、Sound、Chevy, Saturn, coupe, wagon后模型预测的均方差：
cars.test.pred3 <- predict(cars.model3, cars.test)
model3.mse <- computeMse(cars.test.pred3, cars.test$Price)
model3.mse
