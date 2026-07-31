# 宜兴日报 视觉与结构规范

## 配色（CSS 变量，政务绿风）
```css
--brand:#0E5E4E;   /* 主色·深绿 */
--brand2:#12876E;  /* 主色渐变亮绿 */
--accent:#C8622D;  /* 强调色·橙 */
--accent2:#E08A3C; /* 强调色亮橙 */
--bg:#f4f6f5;
--card:#ffffff;
--ink:#1c2b28;
--sub:#5f6f6b;
--line:#e6ebe9;
```

## 3+3+N 产业链分层配色（撞色分区，一眼可辨）
| 层级 | 中文 | 行业 | 背景色 |
|---|---|---|---|
| tier1 | 🏛️ 传统优势支柱 | 电线电缆 · 节能环保 | 金色渐变 `linear-gradient(120deg,#B7791F,#D9A441)` |
| tier2 | 🚀 战略新兴主导 | 集成电路 · 新能源 · 生命健康 · 新材料 | 绿色渐变 `linear-gradient(120deg,#0E5E4E,#17A883)` |
| tier3 | 🌱 未来培育 | 通用人工智能 · 高端装备 | 橙色渐变 `linear-gradient(120deg,#C8622D,#E88B3D)` |

## 重点赛道配色轮换（每个赛道换一色，便于滑动定位）
```js
var TRACK_COLORS=['#2563EB','#0E5E4E','#C8622D','#7C3AED','#0891B2','#B7791F','#DB2777','#059669','#DC2626','#4F46E5'];
```
按赛道出现顺序依次取色（`i % TRACK_COLORS.length`）。

## 页面结构（自上而下）
1. **密码门**（`#pass-gate`）— 全屏遮罩，绿色径向渐变背景，密码 `123456`，sessionStorage key 需按当天日期变化（如 `yx_daily_0731_ok`）避免跨天误判已登录
2. **topbar** — logo + 「宜兴重点企业商业动态 · 每日参阅 Daily Brief」
3. **hero** — 大标题「宜兴市重点企业商业动态」+ 副标题「每日商业动态参阅 · 企业版」+ 当日日期 + 编制来源 + 「共 N 条重点动态 · 对宜启示」胶囊
4. **dayView**（当日动态，默认显示）
   - view-tabs 三个：📍 本地企业 / 🔗 3+3+N 产业链 / 🎯 重点赛道
   - 每条卡片结构（四层，铁律不可变）：**企业名称 → 主旨(gist) → 正文(body-text) → 对宜启示(rel)**，末尾来源链接
5. **histView**（历史动态，切换后显示）
   - 搜索框 + 4个筛选下拉（产业/事项分类/城市/企业）+ 重置/导出Excel按钮
   - 按日期分组（`.grp.hist`），每条为精简卡片：企业名+行业+一句话标题+一句「💡对宜启示」+来源
   - **当日动态不显示搜索筛选栏；只有历史动态才显示**
6. **底部吸底导航**（`.day-tabs`，`position:sticky;bottom:0`）— 📅 当日动态 / 🗂 历史动态，切换时页面平滑滚回顶部（`window.scrollTo({top:0,behavior:'smooth'})`）

## 卡片文案长度要求
- `title`（主旨/gist）：一句话概括，20-40字
- `summary`（正文/body-text）：完整信息含数据/日期/来源事实，120-220字
- `rel`（对宜启示）：不是复述新闻，要写清"这件事对宜兴意味着什么"——本地产业链联动、承接效应、风险提示、招商信号等，100-180字
- 历史动态归档时大幅精简：title一句话（20字内）、rel一句话（15字内）

## 密码门与安全
- 密码固定 `123456`（用户要求变更时才改）
- sessionStorage key 按日期变化：`yx_daily_MMDD_ok`
- 提示文案第二行固定：「本页面信息属于宜兴商务局」

## 部署铁律
- **URL 固定不变**：`https://api.lexoavatar.com/pages/yixing-daily-v2-20260730.html`（文件名里的日期是历史遗留，不随每日更新改变——这样二维码/收藏链接永远有效，只更新文件内容）
- 部署路径：`/var/www/html/pages/yixing-daily-v2-20260730.html`
- nginx 已配置好该域名到 `/var/www/html/pages/`，无需改 nginx
- Excel 导出文件名仍写死 `_20260730.xlsx` 后缀，可选优化为当天日期但非必需

## QR 封面卡规范
- 见 `qr-cover-template.html`，620×800px，绿色主banner + WiseLaw logo + 标题 + 日期 + 「共N条重点动态·对宜启示」+ 二维码(250×250, colorDark `#0e5e4e`) + 提示文案
- 用 `QRCode.js`（`https://cdn.jsdelivr.net/gh/davidshimjs/qrcodejs@master/qrcode.min.js`）在浏览器里生成，`text` 指向当天部署后的日报 URL
- 用 OpenClaw `browser` 工具打开该 HTML（本地文件或 data URL）截图导出 PNG，而非依赖本机 playwright/node 环境
