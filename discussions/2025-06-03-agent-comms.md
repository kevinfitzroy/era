# Agent ↔ Agent 沟通：以 GitHub Issues + PR 为骨干

> 2025-06-03，用户提出

## 核心设计决策

**Agent 之间的沟通走 GitHub Issues + PR**。

这不是比喻——Agent 真的在 repo 里开 Issue、发 PR、做 review。人也可以看到、参与，但日常的"写"操作由 agent 完成。

### 为什么这个方向合理

- Issue/PR 本身就是**异步协商工具**——天生匹配 agent-to-agent 模式
- 有成熟的状态机：open → in review → merged/closed
- 人类已经熟悉这套界面，透明可追溯
- Agent 可以通过 API 操作，不需要人教
- Markdown 正文 + 结构化数据（YAML frontmatter / comment 模板）可以兼顾自然语言和机器可读

## Agent ↔ Agent 的实际交互模式

**不是"谈判"，是各抒己见 + 人工仲裁。**

- Agent A 在 Issue 下 comment（自己的判断、建议）
- Agent B 在 Issue 下 comment（自己的判断、建议）
- 意见一致 → 自动推进
- **意见分歧大 → 人类介入拍板**（比如 PR merge 时人工确认）

没有"两个 agent 互相谈判直到达成一致"的需求。人是最终的 tiebreaker。

### 可能存在的局限

- Issue/PR 流程对某些轻量协商可能太重
- 需要约定 agent 之间写 Issue 的**模板格式**（延续上一轮的 YAML 思路）
- PR review 环节人插不插手需要界定

待实际使用中检验。

## 决策

**使用 GitHub 私有仓库。**

原因：GitHub 有 `gh` CLI 工具，AI agent 可以通过 shell 直接操作：

```bash
gh issue create --title "..." --body "..."
gh pr create --title "..." --body "..."
gh issue list --label "needs-review"
gh pr review --approve
```

比 Gitea 的 API-only 方式更便捷，降低 agent 实现的复杂度。国内访问速度不是核心障碍——agent 异步操作，不需要低延迟。

## 曾被考虑的备选

- Gitea 自建（轻量但缺少 `gh` 级别的 CLI）
- GitLab CE 自建（太重）
- Gitee（免费仓有限制）
