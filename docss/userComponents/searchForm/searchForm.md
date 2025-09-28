# SnSearchForm 搜索表单组件

## 组件介绍

SnSearchForm 是一个基于 Element Plus 的高级搜索表单组件，用于构建灵活的数据筛选界面。该组件支持多种表单控件类型，包括文本输入框、数字输入框、下拉选择器、日期选择器等，并且支持展开/收起高级搜索选项功能。

## 功能特点

- 支持多种表单控件类型
- 支持基础搜索和高级搜索模式
- 提供搜索、重置功能
- 支持表单校验
- 自适应布局，可配置表单项宽度
- 支持自定义表单控件

## 参数配置

### Props

| 参数名 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| fieldList | 基础搜索项配置 | Array | [] |
| advancedFieldList | 高级搜索项配置 | Array | [] |
| formData | 表单数据对象 | Object | {} |
| rules | 表单校验规则 | Object | {} |
| isMoreSeach | 是否启用高级搜索功能 | Boolean | false |

### 表单项配置参数

每个表单项（fieldList 和 advancedFieldList 中的元素）支持以下配置：

| 参数名 | 说明 | 类型 | 是否必填 |
| --- | --- | --- | --- |
| label | 表单项标签 | String | 是 |
| field | 表单项字段名 | String | 是 |
| type | 表单项类型 | String | 是 |
| placeholder | 占位文本 | String | 否 |
| width | 表单项宽度（栅格跨度） | Number | 否，默认为3 |
| children | 下拉选项数据（用于select/selectV2/treeSelect类型） | Array | 否 |
| isDict | 是否为字典数据 | Boolean | 否 |
| otherOptions | 其他配置项，会通过v-bind传递给表单控件 | Object | 否 |
| isSnCustomControl | 是否为自定义控件 | Boolean | 否 |
| isPrepend | 是否使用前置内容（仅用于text类型） | Boolean | 否 |
| prependOptions | 前置选择器配置（当isPrepend为true时使用） | Object | 否 |
| fieldArr | 自定义日期区间的字段数组（用于customDaterange类型） | Array | 否 |
| options | 单选/复选框选项（用于radio/checkbox类型） | Array | 否 |
| bindKey | 下拉选择器的值绑定键名（用于selectV2类型） | String | 否，默认为'sn' |
| defaultProps | 树形选择器配置（用于treeSelect类型） | Object | 否 |

### 支持的表单控件类型

- `text`: 文本输入框
- `number`: 数字输入框
- `password`: 密码输入框
- `textarea`: 文本域
- `select`: 下拉选择器
- `selectV2`: 虚拟下拉选择器（适用于大数据量）
- `treeSelect`: 树形下拉选择器
- `selectTexterea`: 自定义文本选择器
- `radio`: 单选框组
- `checkbox`: 复选框组
- `date`: 日期选择器
- `datetime`: 日期时间选择器
- `daterange`: 日期范围选择器
- `customDaterange`: 自定义日期区间选择器

### 事件

| 事件名 | 说明 | 回调参数 |
| --- | --- | --- |
| handleSearch | 点击搜索按钮时触发 | form: 表单数据对象 |
| handleReset | 点击重置按钮时触发 | - |
| handleSelectChange | 下拉框选值变化时触发 | (val, item): 选中值和表单项配置 |
| formDataInit | 重置表单时触发 | callback: 用于更新表单数据的回调函数 |

### 暴露的方法

| 方法名 | 说明 | 参数 |
| --- | --- | --- |
| handleReset | 重置表单 | - |

## 使用示例

### 基础用法

```vue
<template>
  <SnSearchForm
    :fieldList="searchFields"
    :formData="searchForm"
    :rules="rules"
    @handleSearch="onSearch"
    @handleReset="onReset"
    @handleSelectChange="onSelectChange"
    @formDataInit="onFormDataInit"
  />
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue'
import SnSearchForm from '@/components/common/SnSearchForm/SnSearchForm.vue'
import { FormFieldConfig } from '@/components/common/SnSearchForm'

// 搜索表单数据
const searchForm = reactive({
  name: '',
  status: '',
  createTime: ''
})

// 搜索字段配置
const searchFields: FormFieldConfig[] = [
  {
    label: '名称',
    field: 'name',
    type: 'text',
    placeholder: '请输入名称'
  },
  {
    label: '状态',
    field: 'status',
    type: 'select',
    placeholder: '请选择状态',
    isDict: true,
    children: [
      { label: '启用', value: '1' },
      { label: '禁用', value: '0' }
    ]
  },
  {
    label: '创建时间',
    field: 'createTime',
    type: 'date',
    placeholder: '请选择创建时间'
  }
]

// 表单校验规则
const rules = {
  name: [{ required: true, message: '请输入名称', trigger: 'blur' }]
}

// 搜索事件处理
const onSearch = (formData: Record<string, any>) => {
  console.log('搜索数据:', formData)
  // 执行搜索逻辑
}

// 重置事件处理
const onReset = () => {
  console.log('表单已重置')
}

// 下拉框选择变化事件
const onSelectChange = (val: unknown, item: FormFieldConfig) => {
  console.log('选中值:', val)
  console.log('表单项配置:', item)
}

// 表单数据初始化
const onFormDataInit = (callback: (data: Record<string, any>) => void) => {
  // 可以在这里设置表单的初始值
  const initialValues = {
    name: '',
    status: '',
    createTime: ''
  }
  callback(initialValues)
}
</script>
```

### 高级搜索示例

```vue
<template>
  <SnSearchForm
    :fieldList="baseSearchFields"
    :advancedFieldList="advancedSearchFields"
    :formData="searchForm"
    :isMoreSeach="true"
    @handleSearch="onSearch"
    @handleReset="onReset"
  />
</template>

<script setup lang="ts">
import { reactive } from 'vue'
import SnSearchForm from '@/components/common/SnSearchForm/SnSearchForm.vue'
import { FormFieldConfig } from '@/components/common/SnSearchForm'

// 搜索表单数据
const searchForm = reactive({
  code: '',
  name: '',
  status: '',
  type: '',
  startDate: '',
  endDate: '',
  remark: ''
})

// 基础搜索字段配置
const baseSearchFields: FormFieldConfig[] = [
  {
    label: '编码',
    field: 'code',
    type: 'text',
    placeholder: '请输入编码'
  },
  {
    label: '名称',
    field: 'name',
    type: 'text',
    placeholder: '请输入名称'
  },
  {
    label: '状态',
    field: 'status',
    type: 'select',
    placeholder: '请选择状态',
    isDict: true,
    children: [
      { label: '启用', value: '1' },
      { label: '禁用', value: '0' }
    ]
  }
]

// 高级搜索字段配置
const advancedSearchFields: FormFieldConfig[] = [
  {
    label: '类型',
    field: 'type',
    type: 'select',
    placeholder: '请选择类型',
    isDict: true,
    children: [
      { label: '类型A', value: 'A' },
      { label: '类型B', value: 'B' },
      { label: '类型C', value: 'C' }
    ]
  },
  {
    label: '日期区间',
    type: 'customDaterange',
    isSnCustomControl: true,
    fieldArr: ['startDate', 'endDate'],
    placeholder: '选择'
  },
  {
    label: '备注',
    field: 'remark',
    type: 'textarea',
    placeholder: '请输入备注'
  }
]

// 搜索事件处理
const onSearch = (formData: Record<string, any>) => {
  console.log('搜索数据:', formData)
  // 执行搜索逻辑
}

// 重置事件处理
const onReset = () => {
  console.log('表单已重置')
}
</script>
```

### 带前置选择器的输入框

```vue
<template>
  <SnSearchForm
    :fieldList="searchFields"
    :formData="searchForm"
    @handleSearch="onSearch"
  />
</template>

<script setup lang="ts">
import { reactive } from 'vue'
import SnSearchForm from '@/components/common/SnSearchForm/SnSearchForm.vue'
import { FormFieldConfig } from '@/components/common/SnSearchForm'

// 搜索表单数据
const searchForm = reactive({
  searchType: 'name',
  searchValue: ''
})

// 搜索字段配置
const searchFields: FormFieldConfig[] = [
  {
    label: '搜索条件',
    field: 'searchValue',
    type: 'text',
    placeholder: '请输入搜索内容',
    isPrepend: true,
    prependOptions: {
      prependField: 'searchType',
      prependList: [
        { label: '名称', value: 'name' },
        { label: '编码', value: 'code' },
        { label: '描述', value: 'description' }
      ]
    }
  }
]

// 搜索事件处理
const onSearch = (formData: Record<string, any>) => {
  console.log('搜索数据:', formData)
  // 执行搜索逻辑
}
</script>
```

## 项目中的实际应用示例

以下是项目中使用SnSearchForm组件的实际示例：

### 进口管理模块 - 商务平台

在进口管理模块的商务平台页面中使用了SnForm组件（SnForm是基于SnSearchForm的封装）：

```vue
<template>
  <PageContainer class="businessPlatformList">
    <PageHeader>
      <SnForm
        id="snBusinessPlatformSnFormId"
        ref="searchFormRef"
        v-model="formData"
        :form-items="fieldList"
        :search-render="{
          showResult: true,
          drag: true,
          dataSortable: true
        }"
        @search="handleSearchForm"
      />
    </PageHeader>
    
    <PageMain>
      <!-- 表格内容 -->
    </PageMain>
  </PageContainer>
</template>

<script lang="ts" setup>
  import { ref, reactive } from 'vue'
  import { useDictionaryHook, useSortableFieldsHook } from '@/hooks'
  
  // 搜索表单配置
  const fieldList = ref([
    {
      label: '订单号',
      field: 'orderNo',
      type: 'text',
      placeholder: '请输入订单号'
    },
    {
      label: '状态',
      field: 'state',
      type: 'select',
      placeholder: '请选择订单状态',
      isDict: true,
      children: [] // 从字典获取
    },
    {
      label: '创建日期',
      type: 'customDaterange',
      isSnCustomControl: true,
      fieldArr: ['startCreateAt', 'endCreateAt'],
      placeholder: '创建日期'
    },
    {
      label: '报关单号',
      field: 'reportNo',
      type: 'text',
      placeholder: '请输入报关单号'
    }
    // 更多搜索字段...
  ])
  
  // 搜索表单数据
  const formData = reactive({
    orderNo: '',
    state: '',
    startCreateAt: '',
    endCreateAt: '',
    reportNo: ''
    // 更多表单数据...
  })
  
  // 搜索处理函数
  const handleSearchForm = (params) => {
    // 处理搜索参数
    const searchParams = {
      ...params,
      // 其他参数处理...
    }
    // 调用API获取数据
    getTableData(searchParams)
  }
  
  // 获取表格数据
  const getTableData = async (params) => {
    // API调用逻辑...
  }
</script>
```

### 表单项动态加载数据示例

在实际应用中，表单项的选项数据通常需要从API动态获取：

```typescript
// 进口类别下拉选项动态加载
const getImportpCategoryTree = async () => {
  const params = {
    dataSource: 0 // 数据来源(0:初始化导入，1自建数据）
  }
  const res = await getImportpCategoryTreeApi(params)
  if (res) {
    fieldList.value.map((item: any) => {
      if (item.field === 'instImportCategorySn') {
        item.children = res
      }
    })
  }
}

// 组件挂载时调用
onMounted(() => {
  getImportpCategoryTree()
  // 其他初始化...
})
```

### 搜索表单与表格联动

SnSearchForm组件通常与表格组件（如SnVxeGrid）配合使用，实现搜索-展示的数据流：

```typescript
// 搜索处理
const handleSearchForm = (params) => {
  // 保存搜索条件
  Object.assign(data.searchParams, params)
  // 重置分页
  data.current = 1
  // 获取表格数据
  getTableData()
}

// 获取表格数据
const getTableData = async () => {
  const params = {
    ...data.searchParams,
    current: data.current,
    rows: data.rows
  }
  
  try {
    const res = await getTableDataApi(params)
    if (res) {
      // 更新表格数据
      data.tableData = res.records || []
      data.total = res.total || 0
    }
  } catch (error) {
    console.error(error)
  }
}

// 分页处理
const handleSizeChange = (val: number) => {
  data.rows = val
  getTableData()
}

const handleCurrentChange = (val: number) => {
  data.current = val
  getTableData()
}
```

## 注意事项

1. 表单项的 `field` 属性必须与 `formData` 中的字段名保持一致
2. 使用 `isMoreSeach` 开启高级搜索功能时，需要同时提供 `advancedFieldList` 配置
3. 自定义控件需要设置 `isSnCustomControl: true`
4. 重置表单时，需要在 `formDataInit` 事件中设置表单初始值
5. 表单校验规则格式需要符合 Element Plus 的 Form 组件规则

## TypeScript支持

为了更好地使用TypeScript，组件提供了完整的类型定义。在使用组件时，请引入相关类型：

```typescript
import SnSearchForm, { FormFieldConfig } from '@/components/common/SnSearchForm'

// 使用类型定义表单字段配置
const searchFields: FormFieldConfig[] = [
  // 表单项配置...
]
```

### 已解决的TypeScript问题

组件中存在以下TypeScript类型问题，已通过类型定义文件解决：

1. 表单项配置的类型定义
2. 组件Props的类型定义
3. 事件回调参数的类型定义

### 如果遇到类型错误

如果在使用过程中遇到TypeScript类型错误，可以尝试以下解决方案：

1. 确保正确导入类型定义：
   ```typescript
   import { FormFieldConfig } from '@/components/common/SnSearchForm'
   ```

2. 为表单数据和事件处理函数添加正确的类型注解：
   ```typescript
   const searchForm: Record<string, any> = reactive({...})
   
   const onSearch = (formData: Record<string, any>) => {...}
   ```

3. 如果使用自定义控件，确保正确设置`isSnCustomControl: true`属性

## 样式定制

组件内部已经设置了基础样式，确保表单项布局合理。如需自定义样式，可以通过覆盖以下类名：

- `.form-search`: 整个搜索表单容器
- `.form-search-container`: 搜索表单内容容器
- `.searchForm`: 表单元素
- `.df-CustomIntervalSearch`: 自定义日期区间搜索组件
