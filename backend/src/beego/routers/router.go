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
	"github.com/astaxie/beego/context"
)

func init() {
	ns := beego.NewNamespace("/v1",

		beego.NSBefore(func(context *context.Context) {
			context.Output.Header("Access-Control-Allow-Origin", "*")
		}),

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
