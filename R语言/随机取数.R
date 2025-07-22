#随机取值
evennumber<-function(m)
{
  n<-0;
  for(j in 1:m)
  {
    x=sample(1:4,3,rep(1/4,4),replace = F)
    if(x[3]%%2==0)
    {
      n<-n+1
    }
    else
    {
      n<-n
    }
  }
  cat("进行了", m, "次随机试验\n在 1 到 4 中随机不放回的抽取三个数组成偶数的概率为:",n/m)
}
evennumber(10000)


#随机取数实验二
evennumber2<-function(n)
  {
  m<-0
  for (j in 1:n)
  {
    p = rep(1/10,10)
    x = sample(0:9,4,p=p,replace = F)
    if(x[1]!=0&x[4]%%2==0)
      m<-m+1;
      m<-m;
  }
  cat("进行了", n, "次随机试验\n在 0 到 9 中随机不放回的抽取四个数组成偶数个数为:",m,"\n","概率为:",m/n)
}
evennumber2(10000)

#随机取数实验三
getnumber3<-function(n)
{
  m<-0;
  for(j in 1:n)
  {
    x = sample(1:10,7,rep(1/10,10),replace = T);
    if(length(unique(x))==7)
      m<-m+1;
       m<-m;
  }
  cat("进行了", n, "次随机试验\n在 1 到 10 中放回的随机抽取7个数都不相同的次数为:",m,"\n","概率为:",m/n)
}
getnumber3(10000)

#随机取数实验四
getnumber4<-function(n)
{
  m<-0;
  for(j in 1:n)
  {
    x = sample(1:10,7,rep(1/10,10),replace = T);
    if(sort(x)[5]<10&sort(x)[6]==10)
      m<-m+1;
    m<-m;
  }
  cat("进行了", n, "次随机试验\n在 1 到 10 中放回的随机抽取7个数,10恰好出现两次的次数为:",m,"\n","概率为:",m/n)
}
getnumber4(10000)
