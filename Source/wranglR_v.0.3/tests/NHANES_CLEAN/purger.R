library(dplyr)

setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CSV/2007_2008')
nhanes_e <-read.csv('nhanes_e.csv')
nhanes_e <- nhanes_e[, colSums(is.na(nhanes_e)) < 5000]
nhanes_e <- na.omit(nhanes_e)


setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CSV/2009_2010')

nhanes_f <-read.csv('nhanes_f.csv')
nhanes_f <- nhanes_f[, colSums(is.na(nhanes_f)) < 5000]
nhanes_f <- na.omit(nhanes_f)

setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CSV/2011_2012')

nhanes_g <-read.csv('nhanes_g.csv')
nhanes_g <- nhanes_g[, colSums(is.na(nhanes_g)) < 5000]
nhanes_g <- na.omit(nhanes_g)


setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CSV/2013_2014')

nhanes_h <-read.csv('nhanes_h.csv')
nhanes_h <- nhanes_h[, colSums(is.na(nhanes_h)) < 5000]
nhanes_h <- na.omit(nhanes_h)

View(nhanes_e)
View(nhanes_f)
View(nhanes_g)
View(nhanes_h)

common_nhanes_cols1 <- intersect(colnames(nhanes_e),colnames(nhanes_g))
common_nhanes_cols2 <- intersect(colnames(nhanes_h),colnames(nhanes_f))
common_nhanes_cols3 <- intersect(common_nhanes_cols2,common_nhanes_cols1)

cleaner_nhanes <-function(df){
  common_cols<-intersect(common_nhanes_cols3,colnames(df)) ##get consistent column names for nhanes
  df <- select(df,common_cols)
  return(df)
}

nhanes_e <- cleaner_nhanes(nhanes_e)
nhanes_f <- cleaner_nhanes(nhanes_f)
nhanes_g<- cleaner_nhanes(nhanes_g)
nhanes_h <- cleaner_nhanes(nhanes_h)


setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CSV/2007_2008')

bmx_e <- read.csv('BMX_E.csv')
hdl_e <- read.csv('HDL_E.csv')
trigly_e <- read.csv('TRIGLY_E.csv')
demo_e <- read.csv('DEMO_E.csv')
hepc_e <- read.csv('HEPC_E.csv')
hiv_e <- read.csv('HIV_E.csv')
hepa_e <- read.csv('HEPA_E.csv')
colnames(nhanes_e)

cleaner <-function(nhanes,df,year){
  common_cols<-intersect(colnames(nhanes),colnames(df))
  df <- select(nhanes,common_cols)
  df["year"] <- year
  return(df)
}

bmx_e <- cleaner(nhanes_e,bmx_e,"2007-2008")
demo_e <- cleaner(nhanes_e,demo_e,"2007-2008")
hepc_e <- cleaner(nhanes_e,hepc_e,"2007-2008")
hepa_e <- cleaner(nhanes_e,hepa_e,"2007-2008")
trigly_e <- cleaner(nhanes_e,trigly_e,"2007-2008")
hiv_e <- cleaner(nhanes_e,hiv_e,"2007-2008")
hdl_e<- cleaner(nhanes_e,hdl_e,"2007-2008")

setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CLEAN/2007-2008')


write.csv(demo_e,file="DEMO_E.csv")
write.csv(hepc_e,file="HEPC_E.csv")
write.csv(hepa_e,file="HEPA_E.csv")
write.csv(trigly_e,file="TRIGLY_E.csv")
write.csv(bmx_e,file="BMX_E.csv")
write.csv(hdl_e,file="HDL_E.csv")



setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CSV/2009_2010')


bmx_f <- read.csv('BMX_F.csv')
hdl_f <- read.csv('HDL_F.csv')
trigly_f <- read.csv('TRIGLY_F.csv')
demo_f <- read.csv('DEMO_F.csv')
hepc_f <- read.csv('HEPC_F.csv')
hiv_f <- read.csv('HIV_F.csv')
hepa_f <- read.csv('HEPA_F.csv')


bmx_f <- cleaner(nhanes_f,bmx_f,"2009-2010")
demo_f <- cleaner(nhanes_f,demo_f,"2009-2010")
hepc_f <- cleaner(nhanes_f,hepc_f,"2009-2010")
hepa_f <- cleaner(nhanes_f,hepa_f,"2009-2010")
trigly_f <- cleaner(nhanes_f,trigly_f,"2009-2010")
hiv_f <- cleaner(nhanes_f,hiv_f,"2009-2010")
hdl_f<- cleaner(nhanes_f,hdl_f,"2009-2010")



setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CLEAN/2009-2010')


write.csv(demo_f,file="DEMO_F.csv")
write.csv(hepc_f,file="HEPC_F.csv")
write.csv(hepa_f,file="HEPA_F.csv")
write.csv(trigly_f,file="TRIGLY_F.csv")
write.csv(bmx_f,file="BMX_F.csv")
write.csv(hdl_f,file="HDL_F.csv")




setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CSV/2011_2012')


bmx_g <- read.csv('BMX_G.csv')
hdl_g <- read.csv('HDL_G.csv')
trigly_g <- read.csv('TRIGLY_G.csv')
demo_g <- read.csv('DEMO_G.csv')
hepc_g <- read.csv('HEPC_G.csv')
hiv_g <- read.csv('HIV_G.csv')
hepa_g <- read.csv('HEPA_G.csv')


bmx_g <- cleaner(nhanes_g,bmx_g,"2011-2012")
demo_g <- cleaner(nhanes_g,demo_g,"2011-2012")
hepc_g <- cleaner(nhanes_g,hepc_g,"2011-2012")
hepa_g <- cleaner(nhanes_g,hepa_g,"2011-2012")
trigly_g <- cleaner(nhanes_g,trigly_g,"2011-2012")
hiv_g <- cleaner(nhanes_g,hiv_g,"2011-2012")
hdl_g<- cleaner(nhanes_g,hdl_g,"2011-2012")


setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CLEAN/2011-2012')


write.csv(demo_g,file="DEMO_G.csv")
write.csv(hepc_g,file="HEPC_G.csv")
write.csv(hepa_g,file="HEPA_G.csv")
write.csv(trigly_g,file="TRIGLY_G.csv")
write.csv(bmx_g,file="BMX_G.csv")
write.csv(hdl_g,file="HDL_G.csv")



setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CSV/2013_2014')

bmx_h <- read.csv('BMX_H.csv')
hdl_h <- read.csv('HDL_H.csv')
trigly_h <- read.csv('TRIGLY_H.csv')
demo_h <- read.csv('DEMO_H.csv')
hepc_h <- read.csv('HEPC_H.csv')
hiv_h <- read.csv('HIV_H.csv')
hepa_h <- read.csv('HEPA_H.csv')

bmx_h <- cleaner(nhanes_h,bmx_h,"2013-2014")
demo_h <- cleaner(nhanes_h,demo_h,"2013-2014")
hepc_h <- cleaner(nhanes_h,hepc_h,"2013-2014")
hepa_h <- cleaner(nhanes_h,hepa_h,"2013-2014")
trigly_h <- cleaner(nhanes_h,trigly_h,"2013-2014")
hiv_h <- cleaner(nhanes_h,hiv_h,"2013-2014")
hdl_h<- cleaner(nhanes_h,hdl_h,"2013-2014")


setwd('/HOME/SDR/Spikes/Source_versions/File_Spike/NHANES_CLEAN/2013-2014')


write.csv(demo_h,file="DEMO_H.csv")
write.csv(hepc_h,file="HEPC_H.csv")
write.csv(hepa_h,file="HEPA_H.csv")
write.csv(trigly_h,file="TRIGLY_H.csv")
write.csv(bmx_h,file="BMX_H.csv")
write.csv(hdl_h,file="HDL_H.csv")


