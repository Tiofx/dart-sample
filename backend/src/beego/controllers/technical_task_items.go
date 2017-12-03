package controllers

import (
	"beego/models"
	"encoding/json"
	"strconv"
	"github.com/astaxie/beego"
	"time"
	"github.com/astaxie/beego/context"
	"strings"
	"errors"
)

// TechnicalTaskItemsController operations for TechnicalTaskItems
type TechnicalTaskItemsController struct {
	beego.Controller
}

// URLMapping ...
func (c *TechnicalTaskItemsController) URLMapping() {
	c.Mapping("Post", c.Post)
	c.Mapping("GetOne", c.GetOne)
	c.Mapping("GetAll", c.GetAll)
	c.Mapping("Put", c.Put)
	c.Mapping("Delete", c.Delete)
}

// Post ...
// @Title Post
// @Description create TechnicalTaskItems
// @Param	body		body 	models.TechnicalTaskItems	true		"body for TechnicalTaskItems content"
// @Success 201 {int} models.TechnicalTaskItems
// @Failure 403 body is empty
// @router / [post]
func (c *TechnicalTaskItemsController) Post() {
	var v models.TechnicalTaskItems
	if err := json.Unmarshal(c.Ctx.Input.RequestBody, &v); err == nil {
		if _, err := models.AddTechnicalTaskItems(&v); err == nil {
			c.Ctx.Output.SetStatus(201)
			c.Data["json"] = v
		} else {
			c.Data["json"] = err.Error()
		}
	} else {
		c.Data["json"] = err.Error()
	}
	c.ServeJSON()
}

// @Param page query int true "page number"
// @Param per_page query int true "number of items per page"
// @Param offset query int false "offset items number"
// @router / [get]
func (c *TechnicalTaskItemsController) CustomGet(page, per_page int, offset *int) ([]Item, error) {
	beego.Info(page, per_page)

	skip := per_page * (page - 1)
	if skip+per_page >= len(mockItems) {
		return nil, context.NotFound
	}

	return mockItems[skip:skip+per_page], nil
}

type Item struct {
	Id             int    `json:"id"`
	Name           string `json:"name"`
	Status         string `json:"status"`
	LastChangeDate string `json:"last_change_date"`
	//LastChangeDate time.Time `json:"last_change_date"`
	Description string `json:"description"`
}

var mockItems = []Item{
	{1, "Главная страница", "in_work", toIso8601(time.Now()), "На странеце должна быть основная информации о компании----"},
	{2, "Главная страница", "in_work", toIso8601(time.Now()), "На странеце должна быть основная информации о компании----"},
	{3, "Главная страница", "in_work", toIso8601(time.Now()), "На странеце должна быть основная информации о компании----"},
	{4, "Главная страница", "in_work", toIso8601(time.Now()), "На странеце должна быть основная информации о компании----"},
	{5, "Главная страница", "in_work", toIso8601(time.Now()), "На странеце должна быть основная информации о компании----"},
	{6, "Главная страница", "in_work", toIso8601(time.Now()), "На странеце должна быть основная информации о компании----"},
	{7, "Главная страница", "in_work", toIso8601(time.Now()), "На странеце должна быть основная информации о компании----"},
	{8, "Главная страница", "in_work", toIso8601(time.Now()), "На странеце должна быть основная информации о компании----"},
	{9, "Главная страница", "in_work", toIso8601(time.Now()), "На странеце должна быть основная информации о компании----"},
	{10, "Главная страница", "in_work", toIso8601(time.Now()), "На странеце должна быть основная информации о компании----"},
}

func toIso8601(now time.Time) string {
	return now.UTC().Format("2016-01-02T15:04:05-0700")
}

// GetOne ...
// @Title Get One
// @Description get TechnicalTaskItems by id
// @Param	id		path 	string	true		"The key for staticblock"
// @Success 200 {object} models.TechnicalTaskItems
// @Failure 403 :id is empty
// @router /:id [get]
func (c *TechnicalTaskItemsController) GetOne() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)
	v, err := models.GetTechnicalTaskItemsById(id)
	if err != nil {
		c.Data["json"] = err.Error()
	} else {
		c.Data["json"] = v
	}
	c.ServeJSON()
}

// GetAll ...
// @Title Get All
// @Description get TechnicalTaskItems
// @Param	query	query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	fields	query	string	false	"Fields returned. e.g. col1,col2 ..."
// @Param	sortby	query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	order	query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ..."
// @Param	limit	query	string	false	"Limit the size of result set. Must be an integer"
// @Param	offset	query	string	false	"Start position of result set. Must be an integer"
// @Success 200 {object} models.TechnicalTaskItems
// @Failure 403
// @router / [get]
func (c *TechnicalTaskItemsController) GetAll() {
	var fields []string
	var sortby []string
	var order []string
	var query = make(map[string]string)
	var limit int64 = 10
	var offset int64

	// fields: col1,col2,entity.col3
	if v := c.GetString("fields"); v != "" {
		fields = strings.Split(v, ",")
	}
	// limit: 10 (default is 10)
	if v, err := c.GetInt64("limit"); err == nil {
		limit = v
	}
	// offset: 0 (default is 0)
	if v, err := c.GetInt64("offset"); err == nil {
		offset = v
	}
	// sortby: col1,col2
	if v := c.GetString("sortby"); v != "" {
		sortby = strings.Split(v, ",")
	}
	// order: desc,asc
	if v := c.GetString("order"); v != "" {
		order = strings.Split(v, ",")
	}
	// query: k:v,k:v
	if v := c.GetString("query"); v != "" {
		for _, cond := range strings.Split(v, ",") {
			kv := strings.SplitN(cond, ":", 2)
			if len(kv) != 2 {
				c.Data["json"] = errors.New("Error: invalid query key/value pair")
				c.ServeJSON()
				return
			}
			k, v := kv[0], kv[1]
			query[k] = v
		}
	}

	l, err := models.GetAllTechnicalTaskItems(query, fields, sortby, order, offset, limit)
	if err != nil {
		c.Data["json"] = err.Error()
	} else {
		c.Data["json"] = l
	}
	c.ServeJSON()
}

//Put ...
//@Title Put
//@Description update the TechnicalTaskItems
//@Param    id        path    string    true        "The id you want to update"
//@Param    body        body    models.TechnicalTaskItems    true        "body for TechnicalTaskItems content"
//@Success 200 {object} models.TechnicalTaskItems
//@Failure 403:id is not int
//@router /:id [put]
func (c *TechnicalTaskItemsController) Put() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)
	v := models.TechnicalTaskItems{Id: id}
	if err := json.Unmarshal(c.Ctx.Input.RequestBody, &v); err == nil {
		if err := models.UpdateTechnicalTaskItemsById(&v); err == nil {
			c.Data["json"] = "OK"
		} else {
			c.Data["json"] = err.Error()
		}
	} else {
		c.Data["json"] = err.Error()
	}
	c.ServeJSON()
}

// Delete ...
// @Title Delete
// @Description delete the TechnicalTaskItems
// @Param	id		path 	string	true		"The id you want to delete"
// @Success 200 {string} delete success!
// @Failure 403 id is empty
// @router /:id [delete]
func (c *TechnicalTaskItemsController) Delete() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)
	if err := models.DeleteTechnicalTaskItems(id); err == nil {
		c.Data["json"] = "OK"
	} else {
		c.Data["json"] = err.Error()
	}
	c.ServeJSON()
}
