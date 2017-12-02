package technicalTask

import (
	"github.com/astaxie/beego"
	"time"
	"github.com/astaxie/beego/context"
)

type ItemsController struct {
	beego.Controller
}

// @Param page query int true "page number"
// @Param per_page query int true "number of items per page"
// @Param offset query int false 0 "offset items number"
// @router / [get]
func (c *ItemsController) CustomGet(page, per_page int, offset *int) ([]Item, error) {
	beego.Info(page, per_page, *offset)

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
