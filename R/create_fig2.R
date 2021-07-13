##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param phenotypes
##' @return
##' @author akirosingh
##' @export
create_fig2 <- function(phenotypes) {

  # Uploading data
  Phenotypes<- readRDS(file = here("data/prepared_data/phenotypes.rds"))

                       dt <- c(-2,18)
                       pa <- c(-8,85)
                       dw <- c(-2,40)
                       rb <- c(-0.02, 8)
                       alphasetting <-0.7
                       point_size <- 5

                       # Figure 2

                       ##################################Coloring by Mouse Strain#######################################
                       Phenotypes$Description <- factor(Phenotypes$Description, levels = c("DO", "C57BL/6J", "129S1/SvImJ", "NOD/ShiLtJ", "NZO/HILtJ", "CAST/EiJ", "PWK/PhJ", "WSB/EiJ","A/J"))

                       strain_colors <- c("LightGrey", "DarkGrey", "LightPink", "#0064C9", "#7FDBFF", "#2ECC40", "#FF4136", "#B10DC9", "#FFDC00")
                       Phenotypes <- Phenotypes[order(Phenotypes$Description),]



                       Ai <- ggplot(Phenotypes, aes(y = abs(MinDeltaTemp), x = abs(MinPercWeight)))+ geom_point(aes(fill = Description), colour="white",pch=21, size=point_size)  + theme_classic()+ labs(y = "Maximum Temperature Loss (°C)", x = "Maximum Weight Loss (%)") +coord_cartesian(xlim =  dw, ylim =  dt, expand = FALSE) + theme(legend.position = "none") + scale_fill_manual(values = strain_colors)


                       Bi <- ggplot(Phenotypes, aes(y = abs(MinDeltaTemp), x = MinRBC)) +  geom_point(aes(fill = Description), colour="white",pch=21, size=point_size)  + theme_classic()+ labs(y = "", x = "Minimum Red Blood Cells") +coord_cartesian(xlim =  rb, ylim =  dt, expand = FALSE) + theme(legend.position = "none") + scale_fill_manual(values = strain_colors)



                       Ci <- ggplot(Phenotypes, aes(y = abs(MinDeltaTemp), x = MaxParasitemia*100)) +  geom_point(aes(fill = Description), colour="white",pch=21, size=point_size)  + theme_classic()+ labs(y = "", x = expression("Maximum Parasitemia (%)")) +coord_cartesian(xlim = pa, ylim =  dt, expand = FALSE) + theme(legend.position = "none") + scale_fill_manual(values = strain_colors) + geom_smooth(method='lm', formula= y~x, se = FALSE, color = "black")


                       fit <- lm(Phenotypes$MaxParasitemia*100~abs(Phenotypes$MinDeltaTemp))
                       #summary(fit)
                       #R^2 = 0.2984

                       Di <- ggplot(Phenotypes, aes(y = MaxParasitemia*100, x =  abs(MinPercWeight))) +  geom_point(aes(fill = Description), colour="white",pch=21, size=point_size)  + theme_classic()+ labs(y = expression("Maximum Parasitemia (%)") , x = "") +coord_cartesian(xlim = dw , ylim = pa, expand = FALSE) + theme(legend.position = "none") + scale_fill_manual(values = strain_colors) + geom_smooth(method='lm', formula= y~x, se = FALSE, color = "black")


                       fit <- lm(Phenotypes$MaxParasitemia*100~abs(Phenotypes$MinPercWeight))
                       #summary(fit)
                       #R^2 = 0.1295



                       Ei <- ggplot(Phenotypes, aes(y = MaxParasitemia*100, x =  MinRBC)) +  geom_point(aes(fill = Description), colour="white",pch=21, size=point_size)  + theme_classic()+ labs(y = expression("") , x = "") +coord_cartesian(xlim = rb , ylim = pa, expand = FALSE) + theme(legend.position = "none") + scale_fill_manual(values = strain_colors) + geom_smooth(method='lm', formula= y~x, se = FALSE, color = "black")


                       fit <- lm(Phenotypes$MaxParasitemia*100~abs(Phenotypes$MinRBC))
                       #summary(fit)
                       #R^2 = 0.5078


                       Fi <- ggplot(Phenotypes, aes(y =  MinRBC, x =  abs(MinPercWeight))) +  geom_point(aes(fill = Description), colour="white",pch=21, size=point_size)  + theme_classic()+ labs(y ="Minimum Red Blood Cells" , x = "") +coord_cartesian(xlim =  dw , ylim = rb, expand = FALSE) + theme(legend.position = "none") + scale_fill_manual(values = strain_colors)


                       p.empty <- ggplot() + theme_void()

                       Figure2<- ggarrange(Fi,p.empty,p.empty,Di,Ei, p.empty,Ai,Bi,Ci, ncol = 3, nrow = 3, labels = c("A","", "", "B","D","", "C", "E", "F"))

                       Figure2

                       ggsave(here("images/Figure2.pdf"), device = "pdf", plot = Figure2, height = 20, width = 20,units = "cm" )

}
