# SnVxeGrid 组件使用文档

## 简介

SnVxeGrid 是一个基于 vxe-table 封装的高级表格组件，提供了丰富的功能和易用的接口。它支持列拖拽、列宽调整、列显示/隐藏、数据导出、高级筛选等功能，并且能够保存用户的表格配置。

## 功能特点

- **列操作**：支持列拖拽排序、列宽调整、列显示/隐藏
- **数据导出**：支持导出当前数据或全量数据，支持高级导出配置
- **自适应高度**：支持表格高度自适应
- **行高亮**：支持行点击高亮，支持合并行高亮
- **用户配置持久化**：自动保存用户的表格配置（列顺序、列宽等）
- **自定义列类型**：支持自定义列数据类型配置
- **工具栏**：内置工具栏，支持自定义按钮

## 安装依赖

SnVxeGrid 组件依赖于以下库：

```bash
npm install vxe-table xe-utils sortablejs bignumber.js lodash
```

## 基本用法
```vue
<template>
  <SnVxeGrid
    id="unique-table-id"
    :columns="columns"
    :data="tableData"
    :isFullPage="true"
  >
    <!-- 自定义工具栏按钮 -->
    <template #toolbar_buttons>
      <el-button type="primary" @click="handleAdd">新增</el-button>
    </template>
    
    <!-- 自定义列插槽 -->
    <template #operate="{ row }">
      <el-button type="text" @click="handleEdit(row)">编辑</el-button>
      <el-button type="text" @click="handleDelete(row)">删除</el-button>
    </template>
  </SnVxeGrid>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import SnVxeGrid from '@/components/common/SnVxeGrid/SnVxeGrid.vue'

const columns = [
  { field: 'name', title: '姓名', width: 100 },
  { field: 'age', title: '年龄', width: 80 },
  { field: 'address', title: '地址', minWidth: 200 },
  { field: 'operate', title: '操作', width: 150, slots: { default: 'operate' } }
]

const tableData = ref([
  { id: 1, name: '张三', age: 25, address: '北京市朝阳区' },
  { id: 2, name: '李四', age: 30, address: '上海市浦东新区' }
])

const handleAdd = () => {
  // 添加逻辑
}

const handleEdit = (row) => {
  // 编辑逻辑
}

const handleDelete = (row) => {
  // 删除逻辑
}
</script>
```

## 属性 (Props)

| 属性名 | 类型 | 默认值 | 说明 |
|--------|------|--------|------|
| gridOptions | Object | {} | 表格配置项，继承 vxe-table 的 GridOptions |
| fieldTypeConfig | Object | {} | 自定义列数据类型配置 |
| hideFieldList | Array | [] | 不需要展示的列属性名配置 |
| isFullPage | Boolean | false | 是否启用表格高度自适应（需要在 PageContainer 组件内使用） |

除了以上特定属性外，组件还支持所有 vxe-grid 的属性，如 `columns`、`data`、`border` 等。


### gridOptions 配置示例

```js
const gridOptions = {
  border: true,
  showOverflow: true,
  height: 500,
  columnConfig: {
    resizable: true
  },
  rowConfig: {
    isHover: true
  }
}
```

## 事件 (Events)

| 事件名 | 参数 | 说明 |
|--------|------|------|
| export | { file } | 导出完成后触发，返回导出的文件对象 |

此外，组件还支持所有 vxe-grid 的事件。

## 方法 (Methods)

通过 ref 引用可以调用组件的以下方法：

| 方法名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| exportTableData | (data, config?: ExportConfig) | Promise | 导出表格数据 |
| exportFlow | (callBackFun: Function, config?: ExportConfig) | void | 打开导出流程选择框 |
| getCurrentRecord | () | Object | 获取当前高亮的行数据及其索引 |
| advancedExport | (config?: ExportConfig) | void | 打开高级导出配置框 |
| getExportCacheConfig | () | Object | 获取导出缓存配置信息 |

### 导出配置 (ExportConfig) 参数说明

```typescript
interface ExportConfig {
  excelName?: string; // 导出文件名称
  mergeFields?: Record<string, string[]>; // 需要合并的字段列表，例如：{[field]:['field1','field2',...]}
  headers?: any[]; // 导出列表头，不传默认导出当前表格所见列
  decimalPlacesConfig?: Record<string, number>; // 数字类型字段列表，用于格式化，例如：{[field]:decimalPlacesNumber}
  styles?: Record<string, any>; // 字段样式配置
  wrapText?: boolean; // 是否禁止文本换行
  textNoWrapFields?: string[]; // 不包含换行符字段列表
  page?: {
    total: number; // 查询到的全量数据条数
  };
}
```

### 导出表格数据示例

```js
// 基本导出
const handleExport = async () => {
  const tableRef = ref<InstanceType<typeof SnVxeGrid>>()
  const file = await tableRef.value.exportTableData(tableData.value, {
    excelName: '用户数据'
  })
}

// 高级导出
const handleAdvancedExport = () => {
  tableRef.value.advancedExport({
    excelName: '用户数据'
  })
}

// 导出流程选择框
const handleExportFlow = () => {
  tableRef.value.exportFlow(
    async (isExportAll) => {
      if (isExportAll) {
        // 导出全量数据
        const allData = await fetchAllData()
        return allData
      } else {
        // 导出当前数据
        return tableData.value
      }
    },
    {
      excelName: '用户数据',
      page: {
        total: 1000 // 全量数据条数
      }
    }
  )
}
```

## 插槽 (Slots)

组件支持所有 vxe-grid 的插槽，并额外提供以下插槽：

| 插槽名 | 说明 |
|--------|------|
| toolbar_buttons | 工具栏按钮区域 |

## 列配置 (Columns)

列配置继承 vxe-table 的列配置，常用属性如下：

| 属性名 | 类型 | 默认值 | 说明 |
|--------|------|--------|------|
| field | String | - | 列字段名 |
| title | String | - | 列标题 |
| width | Number | - | 列宽度 |
| minWidth | Number | - | 列最小宽度 |
| visible | Boolean | true | 列是否可见 |
| fixed | String | - | 列固定方向，可选值：'left'、'right' |
| sortable | Boolean | false | 是否允许排序 |
| filters | Array | - | 筛选配置 |
| formatter | Function | - | 格式化函数 |
| slots | Object | - | 插槽配置 |

### 列配置示例

```js
const columns = [
  { type: 'checkbox', width: 60 },
  { type: 'seq', title: '序号', width: 60 },
  { field: 'name', title: '姓名', width: 100 },
  {
    field: 'status',
    title: '状态',
    width: 100,
    formatter: ({ cellValue }) => {
      return cellValue === 1 ? '启用' : '禁用'
    }
  },
  {
    field: 'operate',
    title: '操作',
    width: 150,
    slots: { default: 'operate' }
  }
]
```

## 高级功能

### 1. 列拖拽排序

组件内置了列拖拽排序功能，用户可以通过拖拽列头来调整列的顺序，并且会自动保存用户的配置。

### 2. 表格高度自适应

通过设置 `isFullPage` 属性为 `true`，可以启用表格高度自适应功能，表格会自动调整高度以适应页面容器。

```vue
<SnVxeGrid :isFullPage="true" />
```

注意：使用此功能时，SnVxeGrid 组件必须放在 PageContainer 组件内。

### 3. 用户配置持久化

组件会自动保存用户的表格配置（列顺序、列宽、列显示/隐藏状态等），并在下次打开页面时自动恢复。

### 4. 高级导出

组件提供了多种导出方式：

- 基本导出：导出当前表格数据
- 高级导出：支持自定义导出列、样式等
- 导出流程选择：支持选择导出当前数据或全量数据

### 5. 行高亮

组件支持行点击高亮，并且对于合并行，会自动高亮整个合并区域。

## 注意事项

1. 使用 `isFullPage` 属性时，SnVxeGrid 组件必须放在 PageContainer 组件内。
2. 导出功能依赖 `@/utils/exportExcel/exportExcel` 模块。
3. 列的 `field` 属性支持多级路径，如 `'user.address.city'`。

## 完整示例

```vue
<template>
  <div>
    <SnVxeGrid
      ref="tableRef"
      id="user-table"
      :columns="columns"
      :data="tableData"
      :isFullPage="true"
      :loading="loading"
      @cell-click="handleCellClick"
    >
      <template #toolbar_buttons>
        <el-button type="primary" @click="handleAdd">新增</el-button>
        <el-button @click="handleExport">导出</el-button>
        <el-button @click="handleAdvancedExport">高级导出</el-button>
      </template>
      
      <template #status="{ row }">
        <el-tag :type="row.status === 1 ? 'success' : 'danger'">
          {{ row.status === 1 ? '启用' : '禁用' }}
        </el-tag>
      </template>
      
      <template #operate="{ row }">
        <el-button type="text" @click="handleEdit(row)">编辑</el-button>
        <el-button type="text" @click="handleDelete(row)">删除</el-button>
      </template>
    </SnVxeGrid>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue'
import SnVxeGrid from '@/components/common/SnVxeGrid/SnVxeGrid.vue'
import { getUserList } from '@/api/user'

const tableRef = ref()
const loading = ref(false)
const tableData = ref([])

const columns = [
  { type: 'checkbox', width: 60 },
  { type: 'seq', title: '序号', width: 60 },
  { field: 'name', title: '姓名', width: 100 },
  { field: 'age', title: '年龄', width: 80 },
  { field: 'gender', title: '性别', width: 80 },
  { field: 'address', title: '地址', minWidth: 200 },
  { field: 'status', title: '状态', width: 100, slots: { default: 'status' } },
  { field: 'operate', title: '操作', width: 150, fixed: 'right', slots: { default: 'operate' } }
]

onMounted(async () => {
  await fetchData()
})

const fetchData = async () => {
  loading.value = true
  try {
    const res = await getUserList()
    tableData.value = res.data
  } finally {
    loading.value = false
  }
}

const handleCellClick = ({ row }) => {
  console.log('点击了行:', row)
}

const handleAdd = () => {
  // 添加逻辑
}

const handleEdit = (row) => {
  // 编辑逻辑
}

const handleDelete = (row) => {
  // 删除逻辑
}

const handleExport = async () => {
  await tableRef.value.exportTableData(tableData.value, {
    excelName: '用户数据'
  })
}

const handleAdvancedExport = () => {
  tableRef.value.advancedExport({
    excelName: '用户数据'
  })
}
</script>
```

## 常见问题

### 1. 表格高度自适应不生效

检查是否设置了 `isFullPage` 属性为 `true`，并且 SnVxeGrid 组件是否放在 PageContainer 组件内。

### 2. 列拖拽排序不生效

列拖拽排序功能在组件内部已经实现，无需额外配置。如果不生效，可能是因为列设置了 `fixed` 属性，固定列不允许拖动。

### 3. 导出数据格式不正确

检查是否正确配置了 `ExportConfig` 参数，特别是 `decimalPlacesConfig` 和 `styles` 属性。

### 4. 如何清除用户配置

可以调用组件的 `handleResetColumns` 方法清除用户配置：

```js
tableRef.value.table.value.handleResetColumns()
```

## API 参考

更多 API 请参考 [vxe-table 官方文档](https://vxetable.cn/)。 
