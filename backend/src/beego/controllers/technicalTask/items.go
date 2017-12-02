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

type Item struct {
	Id             int    `json:"id"`
	Name           string `json:"name"`
	Status         string `json:"status"`
	LastChangeDate string `json:"last_change_date"`
	//LastChangeDate time.Time `json:"last_change_date"`
	Description string `json:"description"`
}
