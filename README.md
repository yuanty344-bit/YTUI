# YTUI — Components for Qt 6 QML

暗色玻璃质感 QML 组件库。

## 运行

```powershell
$env:PATH = "D:\Qt\6.11.1\mingw_64\bin;" + $env:PATH
qml Main.qml
```

或双击 `run.bat`，或 Qt Creator 打开 `YTUI.qmlproject` → `Ctrl+R`。

## 集成

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

```qml
YTButton {
    text:        "Play"
    iconSource:  "icons/play.svg"
    variant:     "primary"      // "primary" | "secondary" | "ghost"
    accentColor: YTTheme.accent
    enabled:     true
    loading:     false          // true → 呼吸脉冲
    width:       200            // 默认 200×60
    height:      60
    onClicked:   { /* ... */ }
}
```

### YTToggle

```qml
YTToggle {
    checked:     false
    accentColor: YTColors.blue
    enabled:     true
    onToggled:   function(c) { /* c = 新状态 */ }
}
```

### YTSlider

```qml
YTSlider {
    text:        "Volume"       // 标签
    from:        0
    to:          100
    value:       50
    valueSuffix: "%"
    accentColor: YTTheme.accent
    onMoved:     function(v) { /* v = 新值 */ }
}
```

## Token

| 文件 | 内容 |
|------|------|
| `YTTheme` | accent / elevation / shadow / disabled / breathe |
| `YTAnimation` | `micro` / `fast` / `normal` / `slow` |
| `YTColors` | pink / blue / purple / green / orange / cyan |

## 结构

```
YTUI/
├── Main.qml                   入口
├── run.bat                   双击运行
├── YTUI.qmlproject           Qt Creator 项目
├── README.md
│
├── controls/                  组合控件
│   ├── YTButton.qml
│   ├── YTToggle.qml
│   └── YTSlider.qml
│
├── primitives/                视觉原子
│   ├── YTSurface.qml         4-stop 渐变 + 镜面高光
│   ├── YTShadow.qml          对角光源动态阴影
│   ├── YTRipple.qml          涟漪扩散
│   └── YTNoise.qml           噪点 dither
│
├── theme/                     设计 token
│   ├── YTTheme.qml
│   ├── YTAnimation.qml
│   └── YTColors.qml
│
├── demo/                      演示页
│   ├── ButtonDemo.qml
│   ├── ToggleDemo.qml
│   └── SliderDemo.qml
│
└── assets/
    ├── noise.png
    └── icons/                 SVG 简笔画图标
```
