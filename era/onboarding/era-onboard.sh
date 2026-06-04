#!/usr/bin/env bash
# era-onboard.sh — 把一个工作目录建成「合规 ERA 成员 subproject」。
#
# 给 Maestro(host 端 orchestrator)用:建某个成员的代言 agent subproject 时先调它,
# 保证工作目录拿到「全量方法论 + 强制握手入口」,而不是手工拼。
# 合规标准见同目录 subproject-contract.md。
#
# 用法:
#   era-onboard.sh <work-dir> [--repo <ERA repo url 或本地路径>]
#
# 做完后,由 Maestro 用自己的脚本在 <work-dir> 起 claude session,例如:
#   xreal-project.sh new claude <session> "<显示名>" -c <work-dir>
# agent 一启动会被工作目录根 CLAUDE.md 分流到 era/protocol.md §0 强制认领身份。
#
# ⚠️ 本脚本绝不预生成 IDENTITY.md —— 身份只能由 agent 在 §0 握手里「问过人、人确认」后生成。
#    脚本替人造身份 = 违背 amplifier 铁律。

set -euo pipefail

die() { echo "era-onboard: $*" >&2; exit 1; }

WORKDIR="${1:-}"
[ -n "$WORKDIR" ] || die "用法: era-onboard.sh <work-dir> [--repo <url|path>]"
shift

# 默认从本脚本所在的 ERA repo clone(脚本就躺在 era/onboarding/ 下)
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$SELF_DIR/../.." && pwd)"   # era/onboarding/ → repo 根
while [ $# -gt 0 ]; do
  case "$1" in
    --repo) REPO="${2:?--repo 需要参数}"; shift 2 ;;
    *) die "未知参数: $1" ;;
  esac
done

[ -e "$WORKDIR" ] && die "目标已存在,拒绝覆盖: $WORKDIR"

# 1. 全量拉方法论(工作目录 = ERA repo 的 clone,era/ 在根下,protocol 相对路径才成立)
git clone --quiet "$REPO" "$WORKDIR" || die "clone 失败: $REPO"

# 2. 合规自检
[ -f "$WORKDIR/era/protocol.md" ] || die "clone 后缺 era/protocol.md,源 repo 不合规: $REPO"
grep -q "确定你的来意" "$WORKDIR/CLAUDE.md" 2>/dev/null \
  || echo "era-onboard: ⚠️ 根 CLAUDE.md 未含来意分流段,实操 agent 可能不会自动进 §0 握手(见 subproject-contract.md)" >&2
[ -e "$WORKDIR/IDENTITY.md" ] && die "工作目录已有 IDENTITY.md —— 身份必须由握手现场生成,不该预置"

cat >&2 <<EOF
era-onboard: ✅ 工作目录已合规 → $WORKDIR
  · 全量 era/ 已就位,根 CLAUDE.md 会把实操 agent 分流到 protocol §0
  · IDENTITY.md 尚未生成(正确):由 agent 在 §0 握手问过人后才生成
下一步(Maestro):在该目录起 session,agent 会自动走握手 ——
  xreal-project.sh new claude <session> "<显示名>" -c "$WORKDIR"
EOF
