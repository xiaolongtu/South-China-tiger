library(ggplot2)
library(scales)
mu=3.5e-9
gen<- 5

M1toM2=read.table("combined12_msmc.final.txt", header=T)
left1=M1toM2$left_time_boundary/mu*gen
right1=M1toM2$right_time_boundary/mu*gen
cross_coal_rate1 =2 * M1toM2$lambda_01 / (M1toM2$lambda_00 + M1toM2$lambda_11)
st1 = data.frame(left1,right1,cross_coal_rate1)

plot.msmc.tsplit <- ggplot() + geom_hline(yintercept = 1, linetype = 2,size = 0.25) + geom_hline(yintercept = 0.75, linetype = 2,size = 0.25) + geom_hline(yintercept = 0.5, linetype = 2,size = 0.25) + geom_hline(yintercept = 0.25, linetype = 2,size = 0.25) + geom_hline(yintercept = 0, linetype = 2,size = 0.25) + 
  geom_step(data = st1, aes(x=left1, y=cross_coal_rate1), 
            color = "steelblue1", size = 0.5) +
  geom_step(data = st1, aes(x=right1, y=cross_coal_rate1), 
            color = "steelblue1", size = 0.5) +

  scale_x_log10(breaks = scales::trans_breaks("log10", function(x) 10^x),
                labels = scales::trans_format("log10", scales::math_format(10^.x))) +
  annotation_logticks(sides = "tb") +  ylab('Relative cross coalescence rate') + xlab('Time (years ago)')+
  theme(panel.border = element_rect(linetype = "solid", fill = NA, size = 1, color = "black"))+theme(panel.background=element_rect(fill='transparent', color='black'),panel.grid.minor=element_blank())

  plot.msmc.tsplit
dev.off()
