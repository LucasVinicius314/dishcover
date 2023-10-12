package main

import (
	"github.com/gin-contrib/static"

	gin "github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()

	router.GET("/api/health", func(ctx *gin.Context) {
		ctx.JSON(200, map[string]string{
			"message": "success",
		})
	})

	router.NoRoute(static.Serve("/", static.LocalFile("../public", false)))

	router.Run(":80")
}
