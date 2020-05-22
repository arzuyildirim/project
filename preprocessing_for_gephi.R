install.packages("RJSONIO") #the package to export data written in java to R 
library("RJSONIO")
resultt <- fromJSON("starwars-episode-7-interactions-allCharacters.json", simplify = T)



#firstly I wanted to extract edges data which is named as "links" in the dataset
json_data_frame <- as.data.frame(resultt["links"], stringsAsFactors = F)
json_data_frame
json_data_frame <- t(json_data_frame)
class (json_data_frame)
json_data_frame <- unlist(json_data_frame)
class(json_data_frame)
dim(json_data_frame)
#rename the variables. Specially value will be replace by weight to see if gephi reads it like that
colnames(json_data_frame)
colnames(json_data_frame)[colnames(json_data_frame) == "source"] <- "Source"
colnames(json_data_frame)[colnames(json_data_frame) == "target"] <- "Target"
colnames(json_data_frame)[colnames(json_data_frame) == "value"] <- "Weight"

# Export the Edges data frame to excel
install.packages("writexl")
library(writexl)
json_data_frame<-as.data.frame(json_data_frame)
write_xlsx(json_data_frame,"Edgess.xlsx")



# Nodes matrix. Here we have to give them and ID thats the same from the edges matrix(to make them matched in gephi)
json_data_frame_nodes <- as.data.frame(resultt["nodes"], stringsAsFactors = F)
json_data_frame_nodes
json_data_frame_nodes <- t(json_data_frame_nodes)
class (json_data_frame_nodes)
json_data_frame_nodes <-as.data.frame(json_data_frame_nodes)
class(json_data_frame_nodes)
dim(json_data_frame_nodes)
#here I valued nodes till 26 which is the number of nodes within the edges dataset and because numbers from 0 to 26 were the names in the edges data,this code will make them matched  
#it is important to assign each node with the numbers in the edge data 
json_data_frame_nodes$ID=0
json_data_frame_nodes$ID<-0:26

col_order_nodes <- c("ID", "value", "name", "colour")
json_data_frame_nodes <- json_data_frame_nodes[,col_order_nodes]

#rename the variables
colnames(json_data_frame_nodes)
colnames(json_data_frame_nodes)[colnames(json_data_frame_nodes) == "value"] <- "Value"
colnames(json_data_frame_nodes)[colnames(json_data_frame_nodes) == "name"] <- "Label"
colnames(json_data_frame_nodes)[colnames(json_data_frame_nodes) == "colour"] <- "Colour"


# Export the nodes data frame to excel
#wanted to make sure that organized data is data.frame which makes write_xl function work properly
json_data_frame_nodes<-as.data.frame(json_data_frame_nodes)
write_xlsx(json_data_frame_nodes,"Nodess.xlsx")



