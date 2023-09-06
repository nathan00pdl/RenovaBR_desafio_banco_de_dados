#OBSERVAÇÃO:
#ESTE ARQUIVO E O "tratando_perfil_eleitorado_2020.csv" SÃO IGUAIS, ALTERANDO APENAS O CAMINHO DE LEITURA DOS ARQUIVOS NOS CÓDIGOS QUE SEGUEM.


#Tratamento dos dados para serem inseridos diretos na tabela 'sp_turno_1'

#(Base de dados: 'SP_turno_1.csv')

#IMPORTANTE:
#O primeiro passo do tratamento da base de dados original (sp_turno_1.csv) foi passar todo o arquivo para o formato UTF-8, para que fosse 
#possível modificá-lo como um todo por meio de programas em python. (apenas joguei o arquivo em um site na web para fazer essa conversão inicial)
#(o arquivo original recebido por email estava no formato "ANSI", dessa forma não seria possível tratar a base com programas em python)



#PROCEDIMENTO 1:
#Código python para remover os espaços em branco e substituir espaços em palavras por undescore (Ex: SÃO_BENTO_DO_SAPUCAÍ).
import csv

#Base de dados a ser tratada (arquivo .CSV)
file_path = 'C:/Users/Nathan/Downloads/SP_turno_1_FORMATADO.csv'

#Abre o arquivo para realizar somente leiutra
with open(file_path, 'r', newline='', encoding='utf-8') as csvfile:
    data = list(csv.reader(csvfile, delimiter=';'))

print("successfully accessed file!")

#Abre o arquivo para realizar somente escrita
with open(file_path, 'w', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile, delimiter=';')

    for row in data:
        cleaned_row = []

        #Substitui espaços por underscores e remove espaços extras de cada linha ("tupla")
        for cell in row:
            cleaned_cell = cell.strip().replace(' ', '_')  
            cleaned_row.append(cleaned_cell)

        writer.writerow(cleaned_row)

print("Format completed successfully!")




#PROCEDIMENTO 2:
#Código python para substituir todos todos os ponto e vírgula (";") por vírgulas simples (",").
import csv

#Base de dados a ser tratada (arquivo .CSV)
file_path = 'C:/Users/Nathan/Downloads/SP_turno_1_FORMATADO.csv'

#Abre o arquivo para realizar somente leiutra
with open(file_path, 'r', newline='', encoding='utf-8') as csvfile:
    data = list(csv.reader(csvfile, delimiter=';')) 

print("successfully accessed file!")

#Abre o arquivo para realizar somente escrita
with open(file_path, 'w', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile, delimiter=',')

    for row in data:
        cleaned_row = [cell.replace(';', ',') for cell in row]  #Substituição de cada ";" por ","
        writer.writerow(cleaned_row)

print("Format completed successfully!")




#PROCEDIMENTO 3:
#Código python para remover todas as aspas duplas dos campos ("colunas").
import csv

#Base de dados a ser tratada (arquivo .CSV)
file_path = 'C:/Users/Nathan/Downloads/SP_turno_1_FORMATADO.csv'

#Abre o arquivo para realizar somente leitura
with open(file_path, 'r', newline='', encoding='utf-8') as csvfile:
    data = list(csv.reader(csvfile))

print("successfully accessed file!")

#Percorre os dados e remover as aspas duplas
for i in range(len(data)):
    for j in range(len(data[i])):
        data[i][j] = data[i][j].replace('"', '')

#Abre o arquivo para realizar somente escrita
with open(file_path, 'w', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile)

    #Escreve os dados modificados
    writer.writerows(data)

print("Format completed successfully!")




#PROCEDIMENTO 4:
#Código python para adicionar aspas simples em cada campo ("coluna") que seja do tipo String.
import csv

#Base de dados a ser tratada (arquivo .CSV)
file_path = 'C:/Users/Nathan/Downloads/SP_turno_1_FORMATADO.csv'

#Abre o arquivo para realizar somente leitura
with open(file_path, 'r', newline='', encoding='utf-8') as csvfile:
    data = list(csv.reader(csvfile))

print("successfully accessed file!")

#Obtem os nomes das colunas
header = data[0]

#Adiciona aspas simples aos nomes das colunas (cabeçalho/primeira linha do arquivo .csv)
header = ["'" + col + "'" for col in header]

#Percorre os dados e adiciona aspas aos valores não numéricos
for i in range(1, len(data)):
    for j in range(len(data[i])):
        if not data[i][j].isnumeric():
            data[i][j] = "'" + data[i][j] + "'"

#Abre o arquivo para realizar somente escrita
with open(file_path, 'w', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile)

    #Escreve o cabeçalho modificado
    writer.writerow(header)

    #Escreve os dados modificados
    writer.writerows(data[1:])

print("Format completed successfully!")




#PROCEDIMENTO 5:
#Código python para remover aspas simples dos valores negativos.
import csv

#Base de dados a ser tratada (arquivo .CSV)
file_path = 'C:/Users/Nathan/Downloads/SP_turno_1_FORMATADO.csv'

#Função para remover as aspas simples de valores negativos
def remove_quotes(value):
    if value == "'-1'":
        return -1
    return value

#Abre o arquivo para realizar somente leitura
with open(file_path, 'r', newline='') as csvfile:
    data = csv.reader(csvfile)
    rows = [row for row in data]

print("successfully accessed file!")

#Abre o arquivo para realizar somente escrita
with open(file_path, 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)

    for row in rows:
        modified_row = [remove_quotes(value) for value in row]
        writer.writerow(modified_row)

print("Format completed successfully!")




#PROCEDIMENTO 6:
#Código python para remover acentos e formatar tudo para "caixa baixa".
import csv
import unicodedata

#Base de dados a ser tratada (arquivo .CSV)
file_path = 'C:/Users/Nathan/Downloads/SP_turno_1_FORMATADO.csv'

#Definição de função para remover acentos
def remove_accents(input_str):
    nfkd_form = unicodedata.normalize('NFKD', input_str)
    return ''.join([c for c in nfkd_form if not unicodedata.combining(c)])

#Definição de função para converter texto para caixa baixa
def to_lower(input_str):
    return input_str.lower()

#Abre o arquivo para realizar somente leitura
with open(file_path, 'r', encoding='utf-8') as csvfile:
    data = csv.reader(csvfile)
    rows = list(data)
    
print("successfully accessed file!")

for i, row in enumerate(rows):
    new_row = [to_lower(remove_accents(cell)) for cell in row]  #removendo acentos e convertendo para caixa baixa
    rows[i] = new_row

#Abre o arquivo para realizar somente escrita
with open(file_path, 'w', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerows(rows)

print("Format completed successfully!")



#IMPORTANTE:
#Cada procedimento foi feito na medida em que eu via necessidade de alterar o arquivo csv como um todo, com o intuito de deixá-lo 
#o máximo compatível para o momento ao qual fosse transferir os dados para a tabela "sp_turno_1" no banco de dados.
