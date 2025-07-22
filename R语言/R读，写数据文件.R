#读纯文本文件
rt<-read.table("C:/Users/王/Desktop/练习/R语言练习/houses.data")
rt
is.data.frame(rt)     #判断是否为数据框格式
inp<-scan("C:/Users/王/Desktop/练习/R语言练习/h_w.data",list(height=0,weight=0))
inp
is.list(inp)          #判断是否为列表格式

#读其他格式的数据文件

#读spss,sas,atata数据文件
rs<-read.spaa("data.sav",to.date.frame=TRUE)     #读SPSS文件,后者将列表转化为数据框
rx<-read.xport("date.xpt")                       #读SAS文件，类型为数据框
rd<-read.dta("date.dta")                         #读Stata文件，类型为数据框

#读Excel文件
rd<-read.delim("data.txt")            #将excle转化为文本文件，数据框
rc<-read.csv("data.csv")              #将excle转化为CSV文件，数据框
re<-read.xlsx("data.xlsx")            #转换为xlsx文件格式，数据框

#链接到数据库
data()

#写数据文件
write(x,file="data",append=FALSE)   #TURE为添加，F为写新文件
write.table(df,file="foo.txt")      #写文本文件
write.csv(df,file="foo.csv")        #写CSV文件
