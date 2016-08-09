## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ------------------------------------------------------------------------
library("dplyr")
library("tidyr")

## ------------------------------------------------------------------------
refine_original <- read.csv("C:/Users/Georgie/Dropbox/Springboard/DataWrangling1/refine_original.csv")
data_fr <- data.frame(refine_original)

## ------------------------------------------------------------------------
my_tbl<-dplyr::tbl_df(data_fr)


## ---- echo = FALSE-------------------------------------------------------
my_tbl

## ------------------------------------------------------------------------
my_tbl <- mutate(my_tbl, company = tolower(company))
my_tbl$company 

## ------------------------------------------------------------------------
temp <- my_tbl %>% select(company) %>% mutate(first_letter = substr(company,1,1))
unique(temp$first_letter)

## ------------------------------------------------------------------------
my_tbl <- my_tbl  %>% 
  mutate(first_letter = substr(company,1,1))  %>% 
  mutate(company = replace(company, first_letter == "p", "philips")) %>% 
  mutate(company = replace(company, first_letter == "a", "akzo")) %>% 
  mutate(company = replace(company, first_letter == 'f', 'philips')) %>% 
  mutate(company = replace(company, first_letter == "v", "van houten")) %>%
  mutate(company = replace(company, first_letter == 'u', 'unilever')) %>% 
  select(-first_letter)

my_tbl$company

## ------------------------------------------------------------------------
my_tbl <- 
separate(my_tbl, Product.code...number , c("product_code", "product_number"),
         sep = '-', remove = FALSE)
my_tbl

## ------------------------------------------------------------------------
my_tbl <- my_tbl  %>% 
mutate(product_category = product_code)  %>% 
mutate(
product_category = replace(product_category, product_code == "p", "Smartphone"), 
product_category = replace(product_category, product_code == "v", "TV"),
product_category = replace(product_category, product_code == "x", "Laptop"),
product_category = replace(product_category, product_code== "q", "Tablet")
      ) 

select(my_tbl,product_code, product_category)

## ------------------------------------------------------------------------
my_tbl <-
  mutate(
         my_tbl, full_address = paste(address, city, country, sep= ',')
         )

my_tbl$full_address

## ------------------------------------------------------------------------
my_tbl <-mutate( my_tbl,
          company_philips = as.integer(company == 'philips'), 
          company_akzo = as.integer(company == 'akzo'),
          company_van_houten = as.integer(company == 'van houten'),
          company_unilever = as.integer(company == 'unilever'),
          product_smartphone = as.integer(product_code == 'p'), 
          product_tv = as.integer(product_code == 'v'),
          product_laptop = as.integer(product_code == 'x'),
          product_tablet =  as.integer(product_code == 'q')
          )

select(my_tbl, contains('com'))
select(my_tbl, contains('product_'), -product_number)

## ------------------------------------------------------------------------
write.csv(my_tbl, file="refine_clean.csv")

