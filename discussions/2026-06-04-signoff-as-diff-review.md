# sign-off 改成"审对照"(差异驱动) — 2026-06-04

> 落地 issue #7 的 **B**。和 #1 的 provenance(`source` 字段)配套使用。

## 问题

现在 sign-off = agent 用自然语言**流畅回放**、人点头(proxy 的确认仪式)。三个毛病:
1. **惯性点头**(acquiescence bias):听一段顺溜的话容易顺口"对";
2. **看不到对照**:人不知道"我原话说了啥" vs "agent 理解成了啥";
3. **流畅掩盖补充**:agent 替你补的(`inferred`)混在叙述里,看不出来。

## amplifier 的 sign-off = 审"对照",不是确认"回放"

人该确认的是【原话 ‖ 结构化】的对照,不是 agent 的二次创作。

## 但撞上 AR / 语音 → 所以"差异驱动"

本项目的人戴 AR、用语音。让他读并排对照长表是酷刑。于是:

> agent 只把**需要人拍的点**逐条口头确认,全文对照只留 issue 供审计 / 回看。

"需要人拍的点" = #1 provenance 里的 `inferred` + `unconfirmed` + agent 改写了语义的字段。纯 `stated` 且无歧义的**默认采纳**。

形式(语音逐条):
```
agent:"你说『报表太慢』;指标『3 秒内返回』是我替你定的——对吗?"
人:"对" / "5 秒就行" / "这个我说不准"
```

## 两个拍板(2026-06-04)

| 分叉 | 选择 | 为什么 |
|------|------|--------|
| **确认颗粒度** | 差异驱动:只拍 inferred / unconfirmed / 被改写的点 | 适配 AR + 语音,又把风险点都过了;纯 stated 默认采纳,可一句话调出全文对照 |
| **原话留存** | 只留被改写 / 补充的那几条原话 | 重点留证(传原料),issue 不臃肿;纯 stated 不附逐字 |

被否的:全字段逐条 → 语音下啰嗦,反而退化成惯性点头;整段回放 + 高亮 → 没治惯性点头;全留逐字原话 → issue 臃肿;不留原话 → 对照基准太弱。

## 机制

(写进 `era/protocol.md`「审对照确认」+ `feature_request.yaml` / `bug_report.yaml` 的 `signoff` 字段)

1. agent 产出结构化,每字段带 `source`(#1 的 provenance);
2. 算出"需要人拍的点" = inferred ∪ unconfirmed ∪ 语义被改写;
3. 逐条口头确认,记 `verdict`:confirmed / corrected(连人改成了什么) / unconfirmed;
4. 被改写 / 补充的字段,附人的原话片段(`human_said`)作对照基准;
5. `signoff` 记录连同结构化一起写进 issue,可追溯。

## 关系

- **依赖 #1**:没有 `source` 标注,就算不出"需要拍的点"——B 站在 provenance 的肩上。
- **与 C(人直连)同构**:直连结论的回填也是一次"审对照",两条共用同一套 `source` / `human_said` 约定,可一起演进。
