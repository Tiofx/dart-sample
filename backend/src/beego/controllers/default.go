package controllers

import (
	"github.com/astaxie/beego"
)

type MainController struct {
	beego.Controller
}

func (c *MainController) Options() {
	c.Ctx.ResponseWriter.Header().Add("Access-Control-Allow-Origin", "*")
	c.Ctx.ResponseWriter.Header().Add("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
	c.Ctx.ResponseWriter.Header().Add("Access-Control-Allow-Headers", "X-PINGOTHER, Content-Type")
	c.Ctx.ResponseWriter.Header().Add("Access-Control-Max-Age", "86400")
	c.Ctx.ResponseWriter.Status = 200
	c.Ctx.WriteString("")
}


func (c *MainController) Get() {
	c.Ctx.ResponseWriter.Header().Add("Access-Control-Allow-Origin", "*")
	c.Ctx.WriteString("hello dart")
}

func (c *MainController) Post() {
	c.Ctx.ResponseWriter.Header().Add("Access-Control-Allow-Origin", "*")
	beego.Info(c.Ctx.Request.Body)
	c.Ctx.WriteString("roger that")

	//c.Data["Website"] = "beego.me"
	//c.Data["Email"] = "astaxie@gmail.com"
	//c.TplName = "index.tpl"
}
