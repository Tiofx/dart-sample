package controllers

import (
	"github.com/astaxie/beego"
)

type MainController struct {
	beego.Controller
}

func (c *MainController) Get() {
	c.Ctx.WriteString("hello dart")
}

func (c *MainController) Post() {
	beego.Info(c.Ctx.Request.Body)
	c.Ctx.WriteString("roger that")
}
