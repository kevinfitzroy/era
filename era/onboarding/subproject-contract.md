# ERA 成员 subproject 合规契约

> 定义:一个 ERA 成员 subproject(某个人的代言 agent 工作目录)**必须满足什么**,
> 以及 **Maestro 怎么把它建合规**。
> ERA repo 只能定义契约;**强制由 Maestro 端执行**——只有 Maestro 在 agent 之外,挡得住蒙混。

## 一个合规 subproject 必须满足(契约)

1. **全量方法论在位**:工作目录含完整 `era/`(protocol / identities / templates / fidelity / IDENTITY.template)。
   → 工作目录 = 本 repo 的 clone,`era/` 在根下,protocol 里的相对路径才成立。
2. **指导文件按来意分流**:工作目录根 `CLAUDE.md` 顶部把 agent 按来意分流——
   实操代言 agent → `era/protocol.md` §0 强制握手;方法论维护 agent → 往下读。
3. **身份锚现场生成**:`IDENTITY.md` 由 §0 握手**当场问过人、人确认后**生成,
   本地保留、`.gitignore`、**绝不回流**公共 repo。
   **谁都不许预生成假身份**(脚本、Maestro、agent 都不行)。
4. **方法论可更新**:`git pull` 能把 `era/` 的更新拉回来(protocol 已要求每次行动前 pull)。

## Maestro 怎么建(对接)

```bash
# 1. 用脚手架把工作目录建合规(全量 clone era/,且不造身份)
era/onboarding/era-onboard.sh <work-dir> [--repo <ERA repo url 或本地路径>]

# 2. 用 Maestro 自己的脚本在该目录起 session
#    agent 一启动会被根 CLAUDE.md 分流到 era/protocol.md §0 强制认领身份
xreal-project.sh new claude <session> "<显示名>" -c <work-dir>
```

## 强制力到哪一档(诚实)

- **当前(档 B + 脚手架)**:脚手架保证「目录合规 + 必带握手入口 + 不预置假身份」;
  但**握手本身仍靠 agent 自觉走**(它自觉读 CLAUDE.md → §0)。
- **更硬(档 C,暂未做)**:Maestro 起 agent 前检查工作目录有无合法 `IDENTITY.md`,
  缺失则强制进认领模式、不放行正常工作。残留与升级触发见
  [`../../challenges/0002-init-no-machine-gate.md`](../../challenges/0002-init-no-machine-gate.md)。

## 自检(Maestro 维护 deck 时顺带核)

每个 ERA subproject 是否有:`era/protocol.md`、根 `CLAUDE.md` 的来意分流段、
以及握手后该出现的 `IDENTITY.md`(缺 `IDENTITY.md` = 这个 agent 还没认领身份 → 提醒)。
