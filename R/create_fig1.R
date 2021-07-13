##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param phenotypes
##' @return
##' @author akirosingh
##' @export
create_fig1 <- function(phenotypes) {

  theme_set(theme_classic(base_size = 8))

  # Uploading data
  Grouped <- readRDS(file = here("data/prepared_data/","Grouped.rds"))
  Dataic<- readRDS(file = here("data/prepared_data/","Dataic.rds"))


  strain_colors <- c("#FFDC00", "DarkGrey", "LightPink", "#0064C9", "#7FDBFF", "#2ECC40", "#FF4136", "#B10DC9", "LightGrey")


  #RBC
  A <- ggplot(Grouped, aes(x = Day, y = RBCavg, color = Description))  + geom_ribbon(aes(ymax = RBCavg + RBCse, ymin = RBCavg- RBCse, fill = Description), color = NA, alpha =0.3) + geom_line( size = 0.8) + scale_color_manual(values = strain_colors) +  scale_fill_manual(values = strain_colors)+ labs(y = bquote('RBC per 10µL of Blood'~(10^6)), x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(0,11), expand = c(0,0))

  Ai <- ggplot(subset(Dataic, Dataic$Description!= "DO"), aes(x = Day, y = RBC, color = Description, group = Number))  +  geom_line( size = 0.8, alpha=0.8) + scale_color_manual(values = strain_colors) + scale_fill_manual(values = strain_colors)+ labs(y =bquote('RBC per 10µL of Blood'~(10^6)), x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(0,11), expand = c(0,0))

  B <- ggplot(Grouped, aes(x = Day, y = RBCavg, color = Description)) + geom_line(data = subset(Dataic,Dataic$Description=="DO"),aes(x=Day,y=RBC, group = Number), color = "Light gray", alpha = 0.5) + geom_line( size = 0.8)+ scale_color_manual(values = strain_colors)  + labs(y = "", x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(0,11), expand = c(0,0))


  Aii <- ggplot(Grouped, aes(x = Day, y = RBCavg, color = Description)) + geom_line(data = subset(Dataic,Dataic$Description!="DO"),aes(x=Day,y=RBC, group = Number), alpha = 0.3, size =1 ) + geom_line( size = 0.8)+ scale_color_manual(values = strain_colors)  + theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(0,11), expand = c(0,0)) + labs(y =bquote('RBC per 10µL of Blood'~(10^6)), x = "")



  #PercentChangeinWeight
  C <- ggplot(Grouped, aes(x = Day, y = PercentChangeinWeightavg, color = Description))  + geom_ribbon(aes(ymax = PercentChangeinWeightavg + PercentChangeinWeightse, ymin = PercentChangeinWeightavg- PercentChangeinWeightse, fill = Description), color = NA, alpha =0.3) + geom_line( size = 0.8) + scale_color_manual(values = strain_colors) +  scale_fill_manual(values = strain_colors) + labs(y = "Change in Weight (%)", x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8))+ scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(-.30,.35), expand = c(0,0),labels = scales::percent_format(accuracy = 1))

  Ci <- ggplot(subset(Dataic, Dataic$Description!= "DO"), aes(x = Day, y = `Percent Change in Weight`, color = Description, group = Number))  +  geom_line( size = 0.8, alpha = 0.7) + scale_color_manual(values = strain_colors) + scale_fill_manual(values = strain_colors)+ labs(y = "Change in Weight (%)", x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(-30,35), expand = c(0,0))



  D <- ggplot(Grouped, aes(x = Day, y = PercentChangeinWeightavg, color = Description))  + geom_line(data = subset(Dataic,Dataic$Description=="DO"),aes(x=Day,y=`Percent Change in Weight`, group = Number),color = "Light gray", alpha = 0.5) + geom_line( size = 0.8)+ scale_color_manual(values = strain_colors)  + labs(y = "", x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(-30,35), expand = c(0,0))


  Cii <- ggplot(Grouped, aes(x = Day, y = PercentChangeinWeightavg, color = Description))  + geom_line(data = subset(Dataic,Dataic$Description!="DO"),aes(x=Day,y=`Percent Change in Weight`*100, group = Number), alpha = 0.3, size =1) + geom_line( size = 0.8)+ scale_color_manual(values = strain_colors)  + labs(y = "", x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(-30,35), expand = c(0,0))+ labs(y = "Change in Weight (%)", x = "")


  #Change in Temperature
  E <-  ggplot(Grouped, aes(x = Day, y = ChangeinTemperatureavg, color = Description))  + geom_ribbon(aes(ymax = ChangeinTemperatureavg + ChangeinTemperaturese, ymin = ChangeinTemperatureavg- ChangeinTemperaturese, fill = Description), color = NA, alpha =0.3) + geom_line( size = 0.8) + scale_color_manual(values = strain_colors) +  scale_fill_manual(values = strain_colors) + labs(y = "Change in Temperature (°C)", x = "")+theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(-16,4), expand = c(0,0))


  Ei <-  ggplot(subset(Dataic, Dataic$Description!= "DO"), aes(x = Day, y = `Change in Temperature`, color = Description, group = Number))  +  geom_line( size = 0.8,alpha=0.7) + scale_color_manual(values = strain_colors) + scale_fill_manual(values = strain_colors)+ labs(y = "Change in Temperature (°C)", x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(-16,4), expand = c(0,0))


  F <- ggplot(Grouped, aes(x = Day, y = ChangeinTemperatureavg, color = Description))  + geom_line(data = subset(Dataic,Dataic$Description=="DO"),aes(x=Day,y=`Change in Temperature`, group = Number),color = "Light gray", alpha = 0.5) + geom_line( size = 0.8)+ scale_color_manual(values = strain_colors)   + labs(y = "", x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(-16,4), expand = c(0,0))


  Eii <- ggplot(Grouped, aes(x = Day, y = ChangeinTemperatureavg, color = Description))  + geom_line(data = subset(Dataic,Dataic$Description!="DO"),aes(x=Day,y=`Change in Temperature`, group = Number), alpha = 0.3, size = 1) + geom_line( size = 0.8)+ scale_color_manual(values = strain_colors)   + labs(y = "", x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(-16,4), expand = c(0,0))+ labs(y = "Change in Temperature (°C)", x = "")


  #Parasitemia
  G <- ggplot(Grouped, aes(x = Day, y = Parasitemiaavg, color = Description))  + geom_ribbon(aes(ymax = Parasitemiaavg + Parasitemiase, ymin = Parasitemiaavg- Parasitemiase, fill = Description), color = NA, alpha =0.3) + geom_line( size = 0.8) + scale_color_manual(values = strain_colors) +  scale_fill_manual(values = strain_colors)+ labs(y = "Parasitemia (%)", x = "") + theme(legend.position = "none", axis.title.y = element_text(size = 8))  + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(0,0.6), expand = c(0,0), labels = scales::percent_format(accuracy = 1))

  Gi <- ggplot(subset(Dataic, Dataic$Description!= "DO"), aes(x = Day, y = Parasitemia*100, color = Description, group = Number))  +  geom_line( size = 0.8, alpha = 0.7) + scale_color_manual(values = strain_colors) + scale_fill_manual(values = strain_colors)+ labs(y = "Parasitemia (%)", x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(0,60), expand = c(0,0))


  H <- ggplot(Grouped, aes(x = Day, y = Parasitemiaavg*100, color = Description)) + geom_line(data = subset(Dataic,Dataic$Description=="DO"),aes(x=Day,y=Parasitemia*100, group = Number), color = "Light gray", alpha = 0.5) + geom_line( size = 0.8)+ scale_color_manual(values = strain_colors)  + labs(y = "", x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(0,60), expand = c(0,0))


  Gii <- ggplot(Grouped, aes(x = Day, y = Parasitemiaavg*100, color = Description)) + geom_line(data = subset(Dataic,Dataic$Description!="DO"),aes(x=Day,y=Parasitemia*100, group = Number),alpha = 0.3, size =1) + geom_line( size = 0.8)+ scale_color_manual(values = strain_colors) + labs(y = "Parasitemia (%)", x = "")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(0,60), expand = c(0,0))


  #Parasite Density
  I <- ggplot(Grouped, aes(x = Day, y = ParasiteDensityavg, color = Description)) + geom_ribbon(aes(ymax = ParasiteDensityavg + ParasiteDensityse, ymin = ParasiteDensityavg- ParasiteDensityse, fill = Description), color = NA, alpha =0.3) + geom_line( size = 0.8) + scale_color_manual(values = strain_colors) +  scale_fill_manual(values = strain_colors) + labs(y = bquote('Parasite Denisty '~(10^6)), x = "Day Post Infection")  + theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(0,2.5), expand = c(0,0))

  Ii <- ggplot(subset(Dataic, Dataic$Description!= "DO"), aes(x = Day, y = Parasitemia, color = Description, group = Number))  +  geom_line( size = 0.8, alpha = 0.7) + scale_color_manual(values = strain_colors) + scale_fill_manual(values = strain_colors)+ labs(y = bquote('Parasite Density '~(10^6)), x = "Day Post Infection")+ theme(legend.position = "none", axis.title.y = element_text(size = 8)) + scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(0,0.6), expand = c(0,0))

  J <- ggplot(Grouped, aes(x = Day, y = ParasiteDensityavg, color = Description)) + geom_line(data = subset(Dataic,Dataic$Description=="DO"),aes(x=Day,y=`Parasite Density`, group = Number), color = "Light gray", alpha = 0.5) + geom_line( size = 0.8)+ scale_color_manual(values = strain_colors, name = "Mouse Strain")  + labs(y = "", x = "Day Post Infection")+ scale_x_continuous(limits = c(0,15), expand = c(0,0)) +scale_y_continuous(limits = c(0,2.5), expand = c(0,0))+ theme(axis.title.y = element_text(size = 8), legend.position = "none")


  Iii <- ggplot(Grouped, aes(x = Day, y = ParasiteDensityavg, color = Description)) + geom_line(data = subset(Dataic,Dataic$Description!="DO"),aes(x=Day,y=`Parasite Density`, group = Number), alpha = 0.3, size = 1) + geom_line( size = 0.8)+ scale_color_manual(values = strain_colors, name = "Mouse Strain") + scale_x_continuous(limits = c(0,15), expand = c(0,0)) + labs(y = bquote('Parasite Density '~(10^6)), x = "Day Post Infection")+scale_y_continuous(limits = c(0,2.5), expand = c(0,0))+ theme(axis.title.y = element_text(size = 8), legend.position = "none")




  # Alternative Versions
  #p<-ggarrange(C,D,E,F,A,B,G,H,I,J, nrow = 5 , ncol = 2,labels = c("A","F","B","G", "C", "H", "D","I", "E", "J"),align = "v")
  #p
  #z<-ggarrange(Cii,D,Eii,F,Aii,B,Gii,H,Iii,J, nrow = 5 , ncol = 2,labels = c("A","F","B","G", "C", "H", "D","I", "E", "J"), align = "v")
  #z

  q<-ggarrange(Ci,D,Ei,F,Ai,B,Gi,H,Ii,J, nrow = 5 , ncol = 2,labels = c("A","F","B","G", "C", "H", "D","I", "E", "J"),align = "v")



  ggsave("Figure1", device = "pdf", plot = q, height = 24, width = 20,units = "cm" )

  plegend <- ggplot(Dataic, aes(x = Day, y = RBC, group = Number , color = Description)) + geom_line(size = 5) + scale_color_manual(values = strain_colors, name = "Mouse Strains") + theme(legend.position = "bottom")

  ggsave("Figure1Legend", device = "pdf", plot = plegend, height = 14, width = 12,units = "in")

  q

}
