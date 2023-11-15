
library(ckanr)
library(tidyverse)
library(readr)

ckanr_setup(url="https://dados.antt.gov.br/")

package_list(as="table")

group_list(as = 'table')


group_show('rodovias', as = 'table')[["packages"]][, c("num_resources", "name", "url", "id")] %>% knitr::kable()

#escolhe o id da lista anterior, que corresponde ao banco de dados que você quer
id_ = '5bf70ec3-b24e-4f73-99a0-78b200f5e915'

head(package_show(id_, as = 'table')[["resources"]][, c("url", "name")], 3) %>% knitr::kable()

#importar item
trafego_pracas <- package_show(id_, as = 'table')[["resources"]][["url"]] %>%
  str_subset("csv")%>%
  .[length(.)] %>%
  read.csv2(encoding = 'latin1',stringsAsFactors = F)


