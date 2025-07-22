# 二分法
f<-function(x)
{
 return(1+5*x-6*x^3-exp(2*x));
}
curve(f,from=-1,to=1);
abline(h = 0, col = "red");
abline(v = 0, col = "green");
grid()
uniroot(f,lower=-1.1,upper=-0.1,tol=1e-6)
uniroot(f,lower=-0.5,upper=0.5,tol=1e-6)
uniroot(f,lower= 0.1,upper=1.1,tol=1e-6)

# 牛顿法
funs<-function(x)
{
  f<-c(x[1]^2+x[2]-1,x[1]^3-x[2]);
  J<-matrix(c(2*x[1],1,3*x[1]^2,-1),nrow = 2,byrow = T);
  list(f=f,J=J);
}
Newtons <- function(funs, x0, tol = 1e-3, max_iter = 1000)
{
x <- x0
for (i in 1:max_iter) 
{
# 计算函数值和雅可比矩阵
res <- funs(x)
f <- res$f
J <- res$J
# 计算雅可比矩阵的逆
J_inv <- solve(J)
# 更新 x
x_new <- x - J_inv %*% f
# 检查收敛条件
if (max(abs(x_new - x)) < tol) 
{
cat("迭代了", i, "次。\n结果为:\n")
return(x_new)
}
# 更新 x
x <- x_new
}
warning("没有迭代出")
return(x)
}
Newtons(funs,c(-0.8,0.6))

# 牛顿法
# 生成样本数据
set.seed(123)  # 设置随机种子以保证结果可复现
n_true <- 10
p_true <- 0.5
m <- 100
samples <- rbinom(m, n_true, p_true)
# 计算样本均值和样本方差
sample_mean <- mean(samples)
sample_var <- var(samples)
# 定义目标函数和雅可比矩阵
funs <- function(params) {
  n <- params[1]
  p <- params[2]
  f <- c(n * p - sample_mean,n * p * (1 - p) - sample_var)
  J <- matrix(c(p, n, p * (1 - p), n * (1 - 2 * p)), nrow = 2, byrow = TRUE)
  list(f = f, J = J)
}
# 定义牛顿法求解函数
Newtons <- function(funs, x0, tol = 1e-7, max_iter = 1000) {
  x <- x0
  for (i in 1:max_iter) {
    # 计算函数值和雅可比矩阵
    res <- funs(x)
    f <- res$f
    J <- res$J
    # 计算雅可比矩阵的逆
    J_inv <- solve(J)
    # 更新 x
    x_new <- x - J_inv %*% f
    # 检查收敛条件
    if (max(abs(x_new - x)) < tol) {
      cat("在第", i, "次迭代中收敛。\n")
      return(x_new)
    }
    # 更新 x
    x <- x_new
  }
  warning("达到最大迭代次数但未收敛。")
  return(x)
}

# 初始猜测值
x0 <- c(1, 0.5)
# 调用 Newtons 函数并求解
solution <- Newtons(funs, x0)
print(solution)
# 输出结果
cat("估计的 n:", solution[1], "\n")
cat("估计的 p:", solution[2], "\n")

# 循环法
# 定义一个函数来检查数字是否包含数字6
iscontains6 <- function(num) {
  return(grepl("6", as.character(num)))#包含6返回T
}
# 定义一个函数来检查数字是否不能被6整除
isnot_divisible_by_6 <- function(num) {
  return(num %% 6 != 0)#不被整除返回T
}
# 初始化计数器
count <- 0
# 枚举所有五位数
for (num in 10000:99999) {
  if (iscontains6(num) && isnot_divisible_by_6(num)) {
    
    count <- count + 1
  }
}
# 输出结果
cat("含有数字6却不能被6整除的5位数的数量为:", count, "\n")

# 迭代法
set.seed(123)  # 设置随机种子以保证结果可复现
# 定义模拟次数
num_simulations <- 10000
# 定义一个函数来模拟从扑克牌中抽取两张牌并检查是否为同一种花色
same_suit <- function() {
  # 创建扑克牌，4种花色，每种花色13张
  suits <- rep(c("红桃", "黑桃", "黑方", "红方"), each = 13)
  
  # 随机抽取两张牌
  drawn_cards <- sample(suits, 2)
  
  # 检查两张牌是否为同一种花色
  return(drawn_cards[1] == drawn_cards[2])
}

# 运行模拟并计算同一种花色的次数
same_suit_count <- sum(replicate(num_simulations, same_suit()))

# 计算概率
probability_same_suit <- same_suit_count / num_simulations

# 输出结果
cat("从一副标准的52张扑克牌中随机取出两张，并且这两张是同一种花色的概率为:", probability_same_suit, "\n")

