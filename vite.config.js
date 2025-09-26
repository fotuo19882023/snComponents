import { defineConfig } from 'vite'
import { vitepressPlugin } from 'vitepress'

export default defineConfig({
  plugins: [vitepressPlugin()],
  build: {
    outDir: 'docs', // 修改为你的目标输出目录名称
  },
})
