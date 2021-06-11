library(tidyverse)

camino  <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(camino, "datos.zip"))
unzip(zipfile = "datos.zip")

# actividades y variables
list.files()
nombresActividad <- read.table(file = "UCI HAR Dataset/activity_labels.txt",
                               col.names = c("llave","Actividad"))
variables <- read.table(file = "UCI HAR Dataset/features.txt",
                        col.names = c("num","variable"))
IndVarInteres <- grep("\\-mean\\(|\\-std\\(", variables$variable)
VarInteres <- variables[IndVarInteres,]

# Entrenamiento
entrenamiento <- read.table(file ="UCI HAR Dataset/train/X_train.txt")[, IndVarInteres]
colnames(entrenamiento) <-  VarInteres[,2]
actEntrena <- read.table(file = "UCI HAR Dataset/train/Y_train.txt",
                         col.names = "actividad")
subEntrena <- read.table(file = "UCI HAR Dataset/train/subject_train.txt",
                         col.names = "subInd")
entrenamiento <- cbind(subEntrena, actEntrena, entrenamiento)

# Test
test <- read.table(file ="UCI HAR Dataset/test/X_test.txt")[, IndVarInteres]
colnames(test) <-  VarInteres[,2]
actTest <- read.table(file = "UCI HAR Dataset/test/Y_test.txt",
                      col.names = "actividad")
subTest <- read.table(file = "UCI HAR Dataset/test/subject_test.txt",
                      col.names = "subInd")
test <- cbind(subTest, actTest, test)

# Todas
base <- rbind(entrenamiento, test) %>% 
  gather(key = "medida", value =  "valor", 
         3:68, convert = T) %>% 
  right_join(nombresActividad,
             by = c("actividad"="llave")) %>% 
  select(1,5,3,4)

datosTidy <- base %>% 
  group_by(subInd, Actividad, medida) %>% 
  summarise(media = mean(valor))

# Archivo
write.table(x = datosTidy, file = "datosTidy.txt", row.name=FALSE)
