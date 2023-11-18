library("sidrar")
library("GetBCBData")
library("GetTDData")
library("openxlsx")
library("dplyr")
library("rvest")

setwd('C:\\@2.conteudo\\dashboards\\arte das projecoes')

INFLACAO_DADOS_M_BCB <- GetBCBData::gbcbd_get_series(c("IPCA" = 433, "Alimentacao" = 1635, "Habitacao" = 1636, "Residencia" = 1637, "Vestuario" = 1638, "Transportes" = 1639, "Comunicacao" = 1640, "Saude" = 1641, "Despesas Pessoais" = 1642, "Educacao" = 1643, "IGPM" = 189, "IPAM" = 7450, "IPCM" = 7453, "INCCM" = 7456, "IPCA_Nao_Dur" = 10841, "IPCA_Semi_Dur" = 10842, "IPCA_Dur" = 10843, "IPCA_Serv" = 10844, "IPCA_Livre" = 11428, "IPCA_ADM" = 4449, "IPCA_COM" = 4447, "IPCA_NAO_COM" = 4448, "IPCA_NUCLEO_MA" = 11426, "IPCA_EX0" = 11427, "IPCA_EX1" = 16121, "IPCA_DP" = 16122, "IPCA_DIFUSAO" = 21379, "IPCA_INDUSTRIAIS" = 27863, "IPCA_ALIMENTACAO_DOMICILIO" = 27864), , Sys.Date())
INFLACAO_DADOS_M_BCB_W <- GetBCBData::gbcbd_get_series(c("IPCA" = 433, "Alimentacao" = 1635, "Habitacao" = 1636, "Residencia" = 1637, "Vestuario" = 1638, "Transportes" = 1639, "Comunicacao" = 1640, "Saude" = 1641, "Despesas Pessoais" = 1642, "Educacao" = 1643, "IGPM" = 189, "IPAM" = 7450, "IPCM" = 7453, "INCCM" = 7456, "IPCA_Nao_Dur" = 10841, "IPCA_Semi_Dur" = 10842, "IPCA_Dur" = 10843, "IPCA_Serv" = 10844, "IPCA_Livre" = 11428, "IPCA_ADM" = 4449, "IPCA_COM" = 4447, "IPCA_NAO_COM" = 4448, "IPCA_NUCLEO_MA" = 11426, "IPCA_EX0" = 11427, "IPCA_EX1" = 16121, "IPCA_DP" = 16122, "IPCA_DIFUSAO" = 21379, "IPCA_INDUSTRIAIS" = 27863, "IPCA_ALIMENTACAO_DOMICILIO" = 27864), , Sys.Date(), "wide")
RADIAL_DADOS <- GetBCBData::gbcbd_get_series(("IPCA" = 433), , Sys.Date())
DIVULGACOES_MENSAIS <- GetBCBData::gbcbd_get_series(c("IPCA" = 433, "FIPE_1" = 7463, "FIPE_2" = 272, "FIPE_3" = 7464, "FIPE_4" = 193, "IPCA_15" = 7478, "IPC_M" = 7453, "IPC_DI" = 191, "IPC_M_1" = 7454, "IPC_M_2" = 7455), Sys.Date()-3*30, Sys.Date(), "wide")
PROJ_IPCA_BCB <- GetBCBData::gbcbd_get_series(c("IPCA" = 433, "FIPE_1" = 7463, "FIPE_2" = 272, "FIPE_3" = 7464, "FIPE_4" = 193, "IPCA_15" = 7478, "IPC_M" = 7453, "IPC_DI" = 191, "IPC_M_1" = 7454, "IPC_M_2" = 7455), , Sys.Date(), "wide")
COMMODITIES_DADOS_M_BCB <- GetBCBData::gbcbd_get_series(c("IC_BR" = 27574, "IC_AGRO_REAL" = 27575, "IC_METAL_REAL" = 27576, "IC_ENERGIA_REAL" = 27577, "IC_ENERGIA_DOLAR" = 29039, "IC_METAL_DOLAR" = 29040, "IC_AGRO_DOLAR" = 29041, "IC_BR_DOLAR" = 29042), , Sys.Date(), "wide")
CESTA_BASICA_DADOS_M_BCB<- GetBCBData::gbcbd_get_series(c("ARACAJU" = 7479, "BELEM" = 7480, "BELO_HORIZONTE" = 7481, "BRASILIA" = 7482, "CURITIBA" = 7483, "FLORIANOPOLIS" = 7484, "FORTALEZA" = 7485, "GOIANIA" = 7486, "JOAO_PESSOA" = 7487, "NATAL" = 7488, "PORTO_ALEGRE" = 7489, "RECIFE" = 7490, "RIO_DE_JANEIRO" = 7491, "SALVADOR" = 7492, "SAO_PAULO" = 7493, "VITORIA" = 7494), , Sys.Date(), "wide")
NOMES_INFLACAO <- unique(as.character(INFLACAO_DADOS_M_BCB$series.name))
NOMES_INFLACAO_LISTA <- data.frame(NOMES_INFLACAO)
num_resultados <- 10 
# Defina o número de resultados desejado
# Extrair os últimos num_resultados resultados de cada coluna
ULTIMOS_INFLACAO_DADOS_M_BCB <- INFLACAO_DADOS_M_BCB_W %>% summarise(across(.cols = everything(), ~ tail(., num_resultados)))
CURVA_PRE <- GetTDData::get.yield.curve()
# Caminho do arquivo 
Excelcaminho_arquivo <- "/Users/andreperfeito/Documents/EXTRINSECO/CURSO/RELATORIOS/INFLACAO/DADOS_INFLACAO.xlsx"
# Criar um objeto Workbook
wb <- createWorkbook()# Adicionar os data frames como planilhas no arquivo
addWorksheet(wb, "INFLACAO_DADOS_M_BCB")
writeData(wb, "INFLACAO_DADOS_M_BCB", INFLACAO_DADOS_M_BCB)
addWorksheet(wb, "INFLACAO_DADOS_M_BCB_W")
writeData(wb, "INFLACAO_DADOS_M_BCB_W", INFLACAO_DADOS_M_BCB_W)
addWorksheet(wb, "COMMODITIES_DADOS_M_BCB")
writeData(wb, "COMMODITIES_DADOS_M_BCB", COMMODITIES_DADOS_M_BCB)
addWorksheet(wb, "CESTA_BASICA_DADOS_M_BCB")
writeData(wb, "CESTA_BASICA_DADOS_M_BCB", CESTA_BASICA_DADOS_M_BCB)
addWorksheet(wb, "NOMES_INFLACAO_LISTA")
writeData(wb, "NOMES_INFLACAO_LISTA", NOMES_INFLACAO_LISTA)
addWorksheet(wb, "ULTIMOS_INFLACAO_DADOS_M_BCB")
writeData(wb, "ULTIMOS_INFLACAO_DADOS_M_BCB", ULTIMOS_INFLACAO_DADOS_M_BCB)
addWorksheet(wb, "RADIAL_DADOS")

writeData(wb, "RADIAL_DADOS", RADIAL_DADOS)
addWorksheet(wb, "DIVULGACOES_MENSAIS")
writeData(wb, "DIVULGACOES_MENSAIS", DIVULGACOES_MENSAIS)
addWorksheet(wb, "PROJ_IPCA_BCB")
writeData(wb, "PROJ_IPCA_BCB", PROJ_IPCA_BCB)
# Salvar o arquivo
saveWorkbook(wb, 'DADOS_INFLACAO.xlsx', overwrite = TRUE)
