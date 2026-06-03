# ERA — Entity Representative Agent

一套**团队内部协作的沟通框架**。核心假设：**每个成员都由自己的 AI agent 替自己发声**——agent 替你把话说清、把分歧摆明，但**决定权和制衡权始终在人**。

> **🧭 定位北极星:agent 是 amplifier(放大器),不是 proxy(代理人)。**
> agent 的职责是把**真实信息**和**真实分歧**低成本地暴露给人(翻译 + 放大 + 标注出处),**不是**替人交换信息、替人达成共识、替人决策。
> 详见 [`discussions/2026-06-04-amplifier-not-proxy.md`](discussions/2026-06-04-amplifier-not-proxy.md)。

## 快速导航

| 你是… | 读什么 |
|--------|--------|
| **新成员（人）** | 看下面"新成员上手" |
| **AI Agent** | 读 `era/protocol.md`，然后看你的身份文件 `era/identities/` |
| **方法论维护者** | 读 `discussions/` 了解设计背景，改 `era/` 下的文件 |

## 新成员上手

1. 建好自己的 Host，部署 Maestro 总控 Agent
2. `git clone` 本仓库
3. 运行初始化：Maestro 会读取 `era/identities/`，你认领一个角色
4. 之后你的 Agent 会按角色引导你——提需求、报问题、审方案

## 目录结构

```
├── README.md              ← 你在这
├── era/                   ← 方法论本体（Agent 必读）
│   ├── protocol.md        # Agent ↔ Agent 沟通协议
│   ├── identities/        # 角色身份模板
│   │   ├── business.yaml
│   │   └── tech.yaml
│   └── templates/         # 沟通 YAML 模板
│       ├── feature_request.yaml
│       ├── bug_report.yaml
│       └── design_review.yaml
└── discussions/           # 方法论的设计讨论记录（人类阅读，Agent 不需要）
```

## 一句话小结

> 不让人去学"怎么沟通"——让 Agent 替人补齐信息、引导对话、代表决策。人只做两件事：确认理解、拍板分歧。
