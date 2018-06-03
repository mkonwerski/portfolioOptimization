#Instalacja wymaganych pakietów
#install.packages("RCurl")
#install.packages("dplyr")
#install.packages("xts")
#install.packages("quantmod")
#install.packages("timeSeries")

library(RCurl)
library(dplyr)
library(xts)
library(quantmod)
library(timeSeries)

getStooqData <- function(asset_code,static_cookie=TRUE) {
  
  data_tmp <- tempfile() # "data.csv"
  cookie_tmp <- "cookie.txt"
  
  u1 <- paste("https://stooq.pl/q/d/?s=",asset_code,"&i=d",sep="")
  u2 <- paste("https://stooq.pl/q/d/l/?s=",asset_code,"&i=d&",sep="")
  
  if (!static_cookie) {
    h <- c(paste("GET ",u1," HTTP/1.0",sep=""),
           Accept="image/gif",
           Accept="image/x-xbitmap",
           Accept="image/jpeg",
           Accept="mage/pjpeg",
           Accept="application/x-shockwave-flash",
           Accept="application/vnd.ms-excel",
           Accept="application/msword",
           Accept="*/*",
           'Accept-Language'="pl, en-us;q=0.7",
           'User-Agent'="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)",
           'Proxy-Connection'="Keep-Alive"
    )
    
    u1Opts <- curlOptions(header=TRUE,
                          httpheader=h,
                          cookiejar=cookie_tmp
    )
    
    curlPerform(url=u1,.opts=u1Opts,verbose=TRUE)
    
    h <- c(paste("GET",u2,"HTTP/1.0"),
           Accept="image/gif",
           Accept="image/x-xbitmap",
           Accept="image/jpeg",
           Accept="mage/pjpeg",
           Accept="application/x-shockwave-flash",
           Accept="application/vnd.ms-excel",
           Accept="application/msword",
           Accept="*/*",
           'Accept-Language'="pl, en-us;q=0.7",
           'User-Agent'="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)",
           'Proxy-Connection'="Keep-Alive"
    )
    
    u2Opts <- curlOptions(header=TRUE,
                          httpheader=h,
                          cookiefile=cookie_tmp
    )
  }
  else {
    h <- c(paste("GET",u2,"HTTP/1.0"),
           Accept="image/gif",
           Accept="image/x-xbitmap",
           Accept="image/jpeg",
           Accept="mage/pjpeg",
           Accept="application/x-shockwave-flash",
           Accept="application/vnd.ms-excel",
           Accept="application/msword",
           Accept="*/*",
           'Accept-Language'="pl, en-us;q=0.7",
           'User-Agent'="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)",
           'Proxy-Connection'="Keep-Alive",
           Cookie=paste("cookie_uu=p;cookie_user=%3F0001dllg000011500d1300%7C",asset_code,sep="")
    )
    
    u2Opts <- curlOptions(header=TRUE, httpheader=h)
  }
  
  reader <- basicTextGatherer()
  w <- getURLContent(url=u2,.opts=u2Opts)
  write(w,file=data_tmp)
  stooq_data <- read.csv(data_tmp)
  stooq_data
}

# Pobieranie notowań TFI w formie csv
N_2781 <- select(getStooqData("2781.N", static_cookie=TRUE), Data, Zamkniecie)
N_2802 <- select(getStooqData("2802.N", static_cookie=TRUE), Data, Zamkniecie)
N_2833 <- select(getStooqData("2833.N", static_cookie=TRUE), Data, Zamkniecie)
N_2842 <- select(getStooqData("2842.N", static_cookie=TRUE), Data, Zamkniecie)
N_2790 <- select(getStooqData("2790.N", static_cookie=TRUE), Data, Zamkniecie)
N_2808 <- select(getStooqData("2808.N", static_cookie=TRUE), Data, Zamkniecie)
N_2812 <- select(getStooqData("2812.N", static_cookie=TRUE), Data, Zamkniecie)
N_2816 <- select(getStooqData("2816.N", static_cookie=TRUE), Data, Zamkniecie)
N_2820 <- select(getStooqData("2820.N", static_cookie=TRUE), Data, Zamkniecie)
N_2824 <- select(getStooqData("2824.N", static_cookie=TRUE), Data, Zamkniecie)
N_2828 <- select(getStooqData("2828.N", static_cookie=TRUE), Data, Zamkniecie)
N_2785 <- select(getStooqData("2785.N", static_cookie=TRUE), Data, Zamkniecie)
N_2743 <- select(getStooqData("2743.N", static_cookie=TRUE), Data, Zamkniecie)
N_2747 <- select(getStooqData("2747.N", static_cookie=TRUE), Data, Zamkniecie)
N_2752 <- select(getStooqData("2752.N", static_cookie=TRUE), Data, Zamkniecie)
N_2757 <- select(getStooqData("2757.N", static_cookie=TRUE), Data, Zamkniecie)
N_2764 <- select(getStooqData("2764.N", static_cookie=TRUE), Data, Zamkniecie)
N_2768 <- select(getStooqData("2768.N", static_cookie=TRUE), Data, Zamkniecie)
N_2772 <- select(getStooqData("2772.N", static_cookie=TRUE), Data, Zamkniecie)
N_2776 <- select(getStooqData("2776.N", static_cookie=TRUE), Data, Zamkniecie)
N_2795 <- select(getStooqData("2795.N", static_cookie=TRUE), Data, Zamkniecie)

NN_2781 = xts(N_2781$Zamkniecie, order.by=as.Date(N_2781$Data, format="%Y-%m-%d"))
NN_2802 = xts(N_2802$Zamkniecie, order.by=as.Date(N_2802$Data, format="%Y-%m-%d"))
NN_2833 = xts(N_2833$Zamkniecie, order.by=as.Date(N_2833$Data, format="%Y-%m-%d"))
NN_2842 = xts(N_2842$Zamkniecie, order.by=as.Date(N_2842$Data, format="%Y-%m-%d"))
NN_2790 = xts(N_2790$Zamkniecie, order.by=as.Date(N_2790$Data, format="%Y-%m-%d"))
NN_2808 = xts(N_2808$Zamkniecie, order.by=as.Date(N_2808$Data, format="%Y-%m-%d"))
NN_2812 = xts(N_2812$Zamkniecie, order.by=as.Date(N_2812$Data, format="%Y-%m-%d"))
NN_2816 = xts(N_2816$Zamkniecie, order.by=as.Date(N_2816$Data, format="%Y-%m-%d"))
NN_2820 = xts(N_2820$Zamkniecie, order.by=as.Date(N_2820$Data, format="%Y-%m-%d"))
NN_2824 = xts(N_2824$Zamkniecie, order.by=as.Date(N_2824$Data, format="%Y-%m-%d"))
NN_2828 = xts(N_2828$Zamkniecie, order.by=as.Date(N_2828$Data, format="%Y-%m-%d"))
NN_2785 = xts(N_2785$Zamkniecie, order.by=as.Date(N_2785$Data, format="%Y-%m-%d"))
NN_2743 = xts(N_2743$Zamkniecie, order.by=as.Date(N_2743$Data, format="%Y-%m-%d"))
NN_2747 = xts(N_2747$Zamkniecie, order.by=as.Date(N_2747$Data, format="%Y-%m-%d"))
NN_2752 = xts(N_2752$Zamkniecie, order.by=as.Date(N_2752$Data, format="%Y-%m-%d"))
NN_2757 = xts(N_2757$Zamkniecie, order.by=as.Date(N_2757$Data, format="%Y-%m-%d"))
NN_2764 = xts(N_2764$Zamkniecie, order.by=as.Date(N_2764$Data, format="%Y-%m-%d"))
NN_2768 = xts(N_2768$Zamkniecie, order.by=as.Date(N_2768$Data, format="%Y-%m-%d"))
NN_2772 = xts(N_2772$Zamkniecie, order.by=as.Date(N_2772$Data, format="%Y-%m-%d"))
NN_2776 = xts(N_2776$Zamkniecie, order.by=as.Date(N_2776$Data, format="%Y-%m-%d"))
NN_2795 = xts(N_2795$Zamkniecie, order.by=as.Date(N_2795$Data, format="%Y-%m-%d"))

#połącznie wszystkich plików w jeden
portfolioPrices <- merge(NN_2781,
                         NN_2802,
                         NN_2833,
                         NN_2842,
                         NN_2790,
                         NN_2808,
                         NN_2812,
                         NN_2816,
                         NN_2820,
                         NN_2824,
                         NN_2828,
                         NN_2785,
                         NN_2743,
                         NN_2747,
                         NN_2752,
                         NN_2757,
                         NN_2764,
                         NN_2768,
                         NN_2772,
                         NN_2776,
                         NN_2795
)

names(portfolioPrices) <- c("Akcji",
                            "Obligacji",
                            "Stabil_Wzrostu",
                            "Zrownowazony",
                            "Gotowkowy",
                            "Perspek_20",
                            "Perspek_25",
                            "Perspek_30",
                            "Perspek_35",
                            "Perspek_40",
                            "Perspek_45",
                            "Akcji_Srod",
                            "Eu_Spol_Dywid",
                            "Glob_Korp",
                            "Glob_Spol_Dywid",
                            "Japonia",
                            "Obli_Ryn_Wsch_Walu",
                            "Spol_Dywid_Ryn_Wsch",
                            "Spol_Dywid_USA",
                            "Stab_Glob_Aloka",
                            "Lokacyjny_Plus"
)

#Obliczanie dziennego zwrotu
portfolioPrices <- portfolioPrices[apply(portfolioPrices,1,function(x) all(!is.na(x))),]
portfolioReturns <- na.omit(ROC(portfolioPrices, type="discrete"))
tfi_Ret <- as.timeSeries(portfolioReturns)
write.table(tfi_Ret, file = "tfi_Ret.csv",row.names=TRUE, na="",col.names=TRUE, sep=";", dec=",")
dim(portfolioPrices)
