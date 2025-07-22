##数组与矩阵的生成

#将向量定义为数组
Z<-1:12;
dim(Z)<-c(3,4);     #将向量变为3行四列矩阵
Z
dim(Z)<-12;         #将向量定义为一维数组
Z 

#用函数构造多维数组
X<-array(1:20,dim=c(4,5));
X
Z<-array(0,dim=c(3,4,2));
Z
A<-matrix(1:15,nrow=3,ncol=5,byrow=T);  #byrow=T时，按行放置，否则按列，生成二维矩阵函数
A
A<-matrix(1:15,ncol=5,byrow=T);
A

#数组下标
a<-1:24;
dim(a)<-c(2,3,4);
a[2,1,2]
b<-matrix(c(1,1,1,2,2,3,1,3,4,2,1,4),ncol=3,byrow=T);
a[b]

#数组的四则运算
A<-matrix(1:6,nrow=2,byrow=T);
B<-matrix(1:6,nrow=2,byrow=F);
A+B
A-B
A/B
A*B

#矩阵的运算
a<-matrix(1:6,nrow=2);
a
t(a)     #矩阵的转置
det(a)   #矩阵的行列式
X<-1:5;
Y<-2*1:5;
X%*%Y           #向量的内积或用crossprod(X,Y)
X%o%Y           #向量的外积或用outer(X,Y)
A<-matrix(1:6,nrow=2,byrow=T);
B<-matrix(1:6,nrow=2,byrow=F);
A%*%B           #矩阵的乘法
diag(X)         #令向量为对角元素 
diag(A)         #去对角元素

#解线性方程组AX=B与求逆
A<-t(array(c(1:8,10),dim=c(3,3)));
b<-c(1,1,1);
X<-solve(A,b);   #解AX=B
X
solve(A)         #求矩阵A的逆

#特征值与特征向量
A<-matrix(1:4,nrow=2,byrow=T);
eigen(A)         #求A的特征值与特征向量

#与矩阵数组运算有关的函数
A<-matrix(1:6,nrow=2,byrow=T);
dim(A)           #得到矩阵A的维数
nrow(A)          #得到矩阵A的行数
ncol(A)          #得到矩阵A的列数
X1<-cbind(c(1,2),c(3,4));    #矩阵纵向合并
X1
X2<-10+X1;
X3<-cbind(X1,X2);            #矩阵横向合并
X3
A<-matrix(1:6,nrow=2,byrow=T);
A
as.vector(A)                 #将矩阵拉直按列转换为向量

#矩阵行与列命名
X<-matrix(1:6,ncol=2,dimnames = list(c("one","two","three"),c("First","Second")),byrow=T);
X

#矩阵广义转置
A<-array(1:24,dim=c(2,3,4));
B<-aperm(A,c(2,3,1));
A
B

#矩阵运算相关的函数
A<-array(1:24,dim=c(2,3));
A
apply(A,1,sum)
apply(A,2,mean)
