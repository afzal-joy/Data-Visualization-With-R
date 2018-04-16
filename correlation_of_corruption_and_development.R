#install.packages('data.table', dependencies = TRUE)


library(ggplot2)
library(data.table)
library(plotly)
#help(ggplot)





#Loading data using fread........... 

df <- fread("Economist_Assignment_Data.csv", drop = 1)


head(df)

#scatterplot plotting................

pl <- ggplot(df, aes(x = CPI, y = HDI, color = Region))     #plotting scatterplot

pl2 <- pl + geom_point(size = 5, shape = 1)    #making circle as an empty circle 

pl3 <- pl2 +geom_smooth(aes(group = 1),method = 'lm', formula = y~log(x), se = FALSE, colour = "red")    #adding a trend line and smoothing it


pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore","Pakistan")


pl4 <- pl3 + geom_text(aes(label = Country), colour = "grey20", data = subset(df, Country %in% pointsToLabel), check_overlap = TRUE ) + theme_bw()

# customizing x axis

pl5 <- pl4 +  scale_x_continuous(name = "Corruption Perceptions Index,2011(10=least corrupt)", limits = c(.9,10.5), breaks = 1:10)

# customizing y axis

pl6 <- pl5 + scale_y_continuous(name = "Human Development Index,2011(1=best)", limits = c(0.2,1.0) )

#adding title

pl7 <- pl6 + ggtitle(label = "Corruption and Human Development")

ggplotly(pl7)
