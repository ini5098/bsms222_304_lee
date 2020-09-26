a <- c(1,2,3,4,5)
a
b <- c(1,2,3,4,5)
b
c <- c("1","2","3","4","5")
c

m = matrix(c(a,b), ncol=5)
m
class(m)

library(dslabs)
data(murders)

class(murders)
m
str(murders)

head(murders)
tail(murders)

colnames(murders)

murders[ ,"state"]
murders$state

a <- murders$state
a
class(a)

a<-murders[ , "state", drop=F]
class(a)

View(murders)
View(ls)

d = read.delim("non_alt_loci_set.txt")

class(d)
colnames(d)
View(d)

table(d$locus_group) #counting the frequency of the variable

