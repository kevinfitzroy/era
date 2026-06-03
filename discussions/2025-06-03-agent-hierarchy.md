# Agent 层级：总控 + 子 Agent

> 2025-06-03，用户提出

## 模型

```
总控 Agent (Master)
│
│  掌握整个 ERA 方法论
│  了解项目管理全流程
│  负责创建/管理子 Agent
│
├── 子 Agent A (项目 1)    ← 一个小项目，不搞大
├── 子 Agent B (项目 2)    ← 每个子 Agent 管一件事
├── 子 Agent C (项目 3)
└── ...
```

- **总控 Agent**：知道"怎么管"，方法论的所有知识在这
- **子 Agent**：知道"怎么干一件具体的事"，领域知识在各自的项目里
- 项目刻意拆小——不搞一个大而全的项目

## 和现有 Maestro 体系的关系

当前 Maestro 就是这个"总控 Agent"的雏形：

| 概念 | 对应 |
|------|------|
| Maestro | 总控 Agent |
| `projects.json` 里的每个 project | 子 Agent |
| 本项目 `ai-era-pm` | 一个子项目 |

ERA 方法论 → 写入 Maestro 的 CLAUDE.md → Maestro 创建子 Agent 时把方法论 handoff 下去。

## 部署模式：每人有自己的 Host（分布式）

**不是多人共享一台 host。** 每个人跑自己的 host + 自己的 Maestro。

原因：多人控制同一台 host 会导致数据污染（agent 分不清谁是谁的）。

```
人 A 的 Host                    人 B 的 Host
┌─────────────────┐            ┌─────────────────┐
│  Maestro (总控)  │            │  Maestro (总控)  │
│  身份: business  │            │  身份: tech      │
│                 │            │                 │
│  子 Agent A1    │            │  子 Agent B1    │
│  子 Agent A2    │            │  子 Agent B2    │
└────────┬────────┘            └────────┬────────┘
         │                              │
         │     ┌──────────────────┐     │
         └─────┤  GitHub 私有仓库  ├─────┘
               │  (模板+Issue+PR) │
               └──────────────────┘
```

优势：
- 数据隔离——每个人的 agent 只服务自己的主人
- 各自运维——一个人的 host 挂了不影响别人
- 身份绑定——每台 host 的 Maestro 初始化时认领一个身份

初始化时：Maestro 从 GitHub repo 拉 `identities/` 目录，认领身份，按身份行事。
