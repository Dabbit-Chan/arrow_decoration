# Animated Path

A Decoration that generates an arrow shape

## Showcase
https://raw.githubusercontent.com/Dabbit-Chan/animated_path/main/gifs/LissajousCase.gif
<img src="https://raw.githubusercontent.com/Dabbit-Chan/arrow_decoration/master/gifs/ArrowDecorationCase.gif" width=60%>

## Getting started

`import 'package:arrow_decoration/arrow_decoration.dart';`

## Usage

Here is a minimalist example.

```dart
Container(
  width: 200,
  height: 200,
  decoration: ArrowDecoration(
    bgColor: Colors.pink,
    lineColor: Colors.green,
    lineWidth: 10,
    borderRadius: BorderRadius.circular(10),
    arrowSize: const Size(50, 50),
  ),
)
```
The library also provides `ArrowClipper` and `arrowPath()` for flexible use.

Check [example](https://github.com/Dabbit-Chan/arrow_decoration/tree/master/example) for more.
