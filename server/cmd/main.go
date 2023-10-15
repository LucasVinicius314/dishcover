package main

import (
	"dishcover/server/pkg/service"
	"io"
	"log"

	"github.com/gin-contrib/static"
	"github.com/iancoleman/strcase"

	gin "github.com/gin-gonic/gin"
)

func main() {
	aiService := service.AiService{}
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
			formFile, err := ctx.FormFile("file")
			if err != nil {
				ctx.JSON(400, map[string]string{
					"message": "failed to get form file",
				})

				return
			}

			file, err := formFile.Open()
			if err != nil {
				ctx.JSON(400, map[string]string{
					"message": "failed to open form file",
				})

				return
			}

			buffer, err := io.ReadAll(file)
			if err != nil {
				ctx.JSON(400, map[string]string{
					"message": "failed to read form file",
				})

				return
			}

			aiRes, err := aiService.ClassifyImage(buffer)
			if err != nil {
				log.Printf("failed to search recipes: %v", err)

				ctx.JSON(400, aiRes)
				return
			}

			class := aiRes["class"].(string)

			typesenseRes, err := typesenseService.SearchRecipes(class)
			if err != nil {
				log.Printf("failed to search recipes: %v", err)

				ctx.JSON(400, typesenseRes)
				return
			}

			ctx.JSON(200, convertKeys(typesenseRes))
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
