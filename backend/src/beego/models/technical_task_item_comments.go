package models

import "time"

type TechnicalTaskItemComments struct {
	Id_RENAME           int                 `orm:"column(id)"`
	AuthorId            *Users              `orm:"column(author_id);rel(fk)"`
	TechnicalTaskItemId *TechnicalTaskItems `orm:"column(technical_task_item_id);rel(fk)"`
	Comment             string              `orm:"column(comment)"`
	Date                time.Time           `orm:"column(date);type(datetime)"`
}
