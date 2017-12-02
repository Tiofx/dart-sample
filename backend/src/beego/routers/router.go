package routers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
	"beego/controllers"
	"beego/controllers/technicalTask"
)

func init() {
	//beego.SetStaticPath("/styles.css","views/build/web/styles.css")
	//beego.SetStaticPath("/main.dart.js","views/build/web/main.dart.js")

	namespace := beego.NewNamespace("/api",
		beego.NSBefore(func(context *context.Context) {
			context.ResponseWriter.Header().Add("Access-Control-Allow-Origin", "*")
		}),
		beego.NSRouter("/", &controllers.MainController{}),
		beego.NSNamespace("/technical_task",
			beego.NSNamespace("/items",
				beego.NSInclude(&technicalTask.ItemsController{}),
			),
		),
	)

	beego.AddNamespace(namespace)
}
