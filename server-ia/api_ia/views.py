from django.shortcuts import render
from django.http import JsonResponse
from django import forms
from api_ia.rede_neural import redeNeuralDishcover

def search_ia(request):
  
  
  img = request.FILES.get("img")
  
  obj = redeNeuralDishcover(img=img)
  
  retorno = obj.classficacao()
  
  data = {
    "class": f"{retorno}"
  }
  
  return JsonResponse(data)
  