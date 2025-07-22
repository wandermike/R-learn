# 流感预测问题：时间序列模型
## 数据集
library(data.table) #:= in this package
flu <- fread(here::here("data", "french_flu.csv"))
flu[, flu.rate := as.numeric(TauxGrippe)]
head(flu, n=2)

nrow(flu[is.na(flu.rate)])/nrow(flu)
unique(flu[is.na(flu.rate)]$region_name)


## 数据预处理
## 添加Date类型的字段
flu[, year := as.numeric(substr(week, 1, 4))]
flu[, wk := as.numeric(substr(week, 5, 6))]
flu[, date := as.Date(paste0(as.character(flu$week), "1"), "%Y%U%u")]
head(flu)

## 数据预处理
# 关注法兰西岛大区相关的数据，按日期排序，查看排序后的数据
paris.flu <- flu[region_name == "ILE-DE-FRANCE"]
paris.flu <- paris.flu[order(date, decreasing = FALSE)]
paris.flu[-1*(5:518), .(Id, week, date, flu.rate)]

## 查看每年记录的week数量
paris.flu[, .N, year]


## 查看每周记录的年份
paris.flu[, .N, wk][c(1,2,51,52,53)]

## 分析规律，是否存在趋势性或季节性
plot(paris.flu$date, paris.flu$flu.rate, type="l", xlab="Date", ylab="Flu rate")

#清楚53周的数据
paris.flu <- paris.flu[wk != 53]


## 季节性差分自回归移动平均模型(SARIMA)
# 绘制流感发病率的自相关系数和差分后的时间序列的自相关系数

par(mfrow=c(1,2))
acf(paris.flu$flu.rate, lag.max=104 )
acf(diff(paris.flu$flu.rate, 52), lag.max = 104)

## 按季节性(52周)差分后的数据再按季节性进行差分
plot(diff(diff(paris.flu$flu.rate, 52), 52), type="l")


## 按季节性差分后再进行一阶差分
plot(diff(diff(paris.flu$flu.rate, 52), 1), type="l")

## 选择$p$和$q$
par(mfrow=c(2,1))
paris.flu.52.1 <- diff(diff(paris.flu$flu.rate, 52), 1)
acf(paris.flu.52.1, lag.max = 104)
pacf(paris.flu.52.1, lag.max=104)


## 模型预测评估：前两年数据进行拟合
library(forecast)
first.fit.size <- 104
h <- 2
n <- nrow(paris.flu) - h - first.fit.size

first.fit <- arima(paris.flu$flu.rate[1:first.fit.size], order=c(2,1,0),
                   seasonal = list(order=c(0,1,0), period=52))
first.order <- arimaorder(first.fit)

# first.order
summary(first.fit)


## 向前滚动拟合并预测
fit.preds <- array(0, dim=c(n,h))
fit.coefs <- array(0, dim=c(n, length(first.fit$coef)))
for(i in (1+ first.fit.size):(nrow(paris.flu) - h)){
  data.to.fit <- paris.flu[1:i]
  fit <- arima(data.to.fit$flu.rate, order=first.order[1:3],
               seasonal=list(order=c(0,1,0), period=52))
  fit.preds[i-first.fit.size,] <- forecast(fit, h=2)$mean
  fit.coefs[i-first.fit.size,] <- fit$coef
}



ylim <- range(paris.flu$flu.rate[300:400], fit.preds[,h][(300-h):(400-h)])
par(mfrow=c(1,1))
plot(paris.flu$date[300:400], paris.flu$flu.rate[300:400],
     ylim=ylim, cex=0.8,
     main="Actual and predicted flu rate",
     xlab= "Date", ylab="Flu rate")
lines(paris.flu$date[300:400], fit.preds[,h][(300-h):(400-h)],col=2,
      lty=2, lwd=2)

