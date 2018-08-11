graph.createSpiral <- function(data) {
  
  data$hourStart <- as.numeric(data$DateTimeStart) %% (24*60*60) / 3600
  data$hourEnd <- as.numeric(data$DateTimeEnd) %% (24*60*60) / 3600
  
  plot <- (ggplot(data, aes(x=as.numeric(hourStart), xend=as.numeric(hourEnd), 
                              y=DateTimeStart, yend=DateTimeEnd, color=Activity)) +
              geom_segment(size=1.1) +
              scale_x_continuous(limits=c(0,24), breaks=0:23, minor_breaks=0:24,
                                 labels=paste0(rep(c(12,1:11),2), rep(c("AM","PM"),each=12))) +
              scale_y_datetime(limits=range(sleep$DateTimeEnd) + c(-7*24*3600,0), 
                               breaks=seq(min(sleep$DateTimeStart), max(sleep$DateTimeEnd),"1 day"),
                               date_labels="%b %e") +
              coord_polar() +
              theme_bw(base_size=10) + 
              labs(x="Hour",y="Day",color="Sleeping") +
              theme(panel.grid.minor.x=element_line(colour="grey60", size=0.3)))
  
  print(plot)
}