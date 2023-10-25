from PIL import ImageFile
import tensorflow as tf
import numpy as np
from keras.preprocessing.image import ImageDataGenerator
from keras.models import Sequential, load_model
from keras.layers import Conv2D, MaxPooling2D, Flatten, Dense
import time
import matplotlib.pyplot as plt


print("#######################################")
print(tf.config.list_physical_devices())
print("#######################################")


path_treino = "./data/data/train/"
path_test = "./data/data/test/"


train_datagen = ImageDataGenerator(rescale=1./255)
test_datagen = ImageDataGenerator(rescale=1./255)

train_dataset = train_datagen.flow_from_directory(
    path_treino,
    target_size=(300, 300),
    batch_size=64,
    class_mode='categorical')

validation_dataset = test_datagen.flow_from_directory(
    path_test,
    target_size=(300, 300),
    batch_size=64,
    class_mode='categorical')


# Criar o modelo
model = Sequential()

# Adicionar as camadas convolucionais
# model.add(Conv2D(32, (3, 3), activation='relu', input_shape=(300, 300, 3)))
# model.add(MaxPooling2D(pool_size=(2, 2)))

# model.add(Conv2D(64, (3, 3), activation='relu'))
# model.add(MaxPooling2D(pool_size=(2, 2)))

# model.add(Conv2D(128, (3, 3), activation='relu'))
# model.add(MaxPooling2D(pool_size=(2, 2)))

# model.add(Conv2D(128, (3, 3), activation='relu'))
# model.add(MaxPooling2D(pool_size=(2, 2)))

# model.add(Flatten())

# # Adicionar camadas densas
# model.add(Dense(512, activation='relu'))


model.add(Conv2D(32, (3, 3), activation='relu', input_shape=(300, 300, 3)))
model.add(MaxPooling2D((2, 2)))
model.add(Conv2D(64, (3, 3), activation='relu'))
model.add(MaxPooling2D((2, 2)))
model.add(Flatten())
model.add(Dense(128, activation='relu'))

model.add(Dense(len(train_dataset.class_indices), activation='softmax'))

# Compilar o modelo
model.compile(optimizer='adam', loss='CategoricalCrossentropy',
              metrics=[tf.keras.metrics.AUC(num_thresholds=3),  tf.keras.metrics.Recall(), tf.keras.metrics.Precision(), tf.keras.metrics.FalseNegatives(), tf.keras.metrics.FalsePositives()])

start_time = time.time()
# Treinar o modelo
resultados = model.fit_generator(
    train_dataset,
    steps_per_epoch=20,
    epochs=8,
    validation_data=validation_dataset,
)
end_time = time.time()

tempo_de_treinamento = (end_time - start_time) / 60

print("#######################################")
print("Tempo de treinamento:", tempo_de_treinamento, "minutos")
print("#######################################")


plt.plot(resultados.history["loss"])
plt.plot(resultados.history["val_loss"])
plt.title("Histórico de Treinamento")
plt.ylabel("Função de Custo")
plt.xlabel("Épocas de treinamento")
plt.legend(["Erro treino", "Erro teste"])


plt.savefig("./model/resultado_do_modelo_erros.png")
plt.clf()

plt.plot(resultados.history["false_negatives"])
plt.plot(resultados.history["false_positives"])
plt.title("Histórico de Treinamento")
plt.ylabel("Função de Custo")
plt.xlabel("Épocas de treinamento")
plt.legend(["false_negatives", "false_positives"])

plt.savefig("./model/resultado_do_modelo_falses.png")
plt.clf()


plt.plot(resultados.history["auc"])
plt.plot(resultados.history["recall"])
plt.plot(resultados.history["precision"])
plt.title("Histórico de Treinamento")
plt.ylabel("Função de Custo")
plt.xlabel("Épocas de treinamento")
plt.legend(["AUC", "RECALL", "PRECISION"])

plt.savefig("./model/resultado_do_modelo_auc_recall_precision.png")
plt.clf()

model.save("./model/modelo_treinado_teste.h5")
