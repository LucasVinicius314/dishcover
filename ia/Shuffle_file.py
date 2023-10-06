import os
import random
import string


def rename_files(path):
    # Obter a lista de arquivos no diretório
    files = os.listdir(path)

    # Iterar sobre os arquivos e renomeá-los
    for file_name in files:
        # Gerar um nome aleatório com 6 caracteres
        new_name = ''.join(random.choices(
            string.ascii_lowercase + string.digits, k=6))

        # Obter o caminho completo do arquivo
        file_path = os.path.join(path, file_name)

        # Obter a extensão do arquivo
        file_extension = os.path.splitext(file_name)[1]

        # Gerar o novo nome do arquivo com a extensão
        new_file_name = new_name + file_extension

        # Renomear o arquivo
        os.rename(file_path, os.path.join(path, new_file_name))


# Exemplo de uso
# directory_path = './data/archiveshort/validation/'
# rename_files(directory_path)
