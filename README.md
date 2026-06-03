# YTUI — Components for Qt 6 QML

## 运行

```powershell
$env:PATH = "D:\Qt\6.11.1\mingw_64\bin;" + $env:PATH
qml Main.qml
```

## 结构

```
YTUI/
├── Main.qml                    入口 — Window + 背景 + Demo
├── README.md
│
├── assets/                     静态资源
│   ├── noise.png                噪点纹理 — dither 渐变色带
│   └── icons/                   SVG 简笔画图标
│       ├── play.svg
│       ├── settings.svg
│       ├── exit.svg
│       └── download.svg
│
├── controls/                    组合控件
│   ├── qmldir
│   └── YTButton.qml            状态驱动按钮 — 4 态 × 3 变体
│
├── primitives/                  视觉原子 — 稳定，不改动
│   ├── qmldir
│   ├── YTSurface.qml           4-stop 渐变 + 镜面高光
│   ├── YTShadow.qml            对角光源动态阴影
│   ├── YTRipple.qml            涟漪扩散 — pill 裁剪
│   └── YTNoise.qml             噪点 dither — tiled PNG
│
├── demo/                        独立演示页
│   ├── qmldir
│   └── ButtonDemo.qml          毛玻璃卡片 + 全部 API 展示
│
└── theme/                       设计 token — 全部 singleton
    ├── qmldir
    ├── YTTheme.qml              accent / elevation / shadow / variant / disabled / breathe
    ├── YTAnimation.qml          时长 token
    └── YTColors.qml             色板 — pink / blue / purple / green / orange / cyan
```

## API

```qml
YTButton {
    text:        "Play"
    iconSource:  "assets/icons/play.svg"   // SVG 路径，可选
    variant:     "primary"                  // "primary" | "secondary" | "ghost"
    accentColor: YTTheme.accent             // 或 YTColors.pink
    enabled:     true                       // false → 灰色褪色
    loading:     false                      // true  → 呼吸脉冲
    width:       200                        // 默认 200×60，可自由缩放
    height:      60
    onClicked:   console.log("clicked")
}
```

## 状态矩阵

| 维度 | Normal | Hover | Pressed | Disabled |
|------|--------|-------|---------|----------|
| y | 0 | -3 (OutQuart) | +1 | 0 |
| scale | 1.0 | 1.0 | 0.96 | 1.0 |
| shadow H | 2 / 5 / 1 / 2 | — | — | — |
| shadow V | 4 / 9 / 2 / 4 | — | — | — |
| shadow blur | 1.0 / 1.4 / 0.5 / 1.0 | — | — | — |
| shadow alpha | 0.35 / 0.55 / 0.18 / 0.35 | — | — | — |
| opacity | 1.0 | 1.0 | 0.90 | 0.42 |
| cursor | pointer | pointer | pointer | arrow |

## 添加新控件

1. 在 `controls/` 新建文件，用 `primitives/` 拼装
2. 在 `demo/` 建对应的 Demo 页
3. 不要改动 `primitives/` — 它们是稳定底层
