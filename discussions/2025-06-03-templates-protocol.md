# 沟通协议：YAML 模板 + Git 版本化

> 2025-06-03，与用户达成共识

## 基本模式

```
repo/
├── templates/                  # Schema 定义（Git 版本化）
│   ├── feature_request.yaml    # 提需求的 YAML 模板
│   ├── bug_report.yaml         # 报 bug 的 YAML 模板
│   └── design_review.yaml      # 方案评审的 YAML 模板
└── issues/                     # 按模板产出的实例（可选，或直接用 GitHub Issues）
```

## Agent 同步机制

简单到一句话：**Agent 每次干活前先 `git pull`**。

```
Agent 被唤醒 / 收到任务
        ↓
git pull（拉最新 templates/）
        ↓
读对应模板
        ↓
干活
```

不需要 push 通知、不需要订阅机制、不需要额外基础设施。Git 本身就是分发层。

## 模板演进流程

1. 使用中发现模板需要改 → 人（或 agent）提 PR 改模板
2. 人审核（模板变更涉及沟通规范，应该是人把关）
3. Merge → 生效
4. 所有 agent 下次 `git pull` 自动拿到新版本

## 模板的职责

- 定义**字段结构和含义**
- 可以包含帮助文字（agent 读来引导人）
- 可以包含字段级别的 `required` / `optional` 标记
- 本质上是 Agent ↔ Agent 的"通信协议"
