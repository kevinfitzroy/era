# 现有 Maestro 体系 → ERA 可复用的模式

> 2025-06-03，阅读 Maestro CLAUDE.md + xreal-project.sh + projects.json 后整理

## 已有的核心设计（直接搬）

### 1. 总控 + 子 Agent 架构

```
Maestro (总控 Agent)
│   manifests/projects.json  ← 唯一真相源
│   守护 loop: while :; do claude; done
│
├── 子项目 1  ← 一个 tmux session = 一个 claude
├── 子项目 2  ← 各自独立目录，互不干扰
└── 子项目 3
```

**对 ERA 的意义**：这就是我们讨论的总分结构，已经在跑。ERA 不需要重新发明这一层。

### 2. 项目即 Session + 目录

- 一个项目 = 一个目录 + 一个 tmux session + 一条 manifest 记录
- 两个 agent 绝不共享目录（防止互相覆盖）
- Session 名限制 `[A-Za-z0-9_.-]`（app 会拼进 shell 命令）

### 3. 身份隔离：每人自己的 Host

- 一台 host 一个 Maestro，不搞多租户
- 理由：数据隔离，agent 不会混淆主人

**对 ERA 的意义**：这正是我们刚确认的分布式部署模式。

### 4. 状态上报（自动）

```
Claude Code hooks  → agent-status.sh → status.json
  UserPromptSubmit → working
  Stop             → waiting
  SessionEnd       → disconnected
```

App 读 `status.json` 显示每个项目的运行状态。ERA 多 host 场景下，每台 host 各自维护自己的 status。

### 5. 开机自愈

- `@reboot` cron → `xreal-project.sh restore` → 重建所有 tmux session
- Maestro 守护 loop 防进程退出
- 启动时自检：cron 在不在、cron 服务在不在跑

### 6. 原子 Manifest

```
写 .tmp → mv 覆盖 → app 不会读到半截 JSON
```

ERA 的模板/协议文件也可以用同样的原子写策略。

## ERA 在 Maestro 基础上要加什么

| 已有（Maestro） | ERA 需要新增 |
|----------------|-------------|
| 单 host 的总分架构 | 多 host 之间的 agent 协作 |
| 项目创建/管理 | 身份认领（`identities/`） |
| 状态上报 | Agent ↔ Agent 通信协议（YAML 模板） |
| 语音约定 handoff | 沟通流程模板（提需求 5 步等） |
| 开机自愈 | 模板同步机制（`git pull` before action） |
| Manifest 原子写 | GitHub Issues/PR 作为 agent 共享工作区 |
| 热词管理 | 升级路径/仲裁机制 |

## 亮点：Maestro 已经是 ERA 的一个实现

本项目 `ai-era-pm` 自己就在 manifest 里：

```json
{
  "session": "ai-era-pm",
  "name": "AI时代项目管理",
  "type": "claude",
  "dir": "~/work/ai-era-pm",
  "group": "research"
}
```

ERA 方法论讨论出来后，可以写进 Maestro 的 CLAUDE.md，Maestro 再 handoff 到每个子项目的 CLAUDE.md——这就是"自演进协议"的落地路径。
