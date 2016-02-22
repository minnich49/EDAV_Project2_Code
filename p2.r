
df = readRDS("GlobalFloodsRecord_modified.rds")

require(ggplot2)
require(maps)
world_map <- map_data("world")


df1 = df[,c("Centroid X","Centroid Y")]
colnames(df1)[which(names(df1) == "Centroid X")] <- "CentroidX"
colnames(df1)[which(names(df1) == "Centroid Y")] <- "CentroidY"

df1$CentroidX=as.numeric(levels(df1$CentroidX))[df1$CentroidX]
df1$CentroidY=as.numeric(levels(df1$CentroidY))[df1$CentroidY]
df1 = df1[complete.cases(df1$CentroidX),]

col.nacheck3 = data.frame(colSums(is.na(df1)))

p <- ggplot() + coord_fixed() + xlab("") + ylab("")
base_world_messy <- p + geom_polygon(data=world_map, aes(x=long, y=lat, group=group), 
                                     colour="light green", fill="light green")

base_world_messy
cleanup <- 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_rect(fill = 'white', colour = 'white'), 
        axis.line = element_line(colour = "white"), legend.position="none",
        axis.ticks=element_blank(), axis.text.x=element_blank(),
        axis.text.y=element_blank())

base_world <- base_world_messy + cleanup

base_world
map_data = base_world +geom_point(data=df1, aes(x=CentroidX, y=CentroidY), colour="Red",fill="Pink",pch=21, size=2, alpha=I(0.5))

map_data
