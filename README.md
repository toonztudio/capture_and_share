# capture_and_share

[![pub package](https://img.shields.io/pub/v/capture_and_share.svg)](https://pub.dev/packages/capture_and_share)

A Flutter plugin to take a screenshot using native code and share it via the platform's share image dialog. You can specify width, height and x, y position of the cropped screenshot. For now this plugin only works on ios.

<p align="center">
	<img src="https://github.com/toonztudio/capture_and_share/blob/master/resize.gif?raw=true" />
</p>

## Example

You can check example code in example folder.

```dart

import 'package:capture_and_share/capture_and_share.dart';

body: Center(
  child: RaisedButton(
    onPressed: () {
      CaptureAndShare.shareIt(
        sizeWidth: 300,
        sizeHeight: 300,
        xMode: 'center',
        yMode: 'center',
      );
    },
    child: Text('Click'),
  )

```

### Usage

It's only works on IOS only for now. I will come back to implement Android code soon.

### iOS

| Property     | Description                                                                                 | Type   |
| ------------ | ------------------------------------------------------------------------------------------- | ------ |
| `sizeWidth`  | desired cropped area width. if set this to 0 means whole screen width. Default is 0.        | double |
| `sizeHeight` | desired cropped area height. if set this to 0 means whole screen height. Default is 0.      | double |
| `xMode`      | Horizontal cropped mode. You can choose left, center or right for xMode. Default is center. | String |
| `yMode`      | Vertical cropped mode. You can choose top, center or bottom for yMode. Default is center.   | String |

## TODOs

- handle exceptions
- unit testing
- make it working on Android device

## Credits

thanks you screenshot_share_image (https://pub.dev/packages/screenshot_share_image) for inspiring me.
