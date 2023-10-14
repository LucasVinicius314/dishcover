package main

import (
	"dishcover/server/pkg/service"
	"log"

	"github.com/gin-contrib/static"
	"github.com/iancoleman/strcase"

	gin "github.com/gin-gonic/gin"
)

func main() {
	typesenseService := service.TypesenseService{}

	router := gin.Default()

	router.Use(func(ctx *gin.Context) {
		ctx.Header("Access-Control-Allow-Origin", "*")
		ctx.Header("Access-Control-Allow-Headers", "*")
		ctx.Header("Access-Control-Allow-Methods", "GET, POST")
	})

	apiGroup := router.Group("api")
	{
		apiGroup.GET("health", func(ctx *gin.Context) {
			ctx.JSON(200, map[string]string{
				"message": "success",
			})
		})

		apiGroup.POST("recipe", func(ctx *gin.Context) {
			res, err := typesenseService.SearchRecipes("tomato")
			if err != nil {
				log.Printf("failed to search recipes: %v", err)

				ctx.JSON(400, res)
				return
			}

			ctx.JSON(200, convertKeys(res))
		})
	}

	router.NoRoute(static.Serve("/", static.LocalFile("../public", false)))

	router.Run(":80")
}

func convertKeys(input map[string]interface{}) map[string]interface{} {
	temp := map[string]interface{}{}

	for k, v := range input {
		fixed := fixKey(k)
		temp[fixed] = v
	}

	return temp
}

func fixKey(key string) string {
	return strcase.ToSnake(key)
}
