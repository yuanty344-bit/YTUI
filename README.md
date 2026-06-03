# YTUI — Components for Qt 6 QML

暗色玻璃质感 QML 组件库，osu!lazer 视觉风格。

## 快速开始

### 环境要求

- **Qt 6.4+**（开发用 6.11.1，MinGW）
- `QtQuick`、`QtQuick.Effects`、`QtQuick.Controls`（Qt 6 自带）

### 运行

```powershell
# 1. 设置你的 Qt 路径
$env:PATH = "D:\Qt\6.11.1\mingw_64\bin;" + $env:PATH
qml Main.qml
```

或双击 `run.bat`（先编辑里面的路径改成你自己的 Qt 位置）。

或 **Qt Creator**：文件 → 打开项目 → 选 `YTUI.qmlproject` → `Ctrl+R`。

### 集成到你的项目

复制 `controls/`、`primitives/`、`theme/` 三个文件夹到你项目目录：

```qml
import "controls"
import "theme"

YTButton {
    text:        "Play"
    accentColor: YTTheme.accent
    onClicked:   console.log("clicked")
}
```

## 组件

### YTButton

状态驱动按钮 — 4 态 × 3 变体 × 6 色。

```qml
YTButton {
    text:        "Play"              // 按钮文字
    iconSource:  "icons/play.svg"    // SVG 图标，可选
    variant:     "primary"           // "primary" | "secondary" | "ghost"
    accentColor: YTTheme.accent      // 或 YTColors.blue
    enabled:     true                // false → 灰色禁用
    loading:     false               // true  → 呼吸脉冲
    width:       200                 // 默认 200×60，可自由缩放
    height:      60
    onClicked:   { /* handler */ }
}
```

### YTToggle

Pill 形 toggle — knob 滑动带 OutBack 弹跳。

```qml
YTToggle {
    checked:     false
    accentColor: YTColors.blue
    enabled:     true
    onToggled:   function(c) { /* c = 新状态 */ }
}
```

## 设计 Token

| 文件 | 用途 |
|------|------|
| `YTTheme` | accent / elevation / shadow / variant / disabled / breathe |
| `YTAnimation` | 时长 token：`instant` / `micro` / `fast` / `normal` / `slow` |
| `YTColors` | 色板：pink / blue / purple / green / orange / cyan |

```qml
YTButton { accentColor: YTTheme.accent }
YTButton { accentColor: YTColors.blue }
YTButton { accentColor: "#FF66AA" }
```

## 项目结构

```
YTUI/
├── Main.qml                   入口 — 默认加载 Gallery
├── run.bat                    双击运行
├── YTUI.qmlproject            Qt Creator 项目文件
├── README.md
├── .gitignore
│
├── controls/                   组合控件
│   ├── YTButton.qml
│   └── YTToggle.qml
│
├── primitives/                 视觉原子（不改动）
│   ├── YTSurface.qml          4-stop 渐变 + 镜面高光
│   ├── YTShadow.qml           对角光源动态阴影
│   ├── YTRipple.qml           涟漪扩散
│   └── YTNoise.qml            噪点 dither
│
├── theme/                      设计 token
│   ├── YTTheme.qml
│   ├── YTAnimation.qml
│   └── YTColors.qml
│
├── demo/                       演示页
│   ├── Gallery.qml             总览（所有组件一览）
│   ├── ButtonDemo.qml          按钮独立演示
│   └── ToggleDemo.qml          Toggle 独立演示
│
└── assets/
    ├── noise.png               噪点纹理
    └── icons/                  SVG 简笔画图标
```

## 添加新组件

1. 在 `controls/` 新建 QML 文件，组合 `primitives/` + `theme/`
2. 在 `demo/Gallery.qml` 加一组展示
3. **不要改动 `primitives/`** — 它们是稳定底层
