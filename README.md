# Проектирование базы данных «Штатное расписание сотрудников»

**Тема:** Проектирование реляционной базы данных на основе отчёта «Штатное расписание сотрудников»
**Выполнил**  Галицин Николай
**СУБД:** PostgreSQL
**Инструмент визуализации:** draw.io

---

## 1. Постановка задачи

Дан Excel-файл с отчётом о сотрудниках. Каждая строка содержит информацию о сотруднике, его должности, подразделении, филиале и проекте, на который он назначен.

**Цель:** выделить из «плоской» таблицы смысловые сущности, спроектировать нормализованную реляционную модель (не менее 7 таблиц), определить типы данных PostgreSQL, ключи и связи, построить схему.

---

## 2. Анализ исходных данных

Исходный отчёт содержит 8 столбцов:

| № | Столбец | Пример |
|---|---------|--------|
| 1 | ФИО сотрудника | Суханова Арина Руслановна |
| 2 | Оклад | 103333.00 |
| 3 | Должность | ведущий QA инженер |
| 4 | Тип подразделения | Отдел / Группа / Департамент |
| 5 | Структурное подразделение | Центр компетенций QA Москва |
| 6 | Дата найма | 200113 (ддммгг) |
| 7 | Адрес филиала | Приморский край, г. Владивосток, ул Нижнепортовая, д. 1 |
| 8 | Проект на который назначен | {Итэлма Инженерный корпус} |

### 2.1. Наблюдения

- **Много повторов:** одно и то же подразделение, филиал, тип подразделения, должность встречаются у многих сотрудников.
- **Один сотрудник — несколько проектов:** например, Алексеев К.Н. назначен сразу на 2 проекта, Григорьева В.К. — тоже на 2, Лаптева А.М. — на 2. Значит, связь «сотрудник ↔ проект» — **многие-ко-многим**.
- **Проект — это отдельная сущность**, а не свойство сотрудника.
- **Тип подразделения** — характеристика подразделения (справочник).
- **Даты** записаны в «неудобном» формате `ддммгг` — при загрузке нужно преобразовать в `DATE`.

### 2.2. Выделяемые сущности

| Сущность | Обоснование |
|----------|-------------|
| Тип подразделения | повторяется, конечное множество значений |
| Подразделение | повторяется, зависит от типа |
| Должность | повторяется, конечное множество |
| Филиал (адрес) | повторяется, зависит от местоположения |
| Проект | повторяется, независимая сущность |
| Сотрудник | основная сущность отчёта |
| Назначение на проект | разрешение связи M:N |

**Итого: 7 таблиц.**

---

## 3. Описание таблиц

### 3.1. `department_type` — типы подразделений

**Назначение:** справочник типов (Отдел, Группа, Департамент).

| Столбец | Тип данных | Ограничения | Описание |
|---------|-----------|-------------|----------|
| type_id | SERIAL | **PRIMARY KEY** | Идентификатор |
| name | VARCHAR(50) | NOT NULL, UNIQUE | Название типа |

**PK:** `type_id`

---

### 3.2. `department` — структурные подразделения

**Назначение:** справочник подразделений.

| Столбец | Тип данных | Ограничения | Описание |
|---------|-----------|-------------|----------|
| department_id | SERIAL | **PRIMARY KEY** | Идентификатор |
| name | VARCHAR(200) | NOT NULL, UNIQUE | Название подразделения |
| type_id | INT | NOT NULL, FK → department_type | Тип подразделения |

**PK:** `department_id`
**FK:** `type_id → department_type(type_id)`

---

### 3.3. `branch` — филиалы

**Назначение:** справочник адресов филиалов.

| Столбец | Тип данных | Ограничения | Описание |
|---------|-----------|-------------|----------|
| branch_id | SERIAL | **PRIMARY KEY** | Идентификатор |
| address | VARCHAR(300) | NOT NULL, UNIQUE | Полный адрес филиала |

**PK:** `branch_id`

---

### 3.4. `position` — должности

**Назначение:** справочник должностей.

| Столбец | Тип данных | Ограничения | Описание |
|---------|-----------|-------------|----------|
| position_id | SERIAL | **PRIMARY KEY** | Идентификатор |
| title | VARCHAR(200) | NOT NULL, UNIQUE | Название должности |

**PK:** `position_id`

---

### 3.5. `project` — проекты

**Назначение:** справочник проектов.

| Столбец | Тип данных | Ограничения | Описание |
|---------|-----------|-------------|----------|
| project_id | SERIAL | **PRIMARY KEY** | Идентификатор |
| name | VARCHAR(300) | NOT NULL, UNIQUE | Название проекта |

**PK:** `project_id`

---

### 3.6. `employee` — сотрудники

**Назначение:** центральная таблица с данными о сотрудниках.

| Столбец | Тип данных | Ограничения | Описание |
|---------|-----------|-------------|----------|
| employee_id | SERIAL | **PRIMARY KEY** | Идентификатор |
| full_name | VARCHAR(200) | NOT NULL | ФИО |
| salary | NUMERIC(12,2) | NOT NULL, CHECK (salary > 0) | Оклад |
| hire_date | DATE | NOT NULL | Дата найма |
| position_id | INT | NOT NULL, FK → position | Должность |
| department_id | INT | NOT NULL, FK → department | Подразделение |
| branch_id | INT | NOT NULL, FK → branch | Филиал |

**PK:** `employee_id`
**FK:** `position_id`, `department_id`, `branch_id`

> **Почему `NUMERIC`, а не `FLOAT`?** Деньги должны считаться точно — `FLOAT` даёт погрешность округления.

> **Почему `DATE`, а не `VARCHAR`?** Так можно сортировать, искать по диапазону, вычислять стаж.

---

### 3.7. `employee_project` — назначения сотрудников на проекты

**Назначение:** связующая таблица для связи многие-ко-многим между сотрудниками и проектами.

| Столбец | Тип данных | Ограничения | Описание |
|---------|-----------|-------------|----------|
| employee_id | INT | **PRIMARY KEY (составной)**, FK → employee | Сотрудник |
| project_id | INT | **PRIMARY KEY (составной)**, FK → project | Проект |

**PK:** `(employee_id, project_id)` — составной
**FK:** `employee_id → employee(employee_id) ON DELETE CASCADE`
**FK:** `project_id → project(project_id) ON DELETE CASCADE`

> Составной PK гарантирует, что один сотрудник не будет дважды назначен на один и тот же проект.

---

## 4. Связи между таблицами

| № | Родитель | Дочерняя | Тип связи | Пояснение |
|---|----------|----------|-----------|-----------|
| 1 | department_type | department | **1 : M** | у одного типа много подразделений |
| 2 | department | employee | **1 : M** | в одном подразделении много сотрудников |
| 3 | position | employee | **1 : M** | одна должность у многих сотрудников |
| 4 | branch | employee | **1 : M** | один филиал — много сотрудников |
| 5 | employee | employee_project | **1 : M** | у сотрудника много назначений |
| 6 | project | employee_project | **1 : M** | у проекта много назначений |
| 7 | employee ↔ project | через employee_project | **M : N** | сотрудник на многих проектах, проект — со многими сотрудниками |

---

## 5. SQL-скрипт создания схемы

```sql
-- 1. Типы подразделений
CREATE TABLE department_type (
    type_id  SERIAL PRIMARY KEY,
    name     VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Подразделения
CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,
    name          VARCHAR(200) NOT NULL UNIQUE,
    type_id       INT NOT NULL,
    CONSTRAINT fk_department_type
        FOREIGN KEY (type_id) REFERENCES department_type(type_id)
);

-- 3. Филиалы
CREATE TABLE branch (
    branch_id SERIAL PRIMARY KEY,
    address   VARCHAR(300) NOT NULL UNIQUE
);

-- 4. Должности
CREATE TABLE position (
    position_id SERIAL PRIMARY KEY,
    title       VARCHAR(200) NOT NULL UNIQUE
);

-- 5. Проекты
CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    name       VARCHAR(300) NOT NULL UNIQUE
);

-- 6. Сотрудники
CREATE TABLE employee (
    employee_id   SERIAL PRIMARY KEY,
    full_name     VARCHAR(200) NOT NULL,
    salary        NUMERIC(12,2) NOT NULL CHECK (salary > 0),
    hire_date     DATE NOT NULL,
    position_id   INT NOT NULL,
    department_id INT NOT NULL,
    branch_id     INT NOT NULL,
    CONSTRAINT fk_emp_position
        FOREIGN KEY (position_id)   REFERENCES position(position_id),
    CONSTRAINT fk_emp_department
        FOREIGN KEY (department_id) REFERENCES department(department_id),
    CONSTRAINT fk_emp_branch
        FOREIGN KEY (branch_id)     REFERENCES branch(branch_id)
);

-- 7. Назначения на проекты (M:N)
CREATE TABLE employee_project (
    employee_id INT NOT NULL,
    project_id  INT NOT NULL,
    PRIMARY KEY (employee_id, project_id),
    CONSTRAINT fk_ep_employee
        FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE,
    CONSTRAINT fk_ep_project
        FOREIGN KEY (project_id)  REFERENCES project(project_id)  ON DELETE CASCADE
);

-- Индексы для частых запросов
CREATE INDEX idx_employee_department ON employee(department_id);
CREATE INDEX idx_employee_position   ON employee(position_id);
CREATE INDEX idx_employee_branch     ON employee(branch_id);
CREATE INDEX idx_ep_project          ON employee_project(project_id);
```

---

## 6. Схема модели данных

Схема построена в draw.io в нотации **IE (Crow's Foot)**. На схеме отображены:

- 7 таблиц с названиями;
- все столбцы с указанием типов данных PostgreSQL;
- первичные ключи (выделены жирным и значком 🔑);
- внешние ключи (помечены 🔗);
- связи между таблицами линиями с обозначением кратности `1` и `∞`.

### 6.1. ER-диаграмма

![ER-диаграмма базы данных](Дз%20Галицин%20Николай.drawio.png)

### 6.2. Дополнительный скриншот

![Снимок экрана](Снимок%20экрана%20от%202026-10-08%2016-45-53.png)


---

## 7. Выводы

В ходе работы исходный «плоский» отчёт был приведён к **нормализованной реляционной модели** из 7 таблиц.

**Что удалось устранить:**

- дублирование названий подразделений, должностей, адресов и проектов;
- аномалии вставки, обновления и удаления.

**Принятые проектные решения:**

- справочные данные вынесены в отдельные таблицы (`department_type`, `department`, `position`, `branch`, `project`);
- для денежных значений используется `NUMERIC(12,2)` — точность важнее экономии;
- даты хранятся в типе `DATE`, а не строкой;
- связь M:N между сотрудниками и проектами разрешена через промежуточную таблицу `employee_project` с составным первичным ключом;
- для ускорения частых соединений добавлены индексы на внешние ключи.

**Полученная модель:**

- состоит из 7 таблиц;
- находится в **третьей нормальной форме (3НФ)**;
- готова к загрузке данных из Excel и дальнейшей работе через SQL-запросы.