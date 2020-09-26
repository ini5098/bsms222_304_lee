200909

a <- 'say"
# 실행 결과에서 오는 +는 커맨드가 아직 끝나지 않음을 의미 (아무것도 실행되지 않음, ESC로 빠져나갈수 있음)
"'

a <- seq(1,5) #sequence
a
a[1:3] #subset

a <- c('1','a',3)
a
# coercion

library(dslabs)
data(murders)
str(murders)
#실행결과 출력된 구조에서 각 벡터 앞부분을 통해 구성성분의 class 확인 가능

a <- c('1','2','3')
class(a)
b <- as.numeric(a)
class(b)
b

sum(b, na.rm = T)
# NA (missing value) 제거

a <- c( seq(2,5), seq(1,10))
a
sort(a)
sort(a, decreasing = T)
#sorting

a
order(a)
order(a, decreasing = T)
max(a)
min(a)
which.min(a)
a[which.min(a)]
#which로 출력되는 요소의 위치가 인덱스

str(murders)
#factor
unique(murders$region)
head(murders$region, 10)
levels(murders$region)
as.character(murders$region)
#factor->character
as.numeric(murders$region)
#-> numeric

# https://htmlpreview.github.io/?https://github.com/joonan30/bsms222_123_an/blob/master/analyze_scn2a_mutations.nb.html

d = read.csv('https://www.dropbox.com/s/he7r6v4hxu0ibno/tableS1.Sanders2018.txt?dl=1', sep='\t')

head(d)
str(d)
# options(stringsAsFactors = F) : 최신 버전 R에서는 디폴트값이 FALSE로 지정되어 factors 자동지정X)

table(d$Effect)
class(d$Effect)
factor(d$Effect)
# or as.factor(d$Effect)
# factor로 저장
factor(d$Effect, levels = c("Missense", "Frameshift", "Nonsense"))

d$TrueRecurrence

table(d$Type)



# 200914
# 조건문

a = 'apple'
a == 'apple' # is this apple?

# if / else
a = 'apple'

if (a == 'apple'){
  print('Yes')
} else {
  print('No')
}

a = 'banana'
b = 0

if (a == 'apple'){
  b = b + 1
} else {
  b = b - 2
}

b

# ifelse : 한 줄에서 if/else 사용

# ifelse(TEST, TRUE, FALSE)

a = c('apple', 'Banana', 'apple')

ifelse(a == 'apple', 'Yes', 'No')

# "Yes" "No"  "Yes"

# subset
d = read.csv('https://www.dropbox.com/s/he7r6v4hxu0ibno/tableS1.Sanders2018.txt?dl=1', sep='\t')

d$Effect == 'Missense'

d1 = d[d$Effect == 'Missense',]
View(d1)
# subset을 할 때에는 TRUE 인자만 가져옴

# Function
# y = ax + b

# if else와 달리 함수 안의 variable들은 함수에 내장될 뿐 environment에는 저장 X, 
# environment에 저장된 variable에 영향 주지 않음

# namespace ::
# 여러 패키지 내에서 동일한 이름을 가지는 서로 다른 함수를 선택
dplyr::filter
?filter
stats::filter
dplyr::filter

#SCNA2

# 1. Create a function to figure out a start position of cDNA of SCN2A.
# 2. Plot the relationship between cDNA and protein positions.
# 3. Plot the protein positions of missense mutation for de novo and inherited variants.
# 4. Plot the relationship between seizure onset days and age at assessment.

options(stringsAsFactors = F)
d = read.csv('https://www.dropbox.com/s/he7r6v4hxu0ibno/tableS1.Sanders2018.txt?dl=1', sep='\t')

# Q1

head(as.numeric(d$Pos_hg19) - as.numeric(gsub('[^0-9]', '', d$c.DNA)) + 1)

#gsub('[^0-9]', '', 'c.34G>A')) : c.34G>A에서 0부터9까지의 숫자만 남겨라.


# 200916

# for-loop

for(i in 1:5){
  print(i)
}

i = 0
for(i in 1:50){
  i = i + 1
}
print(i)

d = read.csv('https://www.dropbox.com/s/he7r6v4hxu0ibno/tableS1.Sanders2018.txt?dl=1', sep='\t')

for(i in rownames(d)){
  d1=d[i,]
}
print(i)

# d1은 루프가 끝나는 시점에 덮어씌워지므로 마지막 줄에 해당됨

# gsub('old_pattern','new_pattern', a)
a = 'apple'
gsub('le', '', a) 

b = c('apple','banana','melon')

for (a in b){
  print(gsub('a','',a))
}

c = gsub('a', '',b)
c
# "pple"  "bnn"   "melon"
# 인풋이 벡터라 결과값도 벡터로 출력됨

head(d$Effect)
d$Effect2 <- gsub('Miss','',d$Effect)
d$Effect2

# '[^0-9]' : 0-9를 제외하고
# '[^A-Z]' : A-Z를 제외하고

# SeizureOnsetDays 중 가장 늦게 발현된 경우의 날짜 찾기
t <- d$SeizureOnsetDays
a <- as.numeric(gsub('[^0-9]','',t))
max(a, na.rm = TRUE)
# na.rm = TRUE 중요!!!
# or
a <- as.numeric(gsub('[^0-9]','',d$SeizureOnsetDays))
a[which.max(a)]

# Max value of Seizure Onset days by effect
unique(d$Effect) # Effect 내 값의 목록 출력
q <- unique(d$Effect)
for(i in q){
  d1 <- d[d$Effect == i,]
  print(max(as.numeric(gsub('[^0-9]','',d1$SeizureOnsetDays)),na.rm = TRUE))
}

# Plot the relationship between cDNA and protein positions of missense variants.
# Hint: cDNA position -> `c.DNA` column and protein position -> `p.Protein` column.

d2 <- d[d$Effect == 'Missense',]
a <- as.numeric(gsub('[^0-9]','',d2$c.DNA))
b <- as.numeric(gsub('[^0-9]','',d2$p.Protein))
plot(a,b)


#Quiz
# 200916
# Please send me an answer via Slack Direct Message. 
#Q1. You have a data frame "d", which contains the column "fruit".  
#    You want to select rows that contain "apple" in that column.
#    Please write down a command to do this.
d[d$fruit == "apple",]

#Q2. You want to replace the character "less" with "ed" in the vector
#    called "a". Please write down a command to do this.
a <- gsub('less', 'ed', a)

#Q3. Please write down a command to sort values in the column 'age'
#   in the data frame 'd'.
sort(d$age)

# 200921
## Scn2a tutorial
library(tidyverse)
d = read.csv('https://www.dropbox.com/s/he7r6v4hxu0ibno/tableS1.Sanders2018.txt?dl=1', sep='\t')

d1 = filter(d, Effect == 'Missense') # d1 = d[d$Effect == 'Missense',]
d1 = d %>% filter(Effect == 'Missense')

# Task
# 1) subset the rows with missense variants
# 2) Then, create a new data frame, calles "d1" from the selected rows
# 3) Add the column called "AA" with 1
d1 = d %>% filter(Effect == 'Missense') %>% mutate(AA =1)

# 4) Add the column called "BB" with 1
# 5) Add the column called "CC" with 1
d1 = d %>% filter(Effect == 'Missense') %>% mutate(AA =1, BB=1, CC=1)

# Task2
d = read.csv('table.gencode.txt.gz', sep='\t')
d %>% filter(seqnames == 'chr22', type == 'gene') %>% nrow()

# Quiz
# Q1. You have a data frame "df", which contains the column "phone". 
# You want to select rows that contain "iPhone" in that column. 
# Please write down a "tidyverse" code to do this.

# A1. df %>% filter(phone == 'iPhone')

# Q2. You have a data frame "df", which contains two columns - 
# 1) fruit, and 2) store. The column "fruit" contains several rows for "apple", 
# "banana" and "peach". The column "store" contains several rows for "Anam", 
# "Chamsari", and "Hipjiro". You want to select rows that contain both "apple" 
# and "Chamsari". Please write down a "tidyverse" code to do this.

# A2. df %>% filter(fruit == "apple", store == "Chamsari") 

# Q3. Please write down a tidyverse code you can add a new column, called "rating". 
# In this column, you want to give your score, "Good" for all rows. 

# A3. df %>% mutate(rating == "Good")


## 200923

d = read.delim('table.chr3_22_X.txt.gz')

table(d$seqnames) # 각 항목이 몇개 존재하는가 

# gene > transcript > exon의 계층으로 구성

d1 <- d %>% group_by(seqnames, type, source) %>% count()

# 각 염색체에서 가장 길이가 긴 유전자의 길이는 몇? 즉, 가장 긴 유전자를 갖고 있는 염색체는 무엇일까요?

d %>% g

# gene과 transcript, exon의 길이의 평균(mean)과 중간값(median)을 구하세요.

d2 <- d %>% group_by(type) %>% summarize(mean=mean(width), median=median(width))

# 염색체 별로 gene과 transcript, exon의 길이의 평균(mean)과 중간값(median)을 구하세요.

d3 <- d %>% group_by(seqnames, type) %>% summarize(mean=mean(width), median=median(width))

# 염색체에 상관없이 gene_type 별로 유전자 길이의 평균과 중간값을 구하세요. 어떤 결과로 나올까요?

d4 <- d %>% group_by(gene_type) %>% filter(type == 'gene') %>% summarize(mean=mean(width), median=median(width))

# gene type 별 숫자를 계수 해주세요

d %>% group_by(gene_type) %>% count() #로 하면 결과값에서 겹치는 부분이 있음(gene에 transcript 포함됨)

# 염색체 별로, HAVANA와 ENSEMBL에 해당하는 유전자 숫자를 계수해주세요.

d %>% filter(type == "gene") %>% group_by(source) %>% count()

# Quiz
# 1. 유전자별로 transcript의 숫자를 계수하시요.

d %>% filter(type == 'transcript') %>% group_by(gene_id) %>% count()

# 2. 가장 transcript를 많이 갖고 있는 유전자를 찾아보세요.

d %>% filter(type == 'transcript') %>% group_by(gene_id) %>% count() %>% as.data.frame() %>% top_n(1, n)

# 3. 유전자별로 exon의 숫자를 계수하세요.
d2 <- d %>% filter(type == 'exon') %>% group_by(gene_id, exon_id) %>% count() %>% group_by(gene_id) %>% count()

# 답안
# 1번
d %>% 
  group_by(gene_name) %>% 
  filter(type == "transcript") %>% 
  count() 
# 2번
d %>% 
  group_by(gene_name) %>% 
  filter(type == "transcript") %>% count() %>% arrange(desc(n))
# 3번
d %>% 
  group_by(gene_name) %>% 
  filter(type == "exon") %>% 
  count() 
