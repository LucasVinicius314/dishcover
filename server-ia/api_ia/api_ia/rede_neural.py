import numpy as np
from keras.models import load_model
from tensorflow.keras.preprocessing import image
import os
from PIL import Image
import json

class redeNeuralDishcover():
  def __init__(self, img) -> None:
    self.img = img

  def classficacao(self):
    
    path = os.getcwd()
    
    model = load_model(path + "/model/modelo_fruits_classifier_surezadaxd.h5")

    img = Image.open(self.img)
    
    img = img.resize((100,100))

    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    images = np.vstack([x])
    value = model.predict(images)
    value = value[0].tolist()
    
    value_list_int = list(map(int, value))         
    
    maxValue = max(value_list_int)        
    valu_posi = value_list_int.index(maxValue)
    
    with open(path + "/model/dataset_indices.json") as f:
      dictClassifier = json.load(f)
      
    
    for i,each in enumerate(dictClassifier):
      
      if(valu_posi == i):
        print(each)
        return each