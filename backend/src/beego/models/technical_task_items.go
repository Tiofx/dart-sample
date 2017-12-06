package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type TechnicalTaskItems struct {
	Id                   int                  `orm:"column(id);auto"`
	AuthorId             *Users               `orm:"column(author_id);rel(fk)"`
	TechnikcaTaskStateId *TechnikcaTaskStates `orm:"column(technikca_task_state_id);rel(fk)"`
	Name                 string               `orm:"column(name);size(45);null"`
	Description          string               `orm:"column(description);size(45);null"`
	Date                 time.Time            `orm:"column(date);type(datetime);null"`
}

func (t *TechnicalTaskItems) TableName() string {
	return "technical_task_items"
}

func init() {
	orm.RegisterModel(new(TechnicalTaskItems))
}

// CountTechnicalTaskItems get a number of TechnicalTaskItems into database and returns
func CountTechnicalTaskItems(query map[string]string) (count int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(TechnicalTaskItems))
	qs = setUpQuery(query, qs)

	count, err = qs.Count()
	return
}

// AddTechnicalTaskItems insert a new TechnicalTaskItems into database and returns
// last inserted Id on success.
func AddTechnicalTaskItems(m *TechnicalTaskItems) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetTechnicalTaskItemsById retrieves TechnicalTaskItems by Id. Returns error if
// Id doesn't exist
func GetTechnicalTaskItemsById(id int) (v *TechnicalTaskItems, err error) {
	o := orm.NewOrm()
	v = &TechnicalTaskItems{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetAllTechnicalTaskItems retrieves all TechnicalTaskItems matches certain condition. Returns empty list if
// no records exist
func GetAllTechnicalTaskItems(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(TechnicalTaskItems))
	// query k=v
	qs = setUpQuery(query, qs)
	// order by:
	var sortFields []string
	if len(sortby) != 0 {
		if len(sortby) == len(order) {
			// 1) for each sort field, there is an associated order
			for i, v := range sortby {
				orderby := ""
				if order[i] == "desc" {
					orderby = "-" + v
				} else if order[i] == "asc" {
					orderby = v
				} else {
					return nil, errors.New("Error: Invalid order. Must be either [asc|desc]")
				}
				sortFields = append(sortFields, orderby)
			}
			qs = qs.OrderBy(sortFields...)
		} else if len(sortby) != len(order) && len(order) == 1 {
			// 2) there is exactly one order, all the sorted fields will be sorted by this order
			for _, v := range sortby {
				orderby := ""
				if order[0] == "desc" {
					orderby = "-" + v
				} else if order[0] == "asc" {
					orderby = v
				} else {
					return nil, errors.New("Error: Invalid order. Must be either [asc|desc]")
				}
				sortFields = append(sortFields, orderby)
			}
		} else if len(sortby) != len(order) && len(order) != 1 {
			return nil, errors.New("Error: 'sortby', 'order' sizes mismatch or 'order' size is not 1")
		}
	} else {
		if len(order) != 0 {
			return nil, errors.New("Error: unused 'order' fields")
		}
	}

	var l []TechnicalTaskItems
	qs = qs.OrderBy(sortFields...)
	if _, err = qs.Limit(limit, offset).All(&l, fields...); err == nil {
		if len(fields) == 0 {
			for _, v := range l {
				ml = append(ml, v)
			}
		} else {
			// trim unused fields
			for _, v := range l {
				m := make(map[string]interface{})
				val := reflect.ValueOf(v)
				for _, fname := range fields {
					m[fname] = val.FieldByName(fname).Interface()
				}
				ml = append(ml, m)
			}
		}
		return ml, nil
	}
	return nil, err
}
func setUpQuery(query map[string]string, qs orm.QuerySeter) orm.QuerySeter {
	for k, v := range query {
		// rewrite dot-notation to Object__Attribute
		k = strings.Replace(k, ".", "__", -1)
		if strings.Contains(k, "isnull") {
			qs = qs.Filter(k, (v == "true" || v == "1"))
		} else {
			qs = qs.Filter(k, v)
		}
	}
	return qs
}

// UpdateTechnicalTaskItems updates TechnicalTaskItems by Id and returns error if
// the record to be updated doesn't exist
func UpdateTechnicalTaskItemsById(m *TechnicalTaskItems) (err error) {
	o := orm.NewOrm()
	v := TechnicalTaskItems{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteTechnicalTaskItems deletes TechnicalTaskItems by Id and returns error if
// the record to be deleted doesn't exist
func DeleteTechnicalTaskItems(id int) (err error) {
	o := orm.NewOrm()
	v := TechnicalTaskItems{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&TechnicalTaskItems{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}
