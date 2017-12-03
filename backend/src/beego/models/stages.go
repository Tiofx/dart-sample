package models

type Stages struct {
	Id_RENAME  int       `orm:"column(id)"`
	ProjectsId *Projects `orm:"column(projects_id);rel(fk)"`
	Name       string    `orm:"column(name);size(45);null"`
}
