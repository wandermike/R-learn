#完成浦丰投针试验（实验一）的理论分析，用R编程实现仿真模拟分析。
# 设置实验参数
needle_length <- 1  # 针的长度 l
line_distance <- 2  # 平行线间的距离 d
num_trials <- 10000  # 投掷次数 N

# 初始化交叉次数
cross_count <- 0  # X

# 进行仿真模拟
set.seed(123)  # 设置随机种子以便复现
for (i in 1:num_trials) {
  # 生成针的中点到最近线的距离
  midpoint <- runif(1, 0, line_distance / 2)
  
  # 生成针与平行线垂直方向的夹角
  angle <- runif(1, 0, pi / 2)
  
  # 计算针的两端是否与线相交
  if (midpoint <= (needle_length / 2) * sin(angle)) {
    cross_count <- cross_count + 1
  }
}

# 估计π的值
estimated_pi <- (le_length * num_trials) / (line_distance * cross_count)
cat("估计的π值：", estimated_pi, "\n")

#电梯问题
elevator<-function(r,n,m)
{
  y=0;
  for(i in 1:m)
  {
  #  u <- runif(r)
  #  x = floor(n*u)+1
    x =sample(1:n,r,rep(1/n,n),replace = T)
    y[i] = length(unique(x))
  }
  rt = mean(y);
  rt
}
elevator(10,7,5000)

#掷筛子问题
size<-function(n)
{
  p1 = 0;
  p2 = 0;
  for(i in 1:n)
  {
    u1<- sample(1:6,4,rep(1/6,6),replace =T)
                if(max(u1)==6)
                p1 = p1+1
                x2 = sample(1:6,24,replace =T)
                x3 = sample(1:6,24,replace =T)
                if(max(x3+x2)==12)
                  p2 = p2 +1
  }
  rt<-c('p(A)'=p1/n,'p(B)'=p2/n);
  rt
}
size(10000)

#报童问题
newspaper<-function(n,m,lambda,a,b)
{
  y = 0;
  for(i in 1:n)
  {
    x<- rpois(1,lambda)
    if(x<m)
      y[i] = a*x -b*(m-x)
    if(x>=m)
      y[i] = a*m
  }
  mean(y)
}
newspaper(10000,100,120,1.5,0.6)
newspaper(10000,140,120,1.5,0.6)

#摸球问题
tabletennisl<- function(n)
{
  m<-0
  for(j in 1:n)
  {
    x = sample(1:12,3,rep(1/12,12),replace=F)
    y = union(1:3,x)
    z = sample(1:12,3,rep(1/12,12),replace=F)
    if(length(intersect(y,z))==0)
    {m<-m+1}
    else
    {m<-m}
  }
  rt<-c('次数'=m,'频率'=m/n)
  rt 
}
tabletennisl(10000)

#掷色子二
size<-function(m)
{
  n = 0;
  k = 0;
  for(i in 1:m)
  {
    for(j in 1:m)
    {
      x =sample(1:6,2,rep(1/6,6),replace=T)
    if(sum(x)==5)
      {n=n+1;break;}
    if(sum(x)==7)
    {
      k =k +1;
      break;
    }
    }
    n=n;k=k;
  }
  rt<-c('概率'=n/(n+k))
  rt
}
size(10000)
  
  
  
  
  