package main

import (
	"dishcover/seeder/pkg/model"
	"encoding/csv"
	"fmt"
	"os"
	"time"

	"github.com/typesense/typesense-go/typesense"
	api "github.com/typesense/typesense-go/typesense/api"
	"github.com/typesense/typesense-go/typesense/api/pointer"
)

var (
	filePath                = "../../bin/food.csv"
	typesenseServerUrl      = "http://localhost:8108"
	typesenseCollectionName = "recipe"
)

func main() {
	fileReader, err := os.Open(filePath)
	if err != nil {
		panic(err)
	}
	defer fileReader.Close()

	csvReader := csv.NewReader(fileReader)

	records, err := csvReader.ReadAll()
	if err != nil {
		panic(err)
	}

	recipes := []interface{}{}

	for _, record := range records[1:] {
		recipes = append(recipes, model.Recipe{
			Id:                 record[0],
			Title:              record[1],
			Ingredients:        record[2],
			Instructions:       record[3],
			ImageName:          record[4],
			CleanedIngredients: record[5],
		})
	}

	typesenseClient := typesense.NewClient(
		typesense.WithServer(typesenseServerUrl),
		typesense.WithAPIKey(os.Getenv("TYPESENSE_KEY")),
	)

	_, _ = typesenseClient.Collection(typesenseCollectionName).Delete()

	_, err = typesenseClient.Collections().Create(&api.CollectionSchema{
		Name: typesenseCollectionName,
		Fields: []api.Field{
			{
				Name: "id",
				Type: "string",
			},
			{
				Name:  "title",
				Type:  "string",
				Infix: pointer.True(),
			},
			{
				Name:  "ingredients",
				Type:  "string",
				Infix: pointer.True(),
			},
			{
				Name: "instructions",
				Type: "string",
			},
			{
				Name: "image_name",
				Type: "string",
			},
			{
				Name:  "cleaned_ingredients",
				Type:  "string",
				Infix: pointer.True(),
			},
		},
	})
	if err != nil {
		panic(err)
	}

	then := time.Now().UnixMilli()

	_, err = typesenseClient.Collection(typesenseCollectionName).Documents().Import(recipes, &api.ImportDocumentsParams{
		Action: pointer.String("create"),
	})
	if err != nil {
		panic(err)
	}

	print(fmt.Sprintf("%d ms", time.Now().UnixMilli()-then))
}
