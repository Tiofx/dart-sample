package models

type Tasks struct {
	Id_RENAME           int                 `orm:"column(id)"`
	StagesId            int                 `orm:"column(stages_id)"`
	TechnicalTaskItemId *TechnicalTaskItems `orm:"column(technical_task_item_id);rel(fk)"`
	TaskStatesId        *TaskStates         `orm:"column(task_states_id);rel(fk)"`
	Name                string              `orm:"column(name);size(45);null"`
	Description         string              `orm:"column(description);null"`
	DeveloperId         *Users              `orm:"column(developer_id);rel(fk)"`
}
