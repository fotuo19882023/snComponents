# SnSelectEnhanced - 增强版 Select 组件

基于 Element Plus 的 el-select 组件进行二次封装，继承原有组件的所有功能，并扩展了多项实用功能。

## 功能特性

- ✅ 继承 el-select 的所有原生功能
- ✅ 支持远程搜索和分页加载
- ✅ 多选模式下支持全选/反选
- ✅ 支持选项分组显示
- ✅ 支持自定义选项模板
- ✅ 支持一键复制选中内容
- ✅ 支持加载状态显示
- ✅ 支持防抖搜索
- ✅ 完整的 TypeScript 支持

## 基础用法

```vue
<template>
  <SnSelectEnhanced v-model="value" :options="options" placeholder="请选择" />
</template>

<script setup>
  import { ref } from 'vue'
  import SnSelectEnhanced from '@/components/common/SnSelectEnhanced'

  const value = ref('')
  const options = ref([
    { value: '1', label: '选项1' },
    { value: '2', label: '选项2' },
    { value: '3', label: '选项3' }
  ])
</script>
```

## 多选模式

```vue
<template>
  <SnSelectEnhanced v-model="multiValue" :options="options" multiple show-select-all select-all-label="全部选择" />
</template>

<script setup>
  const multiValue = ref([])
</script>
```

## 远程搜索

```vue
<template>
  <SnSelectEnhanced v-model="remoteValue" remote :remote-method="remoteSearch" @remote-search="handleRemoteSearch" />
</template>

<script setup>
  const remoteValue = ref('')

  const remoteSearch = async (query: string) => {
    // 模拟 API 调用
    const response = await fetch(`/api/search?q=${query}`)
    return response.json()
  }

  const handleRemoteSearch = (query: string) => {
    console.log('搜索关键词:', query)
  }
</script>
```

## 分页加载

```vue
<template>
  <SnSelectEnhanced
    v-model="pageValue"
    :options="largeOptions"
    pagination
    :page-size="20"
    load-more-text="点击加载更多"
    @load-more="handleLoadMore"
  />
</template>

<script setup>
  const pageValue = ref('')
  const largeOptions = ref([]) // 大量数据

  const handleLoadMore = () => {
    console.log('加载更多数据')
  }
</script>
```

## 选项分组

```vue
<template>
  <SnSelectEnhanced v-model="groupValue" :options="groupedOptions" group-key="category" />
</template>

<script setup>
  const groupValue = ref('')
  const groupedOptions = ref([
    { value: '1', label: '苹果', category: '水果' },
    { value: '2', label: '香蕉', category: '水果' },
    { value: '3', label: '胡萝卜', category: '蔬菜' },
    { value: '4', label: '白菜', category: '蔬菜' }
  ])
</script>
```

## 自定义选项模板

```vue
<template>
  <SnSelectEnhanced v-model="customValue" :options="userOptions">
    <template #option="{ option }">
      <div class="custom-option">
        <img :src="option.avatar" class="avatar" />
        <div class="info">
          <div class="name">{{ option.name }}</div>
          <div class="email">{{ option.email }}</div>
        </div>
      </div>
    </template>
  </SnSelectEnhanced>
</template>

<script setup>
  const customValue = ref('')
  const userOptions = ref([
    {
      value: '1',
      label: '张三',
      name: '张三',
      email: 'zhangsan@example.com',
      avatar: '/avatars/zhangsan.jpg'
    }
  ])
</script>

<style scoped>
  .custom-option {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .avatar {
    width: 24px;
    height: 24px;
    border-radius: 50%;
  }

  .info {
    flex: 1;
  }

  .name {
    font-weight: 500;
  }

  .email {
    font-size: 12px;
    color: #999;
  }
</style>
```

## 复制功能

```vue
<template>
  <SnSelectEnhanced v-model="copyValue" :options="options" copyable />
</template>
```

## Props

| 参数           | 说明                   | 类型                                         | 默认值       |
| -------------- | ---------------------- | -------------------------------------------- | ------------ |
| options        | 选项数据               | `SelectOption[]`                             | `[]`         |
| valueKey       | 选项值的字段名         | `string`                                     | `'value'`    |
| labelKey       | 选项标签的字段名       | `string`                                     | `'label'`    |
| disabledKey    | 选项禁用状态的字段名   | `string`                                     | `'disabled'` |
| groupKey       | 选项分组的字段名       | `string`                                     | `'group'`    |
| multiple       | 是否多选               | `boolean`                                    | `false`      |
| showSelectAll  | 多选时是否显示全选选项 | `boolean`                                    | `false`      |
| copyable       | 是否显示复制按钮       | `boolean`                                    | `false`      |
| remote         | 是否远程搜索           | `boolean`                                    | `false`      |
| pagination     | 是否启用分页           | `boolean`                                    | `false`      |
| selectAllLabel | 全选选项的文本         | `string`                                     | `'全选'`     |
| noDataText     | 无数据时的提示文本     | `string`                                     | `'暂无数据'` |
| loadMoreText   | 加载更多按钮的文本     | `string`                                     | `'加载更多'` |
| remoteMethod   | 远程搜索方法           | `(query: string) => Promise<SelectOption[]>` | -            |
| pageSize       | 分页大小               | `number`                                     | `20`         |
| debounceDelay  | 搜索防抖延迟（毫秒）   | `number`                                     | `300`        |

## Events

| 事件名         | 说明                                     | 参数                  |
| -------------- | ---------------------------------------- | --------------------- |
| change         | 选中值发生变化时触发                     | `(value: any)`        |
| visible-change | 下拉框出现/隐藏时触发                    | `(visible: boolean)`  |
| clear          | 可清空的单选模式下用户点击清空按钮时触发 | -                     |
| focus          | 当 input 获得焦点时触发                  | `(event: FocusEvent)` |
| blur           | 当 input 失去焦点时触发                  | `(event: FocusEvent)` |
| remote-search  | 远程搜索时触发                           | `(query: string)`     |
| load-more      | 点击加载更多时触发                       | -                     |

## Slots

| 插槽名 | 说明           | 参数                                      |
| ------ | -------------- | ----------------------------------------- |
| option | 自定义选项内容 | `{ option: SelectOption, index: number }` |

## Methods

| 方法名  | 说明              | 参数 |
| ------- | ----------------- | ---- |
| focus   | 使 input 获取焦点 | -    |
| blur    | 使 input 失去焦点 | -    |
| refresh | 刷新远程数据      | -    |

## 类型定义

```typescript
interface SelectOption {
  [key: string]: any
}

interface SelectGroup {
  label: string
  options: SelectOption[]
}
```
