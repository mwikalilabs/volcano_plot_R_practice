setwd("C:\\Users\\PC\\OneDrive\\Attachments\\Desktop\\Bioinformatics\\R\\volcano plot")

getwd()


#libraries
library(ggplot2)
library(ggrepel)
library(dplyr)

#data
df_data = read.delim("genes.tsv")

head(df_data)

#create a column
df_data$diffexpexpressed <- "NO"

#up and down
df_data$diffexpexpressed[df_data$logFC > 0.58 & df_data$adj.P.Val < 0.01] <- "UP"

df_data$diffexpexpressed[df_data$logFC < 0.58 & df_data$adj.P.Val < 0.01] <- "DOWN"

df_data$de_label <- NA

#volcano plot

ggplot(data=df_data, aes(x=logFC, y=-log10(P.Value),col=diffexpexpressed,label=de_label)) + 
  geom_point()+
  theme_minimal()+
  geom_text_repel()+
  scale_color_manual(values = c("blue","black","red"))+
  geom_vline(xintercept = c(-0.8,0.8),col="red")+
  geom_hline(yintercept = -log10(0.001),col='red')+
  theme(text=element_text(size = 20))
  
   
head(df_data)
#to sort based on the pvalue so as to obtain the sigmificant genes with the least pvalues
head(arrange(df_data,P.Value),10 )

head(arrange(df_data,P.Value),10 )$P.Value

#threshhold
thresh = head(arrange(df_data,P.Value),10 )$P.Value[10]
thresh

#top 10 genes names
head(arrange(df_data,P.Value),10 )$SYMBOL

df_data$de_label[df_data$P.Value <= thresh] <- (df_data$SYMBOL[df_data$P.Value <= thresh])

head(arrange(df_data,P.Value),10 )


ggplot(data=df_data, aes(x=logFC, y=-log10(P.Value),col=diffexpexpressed,label=de_label)) + 
  geom_point()+
  theme_minimal()+
  geom_text_repel()+
  scale_color_manual(values = c("blue","black","red"))+
  geom_vline(xintercept = c(-0.8,0.8),col="red")+
  geom_hline(yintercept = -log10(0.001),col='red')+
  theme(text=element_text(size = 20))





