# Nautilus Trader 全栈评估与行情看板项目

本项目为湖北辰千空间科技有限公司 Web 全栈工程师（48小时卷）的技术评估实现。本项目已完成本地高性能交易环境的编译搭建，并规划了全栈实时行情看板的架构方案。

## 1. 项目进度与成果
- ✅ **底层环境搭建**: 已在 Windows 11 (MSVC) 环境下成功完成 Nautilus Trader 的核心 C/Rust 混合编译。
- ⏳ **行情看板开发**: 架构设计已定型，前端与数据适配层接口已规划，即将进入编码实现阶段。
- 🔍 **开源贡献准备**: 已锁定 Issue #3946 并完成核心逻辑链路的源码分析。

## 2. 架构设计方案 (Proposed Architecture)

本系统采用前后端解耦架构，旨在平衡高频交易数据的低延迟处理与 Web 端的可视化交互。

### 2.1 技术选型
- **后端**: FastAPI (Python) - 异步处理行情数据流。
- **前端**: Vue 3 + TailwindCSS - 构建响应式用户界面。
- **图表渲染**: Lightweight Charts - 针对高频数据优化的 Canvas 绘图库。

### 2.2 数据流转方案
1. **行情捕获**: 利用 Nautilus Trader 的 `on_bar` 回调，将行情数据通过异步 HTTP 推送至后端。
2. **实时分发**: 后端通过 WebSocket 实时广播至前端 Web 页面。
3. **渲染优化**: 前端使用增量数据更新策略（`series.update`），避免频繁重绘导致的性能损耗。

## 3. 运行指南

### 3.1 环境准备
- Python 3.12 (Conda 环境 `nautilus_312`)
- 确保已成功编译源码：`python -m pip install -y --editable .`

### 3.2 启动步骤
- **启动后端**: `cd backend && uvicorn main:app --reload`
- **启动前端**: `cd frontend && npm run dev`

## 4. 社区贡献路径 (Issue #3946: Support batch modify for orders)

针对批量订单修改功能，我的解决思路为：
1. **策略扩展**: 在 `Strategy` 层提供批量修改接口，整合 `OrderModifyRequest` 请求队列。
2. **执行引擎重构**: 在 `ExecutionEngine` 实现批量处理逻辑，减少 `MessageBus` 的调度压力。
3. **适配层实现**: 封装交易所批量 API 调用，将多次网络请求压缩为原子化操作。
4. **验证机制**: 编写 `pytest` 测试用例，确保高频环境下的订单修改原子性。