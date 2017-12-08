package main

import (
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/qor/qor"
	"github.com/jinzhu/gorm"
	"github.com/qor/admin"
	"net/http"
	"fmt"
	"time"
)

type User struct {
	gorm.Model
	RoleID   uint
	Role     Role
	Login    string
	Password string
}

func (user User) Stringify() string {
	return user.Login
}

type Role struct {
	gorm.Model
	Name string
}

type Project struct {
	gorm.Model
	AuthorID uint `gorm:"column:author_id"`
	Author   User
	Name     string
}

type Stage struct {
	gorm.Model
	ProjectID uint `gorm:"column:projects_id"`
	Project   Project
	Name      string
}

type TaskState struct {
	gorm.Model
	Name string
}

type Task struct {
	gorm.Model
	StageID             uint  `gorm:"column:stages_id"`
	Stage               Stage
	TechnicalTaskItemID uint
	TechnicalTaskItem   TechnicalTaskItem
	TaskStateID         uint  `gorm:"column:task_states_id"`
	TaskState           TaskState
	Name                string
	Description         string
	DeveloperID         *uint `gorm:"column:developer_id"`
	Developer           User
}

type TechnicalTaskItemComment struct {
	gorm.Model
	AuthorID            uint `gorm:"column:author_id"`
	Author              User
	TechnicalTaskItemID uint
	TechnicalTaskItem   TechnicalTaskItem
	Comment             string
	Date                time.Time
}

type TechnicalTaskItem struct {
	gorm.Model
	AuthorID             uint `gorm:"column:author_id"`
	Author               User
	TechnikcaTaskStateID uint
	TechnikcaTaskState   TechnikcaTaskState
	Name                 string
	Description          string
	Date                 time.Time
}

type TechnikcaTaskState struct {
	gorm.Model
	Name string
}

func main() {
	DB, _ := gorm.Open("mysql", "root@tcp(127.0.0.1:8088)/web_kp?parseTime=true")
	//DB.AutoMigrate(
	//	&Project{},
	//	&Role{},
	//	&User{},
	//	&Stage{},
	//	&TaskState{},
	//	&Task{},
	//	&TechnicalTaskItemComment{},
	//	&TechnicalTaskItem{},
	//	&TechnikcaTaskState{},
	//)

	// Initalize
	Admin := admin.New(&admin.AdminConfig{DB: DB})

	// Allow to use Admin to manage User, Product
	Admin.AddResource(&Project{})
	Admin.AddResource(&Role{})
	Admin.AddResource(&Stage{})
	Admin.AddResource(&TaskState{})
	Admin.AddResource(&Task{})
	Admin.AddResource(&TechnicalTaskItemComment{})
	Admin.AddResource(&TechnicalTaskItem{})
	Admin.AddResource(&TechnikcaTaskState{})

	user := Admin.AddResource(&User{})
	user.Meta(&admin.Meta{Name: "Name", Label: "Name", FieldName: "Login", Type: "string"})

	// initalize an HTTP request multiplexer
	mux := http.NewServeMux()

	// Mount admin interface to mux
	Admin.MountTo("/admin", mux)

	fmt.Println("Listening on: 8078")
	http.ListenAndServe(":8078", mux)
}
