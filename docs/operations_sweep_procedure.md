# VERDICT Operations — 四半期 sweep 運用手順

**Version:** 1.1（2026-09-22）。v1.0（同日起草）に ReviewCadence-Sweep-001 の条件 (a)〜(g) と追加事項 A／B／C を反映。
**根拠:** ENGINE.md v0.3.2（verdict-engine `9f64418`）Layer C「sweep の手順は operations documents で定義する」。StrategyApproval-001、ReviewCadence-001、ReviewCadence-Sweep-001。
**適用範囲:** 公開済み評価の更新入口（interrupt lane／routine lane／dormancy）と、母集団の四半期差分。差分評価の作成は Engine の作業で、本書は Operations の手順のみを定める。
**置き場:** `verdict-engine/docs/operations_sweep_procedure.md`（ReviewCadence-Sweep-001 承認）。

---

## 1. 目的と原則

- Layer C の trigger（T1〜T6）は Operations の sweep が検出する。本書は検出・記録・引き渡し・公開の手順を固定し、検出漏れと日付の恣意を防ぐ。
- 分母（母集団 v1）は年次で引き直し、四半期は差分の記録のみ（Population Definition §7）。sweep は母集団差分と trigger 検出を同じ日に同じ script で行う。
- Ops は候補を機械的に集めて Engine に渡す。「評価対象に帰属する CVE か」「重大インシデントか」の判定は Engine（ENGINE.md の trigger 定義）。Ops は判定語を書かず、判定前の候補を公開しない。
- 検証していないものを検証済みと表示しない。`updated_at`・last verified は差分評価の公開でのみ動く。日付だけを動かす操作は行わない。公開される成果物は QA v1.1 FULL。
- 件数は全件（N は runtime、`platforms.json` の件数）。本文に固定数を書かない。

## 2. 頻度

| レーン | 頻度 | 内容 |
|---|---|---|
| 週次 light scan | 毎週月曜（JST）、script のみ | NVD・GHSA・CISA KEV feed 由来のシグナルに限る（T1 CVSS 7.0+、T2、および feed で観測できる T3）。キーワード検索は行わない。該当があれば当日中に Engine へ。候補 0 でも `#daily-log` に 1 行。`updated_at`／last verified には触れない |
| 四半期 sweep | 各四半期の第 1 週（1・4・7・10 月、anchor 固定） | §4 の全手順（T1 7.0 未満、T5、T6、T3／T4 のキーワード検索候補、routine 期日、休眠判定、母集団差分） |
| routine（365 日、暫定） | 四半期 sweep 内で期日到来分を抽出 | base = `updated_at` があればそれ、無ければ `evaluated_at`。間隔は ReviewCadence-002 で確定 |

第 1 回 sweep は 2026-10 第 1 週を目標とし、sweep.py の dry run 完了を前提とする。遅延しても 2026-10 内。E-7（superagi の `dormant_since`）は第 1 回で付与。

## 3. 入力

- canonical：`verdict-platforms/data/platforms.json`（rank・tier・`cve_count_12mo`・`max_cvss_12mo`・`cisa_kev`・`updated_at`・`evaluated_at`・`github`）と各 `platforms/*.md` の frontmatter（`target_version`、`sources`、`dormant_since`、`selection_basis`）。
- 公開データ：NVD API、GitHub Security Advisories（repo 単位）、CISA KEV JSON feed、対象ベンダーの changelog／release／privacy policy／ToS ページ（T5 用、URL と last-updated 表示）、GitHub API（`pushed_at`、最新 release 日）。
- 母集団：Population Definition の GitHub 条件で同一日に再取得。リスト 3 本は年次のため四半期では触らない。

## 4. 四半期 sweep の手順（1 セッション、読み取りのみ）

1. **同期確認。** 3 repo で `git fetch origin && git status -sb`。ahead/behind 0 を確認してから始める。
2. **母集団差分。** GitHub topic スナップショットを再取得し、直近の年次版との差分（追加・除外・★変動）を `data/census/<YYYY-MM>/delta_<date>.csv` に記録。分母の数値は年次まで変えない。
3. **T1／T2 照合。** 全件について trailing 12 か月の CVE を NVD で再集計し、記録値（`cve_count_12mo`、`max_cvss_12mo`）との差を観測表に出す。KEV feed と `cisa_kev` を照合し、新規追加は T2（即時扱い）。
4. **T3／T4 候補出し。** 供給網侵害・重大インシデントは公開報道の 2 独立ソース要件があるため、機械照合はキーワード検索の候補出しまで。候補表（非公開）で Engine に渡す。判定は Engine。
5. **T5 照合。** 各件の privacy policy／ToS／会社情報ページの last-updated 表示を取得し、前回 sweep 以降の変更を観測表に出す。所有者変更・改名は公開発表の URL を添える。
6. **休眠判定。** repo が評価対象の件は `pushed_at`・最新 release 日、hosted 製品は製品の changelog／release ページの最終更新日を観測。12 か月無活動を観測表に出す（Layer C：hosted 製品は repo 停滞だけでは非該当）。既に `dormant_since` を持つ件は活動再開の有無を観測。
7. **routine 期日。** base ＋ 暫定間隔が次の sweep までに到来する件を抽出。
8. **sweep report。** §5 の 2 層で出力し、`#daily-log` に要約を記録、Engine に渡す。

## 5. sweep report の 2 層

**観測表（公開、`data/sweeps/<YYYY-MM-DD>/observations.csv`）**：一次 feed／API から機械的に導ける行のみ。列は `slug / source_url / observed_value / observed_date / recorded_value / lane`（lane = T1 / T2 / T5 / routine / dormancy）。判定語（「候補」「該当」）は書かない。冒頭に「機械照合の観測値。判定は差分評価として公開する」を明記。

**候補表（非公開、Engine へ直接）**：T3／T4 のキーワード検索候補、および観測表から Ops が読み取った引き渡し順。`mandatory scope` は Layer C の表どおり（T1: R、T2: R＋KEV protocol、T3／T4: R,T、T5: V,D＋independence／parent_entity、T6: 全次元、routine: R,T,V）。

第三者ページの取得ファイル本体はローカル archive（sha256 付き）のみ。母集団差分（`delta_<date>.csv`）は `data/census/` 側。

## 6. 差分評価の受け入れと公開（E-6 pilot もこの手順）

Engine から受け取るもの（1 件につき）：
- 更新済み `platforms/<slug>.md` 全文（Differential Evaluation の field 規則どおり：`evaluated_at` 不変、`updated_at` = 完了日、`previous_*` = 直前の評価、`evaluation_type: update`、`differential` は次元ごとに re-evaluated／carried-forward、CVE 系 field は更新日基準で再計算、`qa`・`evaluator_model` 記録、body に Differential 節と Evaluation History の追記行）。
- Differential 節に carry-forward check の日付と URL。
- Engine の作業時間。Ops は受領・validate・deploy の時間を足して pilot 記録にする。

Ops の手順：
1. `validate.py` 全件 valid。**暫定（pilot 5 件限り）：** check 9 は `updated_at + 90 日` を強制しているため、pilot の更新ファイルは `next_review_due = updated_at + 90` で validate を通す。この暫定は pilot 5 件に限り、順序は pilot 5 → ReviewCadence-002（間隔確定・check 9 定数・`next_review_due` 一括再導出）→ 一括検証。`next_review_due` は非描画のため表示上の影響はない。
2. スコアが 5 点以上動いた件は Executive Summary に理由が書かれているか、R のみの再確認で 3 点以上動いた件は full re-review に上がっているかを確認（書式チェックであって内容判断ではない）。
3. commit（explicit path）→ push → workflow（validate → build_index → bot rebuild）→ `git pull --ff-only`。
4. サイト再描画：対象ページ（`render_index.render`）、index カード（`render_card`）、rankings（`render_rankings.py`）。再描画前に `/tmp` で live と比較し、意図した行以外が変わっていないことを確認してから書く。
5. 公開注記の更新：最初の差分評価が公開された時点で `/notices/review-status/` を「in progress」＋ 完了数／N ＋ 直近公開日 ＋ 順序（CVE>0 → agent → 残り）に改める。再開予定日は書かない。完了数は canonical 派生（`evaluation_type: update` かつ `updated_at ≥ 2026-08-28` の件数、分母は runtime N）。pilot 期間は differential の deploy と同一 commit での手書き可、一括検証開始までに render 派生へ移す。QA FULL。
6. verdict-index commit → push → `curl` で本番確認 → `#daily-log`。

## 7. 休眠（E-7）の手順

- 付与：`dormant_since: <最終活動日>`（source-cited）、body に Dormancy note（観測日と出典）。verdict・score・tier・rank は不変。routine lane から外し、interrupt lane は維持。
- 表示：ReviewCadence-001 は休眠を「凍結状態、表示あり」と決めている。E-7 の実施前に renderer が `dormant_since` を描画するかを Engine が確認し、未対応なら render 変更を E-7 に含める。
- superagi：`dormant_since: 2025-01-22`（GitHub `TransformerOptimus/SuperAGI` の最終 push、観測 2026-09-19）。第 1 回 sweep で付与。bolt.new は hosted 製品のため非該当。
- 解除：活動再開を観測したら `dormant_since` を削除し、次の sweep で routine differential を予定。

## 8. 第 1 回 sweep と一括検証の接続

第 1 回 sweep の T1 観測表（記録値 2026-03〜05 に対する全件の CVE 差分）は、一括検証の第 1 バッチ（`cve_count_12mo > 0` の件）の入力として Engine に渡す。順序は ReviewCadence-001 (b) のまま（CVE>0 → agent 層の残り → その他）。sweep は検出であり、一括検証を置き換えない。

## 9. 記録

- `#daily-log`：週次 scan（候補 0 でも 1 行）、四半期 sweep の実施日・観測件数（lane 別）・Engine への引き渡し、差分評価の公開。
- worklog：provenance に関わる訂正（field の復元・訂正）は必ず記載。
- `data/sweeps/`（観測表）と `data/census/`（母集団差分）：公開データのみ。第三者ページの取得ファイル本体はローカル archive（sha256 付き）。

## 10. 実装

- `sweep.py`：読み取りのみ、進捗表示、lane ごとの checkpoint 保存、token は環境変数。NVD API は API key 無しで slug ごとに 6 秒間隔（全件で約 7 分）。
- 週次 scan は同じ script の `--weekly`（feed 由来のみ）。
- 初回は dry run（観測件数のみ、書き込みなし）で observations.csv と候補表の書式を Engine と確定してから本番。

---

*Operations 文書。QA Protocol v1.1 FULL 適用済み（2026-09-22、CLEARED）。*
