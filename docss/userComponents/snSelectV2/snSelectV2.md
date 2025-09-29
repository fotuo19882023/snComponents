# SnSelectV2 组件

`SnSelectV2` 是基于 Element Plus 的 `el-select-v2` 组件进行二次封装的高级选择器组件，增强了原生组件的功能，并提供了更好的用户体验。

## 功能特点

- 支持单选和多选模式
- 内置复制功能，可以快速复制选中的值
- 集成 Tooltip 提示，显示完整的选中内容
- 完全兼容 Element Plus 的 `el-select-v2` 组件的所有功能和属性
- 支持自定义插槽透传

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
| ------ | ---- | ------ | ---- |
| options | Array | [] | 选项数据源，格式为包含 `label` 和 `value` 的对象数组 |
| copyable | Boolean | true | 是否启用复制功能 |
| tooltipConfig | Object | {} | Tooltip 组件的配置项，支持 Element Plus 的 Tooltip 所有属性 |
| tooltipPlacement | String | 'top' | Tooltip 的显示位置，可选值：'top', 'bottom', 'left', 'right' |
| tooltipEffect | String | 'light' | Tooltip 的主题，可选值：'dark', 'light' |
| copyTooltip | String | '复制' | 复制按钮的提示文本 |
| copySuccessMessage | String | '复制成功' | 复制成功时的提示消息 |
| copyErrorMessage | String | '复制失败' | 复制失败时的提示消息 |

## 事件

| 事件名 | 参数 | 描述 |
| ------ | ---- | ---- |
| change | value | 选中值发生变化时触发 |
| visible-change | visible | 下拉框出现/隐藏时触发 |
| clear | - | 点击清除按钮时触发 |
| blur | event | 当组件失去焦点时触发 |
| focus | event | 当组件获得焦点时触发 |

## 插槽

组件支持透传 `el-select-v2` 的所有插槽，包括但不限于：

- `default`: 自定义选项的内容
- `prefix`: 组件头部内容
- `empty`: 无选项时的列表内容

## 方法

通过 `ref` 可以调用组件内部方法：

| 方法名 | 参数 | 描述 |
| ------ | ---- | ---- |
| focus | - | 使选择器获取焦点 |
| blur | - | 使选择器失去焦点 |
| getSelectRef | - | 获取内部 `el-select-v2` 的引用 |

## 基本使用示例

```vue
<template>
  <SnSelectV2
    v-model="selectedValue"
    :options="options"
    placeholder="请选择选项"
    style="width: 300px"
  />
</template>

<script setup>
import { ref } from 'vue'

const selectedValue = ref('')
const options = ref([
  { value: '1', label: '选项1' },
  { value: '2', label: '选项2' },
  { value: '3', label: '选项3' }
])
</script>
```

## 多选模式示例

```vue
<template>
  <SnSelectV2
    v-model="selectedValues"
    :options="options"
    multiple
    collapse-tags
    placeholder="请选择多个选项"
    style="width: 300px"
  />
</template>

<script setup>
import { ref } from 'vue'

const selectedValues = ref([])
const options = ref([
  { value: '1', label: '选项1' },
  { value: '2', label: '选项2' },
  { value: '3', label: '选项3' },
  { value: '4', label: '选项4' },
  { value: '5', label: '选项5' }
])
</script>
```

## 禁用复制功能示例

```vue
<template>
  <SnSelectV2
    v-model="selectedValue"
    :options="options"
    :copyable="false"
    placeholder="禁用复制功能"
    style="width: 300px"
  />
</template>

<script setup>
import { ref } from 'vue'

const selectedValue = ref('')
const options = ref([
  { value: '1', label: '选项1' },
  { value: '2', label: '选项2' },
  { value: '3', label: '选项3' }
])
</script>
```

## 自定义 Tooltip 配置示例

```vue
<template>
  <SnSelectV2
    v-model="selectedValue"
    :options="options"
    tooltipPlacement="bottom"
    tooltipEffect="dark"
    :tooltipConfig="{ offset: 10, showAfter: 500 }"
    placeholder="自定义Tooltip"
    style="width: 300px"
  />
</template>

<script setup>
import { ref } from 'vue'

const selectedValue = ref('')
const options = ref([
  { value: '1', label: '这是一个很长的选项，可能会被截断显示' },
  { value: '2', label: '另一个很长的选项，Tooltip会显示完整内容' },
  { value: '3', label: '第三个选项' }
])
</script>
```

## 使用自定义插槽示例

```vue
<template>
  <SnSelectV2
    v-model="selectedValue"
    :options="options"
    placeholder="自定义选项内容"
    style="width: 300px"
  >
    <template #default="{ item }">
      <div style="display: flex; align-items: center;">
        <el-icon><Star /></el-icon>
        <span style="margin-left: 8px">{{ item.label }}</span>
      </div>
    </template>
  </SnSelectV2>
</template>

<script setup>
import { ref } from 'vue'
import { Star } from '@element-plus/icons-vue'

const selectedValue = ref('')
const options = ref([
  { value: '1', label: '选项1' },
  { value: '2', label: '选项2' },
  { value: '3', label: '选项3' }
])
</script>
```

## 注意事项

1. 组件内部已经设置了一些默认属性，如 `filterable: true`, `clearable: true`，可以通过传递相应的 prop 来覆盖这些默认值。

2. 复制功能只在鼠标悬停在组件上时显示复制图标，并且只有在有选中值时才会显示。

3. 当使用多选模式时，复制功能会复制所有选中项的标签，以逗号分隔。

4. 组件内部对样式做了适配，在多选模式或有清除按钮时会自动调整复制图标的位置。

5. 组件使用 Vue 3 的 `defineModel` API，确保在 Vue 3.4+ 版本中使用。

## 与 Element Plus 的 el-select-v2 的区别

1. 增加了复制功能，方便用户复制选中的值
2. 内置了 Tooltip 提示，可以显示完整的选中内容
3. 设置了更合理的默认值，如默认可筛选、可清空
4. 优化了样式，特别是在多选和有清除按钮时的样式处理
5. 完全兼容原 `el-select-v2` 的所有功能和属性 
