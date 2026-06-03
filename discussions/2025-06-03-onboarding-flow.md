# 新成员上手流程

> 2025-06-03，用户描述

## 三步走

```
第 1 步：创建 Host
        │
        ▼
第 2 步：建立总控体系（Maestro 部署 + 身份认领）
        │
        ▼
第 3 步：同步项目
        │
        ├── 已有 GitHub 仓库 → git clone + 子 Agent 接管
        └── 新项目 → Maestro 创建空项目
```

## 第 1 步：创建 Host

- 每个新成员需要一台自己的机器/VM
- 由已有成员引导完成（"代客安装"模式）
- 产出：一台跑着基础环境的 host

## 第 2 步：建立总控体系

- 部署 Maestro（CLAUDE.md + xreal-project.sh + hooks）
- **身份认领**：Maestro 从 GitHub 拉 `templates/identities/`，新成员选一个角色
- Maestro 按角色配置自己的行为
- 产出：一个知道自己"是谁"的总控 Agent

## 第 3 步：同步项目

- Maestro 扫描分配给该角色的 GitHub 仓库
- `git clone` + 创建对应的子 Agent session
- 子 Agent 读取项目 CLAUDE.md + ERA 沟通模板
- 产出：新成员可以开始工作了

## 新成员看到的第一屏

```
👋 你好！我是你的 Maestro。

你的身份：业务需求方

接下来我会帮你：
- 提需求、报问题，不用你自己写文档
- 跟踪进展，有结果了我会告诉你
- 需要你确认的时候我会把话翻译成你能看懂的样子

想先做什么？
1. 提一个新需求
2. 反馈一个问题
3. 看看现有项目的进展
```
