#列表的构造
Lst<-list(name="Fred",wife="MAry",no.children=1:3,child.ages=c(4,7,9));
Lst
Lst[[2]]
Lst[[4]][2]
Lst[["name"]]
Lst$name

#列表的修改
Lst$name<-"John"             #列表元素的修改
Lst$income<-c(1900,1600)     #列表中加入元素   

#列表的连接
list.ABC<-c(list.A,list.B,list.C)    #列表的整合

##数据框
#数据框的生成
df<-data.frame(Name = c("Alice","Becka","Jeffrey","John","James"),Sex=c("F","F","M","M","M"),Age=c(13,13,13,13,12),Height=c(56.5,65.3,57.3,62.5,59.0),Wight=c(84.0,98.0,83.0,84.0,99.5));
df
Lst<-list(name="Fred",wife="MAry",no.children=1,child.ages=5);
as.data.frame(Lst)       #将列表转化为数据框
X<-array(1:6,c(2,3));
data.frame(X)            #将矩阵转化为数据框

#数据框的引用
df<-data.frame(Name = c("Alice","Becka","Jeffrey","John","James"),Sex=c("F","F","M","M","M"),Age=c(13,13,13,13,12),Height=c(56.5,65.3,57.3,62.5,59.0),Wight=c(84.0,98.0,83.0,84.0,99.5));
df
df[1:2,3:5]
df[["Height"]]
df$Age
rownames(df)<-c("one","two","three","four","five");  #对列命名
df

#数据框的调用
df<-data.frame(Name = c("Alice","Becka","Jeffrey","John","James"),Sex=c("F","F","M","M","M"),Age=c(13,13,13,13,12),Height=c(56.5,65.3,57.3,62.5,59.0),Wight=c(84.0,98.0,83.0,84.0,99.5));
df
attach(df);       #将变量连接到内存中，方便调用
r<-Height/Wight;
df$r
detach();            #取消连接
xnew<-edit(df)       #对原列表进行编辑在数据编辑器中更新