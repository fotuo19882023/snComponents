# SnForm 表单组件

## 组件介绍

SnForm 是一个功能强大的表单组件，专为复杂表单场景设计，支持表单项的动态配置、拖拽排序、条件筛选、预设值管理等高级功能。

## 功能特点

- **动态表单配置**：通过 JSON 配置生成表单，无需手动编写大量表单代码
- **拖拽排序**：支持表单项的拖拽排序，可自定义表单布局
- **表单项显示/隐藏**：可控制表单项的显示与隐藏
- **预设值管理**：支持保存和应用表单预设值，提高用户体验
- **条件筛选展示**：已选条件可视化展示，便于用户了解当前筛选状态
- **排序设置**：支持数据排序配置
- **自适应布局**：支持表单项的展开/收起，适应不同屏幕尺寸
- **表单校验**：集成 Element Plus 的表单校验功能
- **丰富的表单控件**：支持多种表单控件类型

## 基本用法

```vue
<template>
  <SnForm v-model="formData" :form-items="formItems" :search-render="searchRender" @search="handleSearch" />
</template>

<script setup>
import { ref, reactive } from 'vue'

const formData = ref({
  name: '',
  age: '',
  date: []
})

const formItems = [
  {
    field: 'name',
    label: '姓名',
    type: 'input',
    width: 2,
    placeholder: '请输入姓名'
  },
  {
    field: 'age',
    label: '年龄',
    type: 'inputNumber',
    width: 2,
    placeholder: '请输入年龄'
  },
  {
    field: 'date',
    label: '日期范围',
    type: 'datePicker',
    width: 4,
    attrs: {
      type: 'daterange',
      startPlaceholder: '开始日期',
      endPlaceholder: '结束日期'
    }
  }
]

const searchRender = {
  showResult: true,
  drag: true,
  collapse: true,
  dataSortable: true,
  showItem: true
}

const handleSearch = (data) => {
  console.log('搜索数据', data)
}
</script>
```

## API

### Props

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| v-model | 表单数据对象 | Object | - |
| formItems | 表单项配置数组 | Array | [] |
| searchRender | 搜索相关配置 | Object | - |
| isText | 是否以纯文本方式展示表单 | Boolean | false |
| hidePlaceholder | 是否隐藏占位符文本 | Boolean | false |
| id | 表单唯一标识，用于缓存配置 | String | - |

### searchRender 配置项

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| showResult | 是否显示已选条件 | Boolean | false |
| drag | 是否允许拖拽排序 | Boolean | false |
| collapse | 是否允许展开/收起 | Boolean | true |
| dataSortable | 是否启用数据排序功能 | Boolean | false |
| showItem | 是否显示表单项配置按钮 | Boolean | false |

### formItems 配置项

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| field | 字段名，对应表单数据对象的键名 | String | - |
| label | 标签文本 | String | - |
| type | 表单控件类型 | String | - |
| width | 表单项宽度（基于20等分栅格） | Number | 2 |
| placeholder | 占位符文本 | String | - |
| attrs | 传递给表单控件的属性 | Object | - |
| rules | 表单校验规则 | Array/Function | - |
| visible | 是否可见 | Boolean/Function | true |
| show | 是否显示 | Boolean/Function | true |
| isText | 是否以纯文本方式展示 | Boolean/Function | false |
| children | 选项数据（用于select等控件） | Array/Function | - |
| events | 事件对象 | Object | - |
| formatter | 格式化函数 | Function | - |
| showResult | 是否在已选条件中显示 | Boolean | true |
| slots | 插槽配置 | Object | - |

### 支持的表单控件类型

| 类型 | 说明 |
| --- | --- |
| input | 输入框 |
| inputNumber | 数字输入框 |
| select | 下拉选择器 |
| selectV2 | 虚拟列表选择器 |
| radio | 单选框 |
| checkbox | 复选框 |
| datePicker | 日期选择器 |
| treeSelect | 树形选择器 |
| cascader | 级联选择器 |
| snCompanySelect | 公司选择器 |
| snPersonalSelect | 人员选择器 |
| snArea | 地区选择器 |
| snPoint | 网点选择器 |
| snInputNumberPicker | 数字区间选择器 |
| selectTexterea | 多文本输入框 |
| search | 搜索按钮组（内部使用） |

### Events

| 事件名 | 说明 | 参数 |
| --- | --- | --- |
| search | 点击搜索按钮时触发 | formData |
| change | 表单值变化时触发 | { data: formData } |
| reset | 点击重置按钮时触发 | - |

### 方法

通过 ref 可以获取到 SnForm 实例并调用实例方法

| 方法名 | 说明 | 参数 |
| --- | --- | --- |
| loadFormItems | 重新加载表单项 | - |
| init | 初始化表单 | - |
| updateStatus | 更新表单状态 | - |
| getFormItemByField | 根据字段名获取表单项 | field: String |
| initDataSortableFields | 初始化排序字段列表 | arr: Array, config: Object |
| getDataSortableFields | 获取当前排序配置 | - |

## 高级功能

### 动态表单项

可以通过函数返回表单项的某些属性，实现动态表单：

```javascript
const formItems = [
  {
    field: 'type',
    label: '类型',
    type: 'select',
    children: [
      { label: '类型1', value: '1' },
      { label: '类型2', value: '2' }
    ]
  },
  {
    field: 'name',
    label: '名称',
    type: 'input',
    visible: () => {
      // 根据条件决定是否显示
      return formData.value.type === '1'
    }
  }
]
```

### 表单项联动

通过监听表单项的 change 事件实现联动：

```javascript
const formItems = [
  {
    field: 'province',
    label: '省份',
    type: 'select',
    children: provinces,
    events: {
      change: (val) => {
        // 根据省份加载城市列表
        loadCities(val)
      }
    }
  },
  {
    field: 'city',
    label: '城市',
    type: 'select',
    children: cities
  }
]
```

### 异步加载选项

通过函数形式的 children 属性实现异步加载选项：

```javascript
const formItems = [
  {
    field: 'department',
    label: '部门',
    type: 'select',
    children: async () => {
      // 异步获取部门列表
      const res = await api.getDepartments()
      return res.data
    }
  }
]
```

### 自定义表单项渲染

通过插槽自定义表单项的渲染：

```vue
<template>
  <SnForm v-model="formData" :form-items="formItems">
    <template #custom-field>
      <div>自定义内容</div>
    </template>
  </SnForm>
</template>

<script setup>
const formItems = [
  {
    field: 'custom',
    label: '自定义',
    slots: {
      default: 'custom-field'
    }
  }
]
</script>
```

### 表单缓存与持久化

SnForm 组件会自动将表单配置和值缓存到 localStorage，用户可以通过表单设置功能管理这些缓存：

- 保存表单排序
- 保存预设值
- 重置或删除缓存配置

### 日期范围选择器

日期范围选择器会自动处理开始日期和结束日期的禁用逻辑，确保用户选择有效的日期范围：

```javascript
{
  field: 'dateRange',
  label: '日期范围',
  type: 'datePicker',
  attrs: {
    type: 'daterange',
    startPlaceholder: '开始日期',
    endPlaceholder: '结束日期',
    disabledStartDate: (date) => {
      // 自定义开始日期禁用逻辑
      return date < new Date()
    },
    disabledEndDate: (date) => {
      // 自定义结束日期禁用逻辑
      return date > new Date(new Date().setDate(new Date().getDate() + 30))
    }
  }
}
```

## 注意事项

1. 表单项的 `field` 属性支持嵌套对象路径，如 `user.name`
2. 当使用日期范围选择器时，表单数据应初始化为数组 `[]`
3. 表单校验规则可以是数组或返回数组的函数
4. 使用拖拽排序功能时，需要设置 `searchRender.drag` 为 `true`
5. 表单项的宽度基于20等分的栅格系统，默认为2 