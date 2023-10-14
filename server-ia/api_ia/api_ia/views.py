from django.shortcuts import render
from django.http import JsonResponse
from django import forms
from api_ia.rede_neural import redeNeuralDishcover

# Create your views here.
def hellow_world(request):
  data = {
    "Message": "Hellow World :)"
  }
  
  return JsonResponse(data)


def search_ia(request):
  
  
  img = request.FILES.get("img")
  
  obj = redeNeuralDishcover(img=img)
  
  retorno = obj.classficacao()
  
  data = {
    "Classificação": f"{retorno}"
  }
  
  return JsonResponse(data)
  