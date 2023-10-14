package service

import (
	"os"

	"github.com/mitchellh/mapstructure"
	"github.com/typesense/typesense-go/typesense"
	api "github.com/typesense/typesense-go/typesense/api"
)

var (
	typesenseServerUrl      = "http://localhost:8108"
	typesenseCollectionName = "recipe"
)

type TypesenseService struct {
}

func (s *TypesenseService) SearchRecipes(query string) (map[string]interface{}, error) {
	typesenseClient := typesense.NewClient(
		typesense.WithServer(typesenseServerUrl),
		typesense.WithAPIKey(os.Getenv("TYPESENSE_KEY")),
	)

	res, err := typesenseClient.Collection(typesenseCollectionName).Documents().Search(&api.SearchCollectionParams{
		Q:       query,
		QueryBy: "cleaned_ingredients",
	})
	if err != nil {
		return nil, err
	}

	result := map[string]interface{}{}
	err = mapstructure.Decode(res, &result)
	if err != nil {
		return nil, err
	}

	return result, nil
}
