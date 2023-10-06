import os
import random
import shutil
import sys


def obter_nomes_pastas(diretorio):
    nomes_pastas = []
    for nome in os.listdir(diretorio):
        if os.path.isdir(os.path.join(diretorio, nome)):
            nomes_pastas.append(nome)
    return nomes_pastas


# Exemplo de uso
cwd = os.getcwd()

diretorio = cwd + sys.argv[1]
pastas = obter_nomes_pastas(diretorio)

diretorio_origem = diretorio
diretorio_destino = cwd + sys.argv[2]

for each in pastas:

    # Diretório contendo todas as imagens
    diretorio_imagens = diretorio_origem + f'/{each}/'

    # Diretório para salvar as imagens de treinamento
    diretorio_treinamento = diretorio_destino + f'/train/{each}/'

    # Diretório para salvar as imagens de teste
    diretorio_teste = diretorio_destino + f'/test/{each}/'

    # Lista todas as imagens no diretório
    imagens = os.listdir(diretorio_imagens)

    # Embaralha a lista de imagens
    random.shuffle(imagens)

    # Calcula o índice para dividir as imagens
    indice_divisao = int(0.8 * len(imagens))

    # Separa as imagens em treinamento e teste
    imagens_treinamento = imagens[:indice_divisao]
    imagens_teste = imagens[indice_divisao:]

    if not (os.path.exists(diretorio_teste)):
        os.makedirs(diretorio_teste)

    if not (os.path.exists(diretorio_treinamento)):
        os.makedirs(diretorio_treinamento)

    # Move as imagens para os diretórios correspondentes
    for imagem in imagens_treinamento:
        shutil.copy(os.path.join(diretorio_imagens, imagem),
                    diretorio_treinamento)

    for imagem in imagens_teste:
        shutil.copy(os.path.join(diretorio_imagens, imagem), diretorio_teste)


def move_files(source_folder, destination_folder, num_files):
    # Cria o diretório de destino, se não existir
    os.makedirs(destination_folder, exist_ok=True)

    # Percorre as subpastas da pasta de origem
    for root, dirs, files in os.walk(source_folder):
        count = 0
        for file in files:
            # Verifica se o arquivo é um arquivo regular
            if os.path.isfile(os.path.join(root, file)):
                source_path = os.path.join(root, file)
                destination_path = os.path.join(destination_folder, file)
                # Move o arquivo para o diretório de destino
                shutil.move(source_path, destination_path)
                print(f"Movendo {file} para {destination_folder}")
                count += 1
                if count == num_files:
                    break
        if count == num_files:
            break


def move_files(source_folder, destination_folder, num_files):
    # Cria o diretório de destino, se não existir
    os.makedirs(destination_folder, exist_ok=True)

    # Percorre as subpastas da pasta de origem
    for root, dirs, files in os.walk(source_folder):
        count = 0
        for file in files:
            # Verifica se o arquivo é um arquivo regular
            if os.path.isfile(os.path.join(root, file)):
                source_path = os.path.join(root, file)
                destination_path = os.path.join(destination_folder, file)
                # Move o arquivo para o diretório de destino
                shutil.move(source_path, destination_path)
                print(f"Movendo {file} para {destination_folder}")
                count += 1
                if count == num_files:
                    break
        if count == num_files:
            break


isValido = sys.argv[3]

if (isValido == 1):

    # Pasta de origem dos arquivos

    source_folder = diretorio_destino + "/train/"
    # source_folder = cwd + '/newdata/train/'

    # Pasta de destino para os arquivos movidos
    destination_folder = diretorio_destino + "/validation/"

    # Número de arquivos a serem movidos
    num_files = 5

    # Chama a função para mover os arquivos

    print(pastas)

    for each in pastas:

        source_folder2 = source_folder + f'{each}'

        move_files(source_folder2, destination_folder, num_files)
