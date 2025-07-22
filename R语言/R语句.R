#分支语句
a<-1;
if (a<0)      #if语句
  a=3;
  a=5;        #不用加else，但多个用加
a
  
#生成随机数
rnorm(4)          #生成正态分布
runif(4)          #生成均匀分布

#switch语句
x<-3;
switch(2,2+2,mean(1:10),rnorm(4))

#控制语句
v<-c(1,2,35,36,26,37,89);
for(i in v)
{
  if(i%%2==0)
    next
  print(i)
}

#生成4*4的Hilbert矩阵
n<-4;
x<-array(0,dim=c(4,4));
for(i in 1:n)
  {
  for(j in 1:n)
    {
    x[i,j]<-1/(i+j-1)
    }
  }
x

#while循环例子
f<-1;
f[2]<-1;
i<-1;
while(f[i]+f[i+1]<1000)
{
  f[i+2]<-f[i]+f[i+1]
  i<-i+1
}
f

#break函数应用
f<-1;
f[2]<-1;
i<-1;
repeat{
  if(f[i]+f[i+1]>1000)
    break
  f[i+2]<-f[i]+f[i+1]
  i<-i+1
}
f

#二分法求解
fzero<-function(f,a,b,esp=1e-5)
  {
  if(f(a)*f(b)>0)
    list(fill="没有解!")
  else{
    repeat{
      if(abs(b-a)<esp)
         break;
      x<-(a+b)/2;
      if(f(a)*f(x)<0)
        b<-x
      else
        a<-x
    }
    list(root=(a+b)/2,fun=f(x))
  }
}
f<-function(x)
{
  return(2*x^3-6*x-1)
}
fzero(f,-1,0)
uniroot(f,lower=-1.1,upper=-0.1,tol=1e-6)#直接定义

#Newtons法求解
funs<-function(x)
{
  f<-c(x[1]^2+x[2]-1,x[1]^3-x[2]);
  J<-matrix(c(2*x[1],1,3*x[1]^2,-1),nrow = 2,byrow = T);
  list(f=f,J=J);
}
Newtons <- function(funs, x0, tol = 1e-5, max_iter = 1000) # max_iter为迭代次数，tol为误差(精度)
{
  x <- x0 #赋初值
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

