#Instalacja wymaganych pakietów
#install.packages("fPortfolio")
#install.packages("lpSolve")

library(fPortfolio) 
library(lpSolve) 

# Wczytywanie danych z pliku
tfiReturn <- read.csv(file = "tfi_Ret.csv", sep=";", dec=",") 
tfiReturn <- as.timeSeries(tfiReturn) 
tfiReturn <- portfolioData(tfiReturn, spec = portfolioSpec()) 

# specyfikacja 
Spec = portfolioSpec() 
setNFrontierPoints(Spec) = 100 
Constraints <- "LongOnly"; 

#portfolio Frontier: Funkcja portfolioFrontier oblicza całą efektywną granicę. 
granica <- portfolioFrontier(tfiReturn, Spec, Constraints) 

tailoredFrontierPlot(object = granica, 
                     return = c("mean", "mu"), 
                     risk = c("Cov", "Sigma", "CVaR", "VaR"), 
                     xlim=c(-0.0,0.012), 
                     ylim=c(0,0.0004), 
                     twoAssets = FALSE, 
                     sharpeRatio = TRUE, 
                     title = FALSE 
) 
title("Granica portfela TFI") 


#Minimalny portfel wariancji: funkcja minvariancePortfolio zwraca portfel z minimalnym ryzykiem efektywnej granicy. 
#Aby znaleźć minimalny punkt ryzyka, ryzyko docelowe zwrócone przez funkcję efficientPortfolio jest zminimalizowana. 

miniRisk <-minvariancePortfolio(tfiReturn, Spec, Constraints) 
weightsPie(miniRisk, title = FALSE) 
title("Portfel z najmniejszym ryzykiem inwestycyjnym") 
miniRiska <-getTargetRisk(miniRisk) 
miniRiska 

miniRiskP <- frontierPoints(miniRisk) # get risk and return values for points on the efficient frontier 
miniRiskPoints <- data.frame(targetRisk=miniRiskP[, "targetRisk"] * sqrt(252), targetReturn=miniRiskP[,"targetReturn"] * 252) 


#Funkcja tangencyPortfolio zwraca portfel z najwyższym współczynnikiem zwrotu / ryzyka na efektywnej granicy. 
#Dla portfela Markowitza jest to to samo co stosunek Sharpae. 

Sharpae <-tangencyPortfolio(tfiReturn, Spec, Constraints) 
weightsPie(Sharpae) 
title("Portfel zbudowany na podstawie Sharpae") 
sharpaeRisk <-getTargetRisk(Sharpae) 
sharpaeRisk 

sharpaeRiskP <- frontierPoints(Sharpae) # get risk and return values for points on the efficient frontier 
sharpaeRiskPoints <- data.frame(targetRisk=sharpaeRiskP[, "targetRisk"] * sqrt(252), targetReturn=sharpaeRiskP[,"targetReturn"] * 252) 


# Portfel o minimalnym ryzyku o danej oczekiwanej stopie zwrotu 
SpecReturn = portfolioSpec() 
setTargetRisk(SpecReturn) = 0.05 
setSolver(SpecReturn)= "solveRshortExact" 
Constraints = "minW[1:21]=0.01" 
portfolioReturn<-efficientPortfolio(tfiReturn, SpecReturn, Constraints ) 
portfolioReturn 

portfolioReturnP <- frontierPoints(portfolioReturn) # get risk and return values for points on the efficient frontier 
portfolioReturnPPoints <- data.frame(targetRisk=portfolioReturnP[, "targetRisk"] * sqrt(252), targetReturn=portfolioReturnP[,"targetReturn"] * 252) 
