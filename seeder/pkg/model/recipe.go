package model

type Recipe struct {
	Id                 string `json:"id"`
	Title              string `json:"title"`
	Ingredients        string `json:"ingredients"`
	Instructions       string `json:"instructions"`
	ImageName          string `json:"image_name"`
	CleanedIngredients string `json:"cleaned_ingredients"`
}
