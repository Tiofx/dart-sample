// @APIVersion 1.0.0
// @Title beego Test API
// @Description beego has a very cool tools to autogenerate documents for your API
// @Contact astaxie@gmail.com
// @TermsOfServiceUrl http://beego.me/
// @License Apache 2.0
// @LicenseUrl http://www.apache.org/licenses/LICENSE-2.0.html
package routers

import (
	"github.com/astaxie/beego"
	"beego/controllers"
	"github.com/astaxie/beego/plugins/cors"
)

func init() {
	beego.InsertFilter("/*", beego.BeforeRouter, cors.Allow(&cors.Options{
		AllowAllOrigins: true,
		AllowMethods:    []string{"GET", "POST", "PUT", "OPTIONS", "DELETE"},
	}))

	ns := beego.NewNamespace("/v1",

		beego.NSNamespace("/projects",
			beego.NSInclude(
				&controllers.ProjectsController{},
			),
		),

		beego.NSNamespace("/roles",
			beego.NSInclude(
				&controllers.RolesController{},
			),
		),

		beego.NSNamespace("/tasks",
			beego.NSInclude(
				&controllers.TasksController{},
			),
		),

		beego.NSNamespace("/task_states",
			beego.NSInclude(
				&controllers.TaskStatesController{},
			),
		),

		beego.NSNamespace("/technical_task_items",
			beego.NSInclude(
				&controllers.TechnicalTaskItemsController{},
			),
		),

		beego.NSNamespace("/technikca_task_states",
			beego.NSInclude(
				&controllers.TechnikcaTaskStatesController{},
			),
		),

		beego.NSNamespace("/users",
			beego.NSInclude(
				&controllers.UsersController{},
			),
		),
	)
	beego.AddNamespace(ns)
}
