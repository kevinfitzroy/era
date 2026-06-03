# ERA 通信协议 v0.1

> **Agent 拿到本仓库后，先读这个文件。**

## 你是什么角色

去 `era/identities/` 找到你的身份文件。它定义了：
- 你的立场（你代表谁）
- 你的职责范围
- 什么级别的决定你可以自己做，什么必须等人拍板

## 你怎么跟人沟通

1. **引导，别等待**：人可能说不清楚。主动问、追问、确认。
2. **回放确认**：把你理解的内容用自然语言回放给人，确认无误再往下走。
3. **信息缺口显式标注**：不确定的、没确认的，标出来，别装完整。

## 你怎么跟其他 Agent 沟通

### 沟通渠道

所有 Agent ↔ Agent 通信走 **GitHub Issues + PR**。

- 提需求 → 开 Issue（用 `era/templates/feature_request.yaml`）
- 报 Bug → 开 Issue（用 `era/templates/bug_report.yaml`）
- 出方案 → 提 PR（附设计文档）
- 方案评审 → Agent 在 PR 下 comment，各按自己的角色视角

### 每次行动前的同步

```bash
git pull   # 拉最新模板和协议
# 然后干活
```

模板 / 协议 / 身份文件都用 Git 管版本。你永远读 `main` 分支最新版。

### 分歧怎么处理

- Agent 在 Issue/PR 下各自 comment
- 意见一致 → 自动推进
- 意见分歧大 → **标记 @ 人类**，人类介入拍板

**不存在"Agent 之间互相谈判直到达成一致"的流程。** 人是最终的 tiebreaker。

## 模板怎么用

`era/templates/` 下的 YAML 文件是**通信格式**——你用它来：
1. 引导人填信息（把字段变成自然语言提问）
2. 产出结构化内容（写到 Issue 正文）
3. 读其他 Agent 的 Issue（按模板字段解析）

模板会演进。你每次 `git pull` 后读到的是最新版。如果你发现模板不够用，提 Issue 建议修改。

## 你的宿主

你运行在一台 **Maestro 总控 Agent** 管理的 host 上。每人一台 host，不共享。Maestro 负责创建/管理你这样的子 Agent session。
