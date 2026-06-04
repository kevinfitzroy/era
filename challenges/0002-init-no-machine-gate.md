# 0002 — 初始化握手没有机器 gate,理论上仍可被 agent 蒙混

- **日期**:2026-06-04
- **挑战者**:对谈 agent(承 `0001` 风险一)
- **靶子**:§0 初始化握手 / 强制力
- **状态**:`accepted-wontfix`(本阶段接受,理由见末)

## 一句话

§0 把初始化做成了「协议红线 + 可检查产物(`IDENTITY.md`)+ 脚手架保证目录合规」,比原来"软的一句话"硬很多;但**真正的拦截动作仍发生在 agent 内部**(它自觉读 `CLAUDE.md` → `protocol.md` §0)。要做到"agent 没法蒙混",拦截必须在 agent **之外**(Maestro 启动时的 `IDENTITY` gate = 档 C)。当前没有这层。

## 残留(仍可蒙混的缝)

- 脚手架(`era-onboard.sh`)只能保证**目录合规 + 握手入口在**,保证不了 agent 真的走握手。
- 没人强制 agent 读 `CLAUDE.md` 分流段 / `protocol.md` §0。
- agent 可以假装认领、随手写个 `IDENTITY.md` 而没真问人。
- `IDENTITY.md` 存在只证明"有这文件",不证明"认领时真问了人、人真确认了"。

## 已做的缓解(档 B + 脚手架)

- 协议红线 + 强制提问 + 回读确认,把正确路径写到最清楚。
- 根 `CLAUDE.md`「来意分流」做启动第一眼的触发扳机(Claude Code 自动加载工作目录 `CLAUDE.md`)。
- `era-onboard.sh` 保证每个 subproject 目录合规、必带握手入口、且**不预置假身份**。
- `IDENTITY.md` 作可检查证据:人 / Maestro 一眼能看到认领有没有发生(虽不能证明质量)。
- fidelity 的 corrected / low 信号,事后侧面暴露"这 agent 没对上人"(漂移的下游征兆)。

## 为什么本阶段 accepted-wontfix

用户 2026-06-04 选「ERA 契约 + Maestro 脚手架」(只改 ERA repo、给 Maestro 对接工具),把 Maestro **启动 gate**(档 C)留到"疼了再开",符合 `0001` 的 MVP 纪律:先用最小硬度跑真实试跑([#11](https://github.com/kevinfitzroy/entity-representative-agent/issues/11)),让实操暴露"到底会不会被蒙混",再决定上不上 gate。

**升级触发**:真实试跑中若出现身份漂移 / 蒙混 → 提级档 C:Maestro 在起 agent 前检查工作目录有无合法 `IDENTITY.md`,缺失则强制进认领模式、不放行正常工作(契约 `era/onboarding/subproject-contract.md` 已为此预留对接点)。
