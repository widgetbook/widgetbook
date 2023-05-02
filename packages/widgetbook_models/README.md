<img height=40 src="https://raw.githubusercontent.com/widgetbook/widgetbook/2107e1afe2217e8ecde56c6ade1fd3706c3e6570/docs/assets/WidgetbookLogo.svg">

[![Discord](https://img.shields.io/discord/879618555560218625?color=blue&style=flat-square)](https://discord.com/invite/zT4AMStAJA)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg?style=flat-square)](https://pub.dev/packages/very_good_analysis) 
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/widgetbook/widgetbook/widgetbook-models.yaml?branch=main)

This package features the models for the Widgetbook packages. The following packages use `widgetbook_models`:

- [package:widgetbook](https://pub.dev/packages/widgetbook)
- [package:widgetbook_annotation](https://pub.dev/packages/widgetbook_annotation)
- [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator)

Furthermore, the package contains predefined and commonly used devices.

> **NOTE**: It is not required to add this package to your project. [package:widgetbook_models](https://pub.dev/packages/widgetbook_models) was designed to make the classes defined accessible to the other packages. [package:widgetbook](https://pub.dev/packages/widgetbook) exports the classes defined in the package so you can use them without needing to import anything else than [package:widgetbook](https://pub.dev/packages/widgetbook). 

# Classes

## `Resolution`

A device's screen resolution is defined by the number of distinct pixels in each dimension that can be displayed. Furthermore, on Apple and Android devices, this resolution is divided into logical and native resolution by a scaling factor. Therefore, to define a resolution, the native amount of pixels in each dimension and a scaling factor is required. 

A `Resolution` instance is created by using

```dart
Resolution(
    nativeSize: DeviceSize(width: 1668, height: 2388),
    scaleFactor: 2,
),
```

`DeviceSize` is similar to `Size` from the Flutter SDK and contains properties for `width` and `height`.

## `Device`

The device class specifies a device like the *iPhone 12* based on a `name`, its `resolution` and its `type`. `type` is primarily used for better iconization in [package:widgetbook](https://pub.dev/packages/widgetbook)'s user interface.

An Apple iPhone 12 can be defined by using

```dart
Device iPhone12 = Device(
    name: 'iPhone 12',
    resolution: Resolution(
        nativeSize: DeviceSize(width: 1170, height: 2532),
        scaleFactor: 3,
    ),
    type: DeviceType.mobile,
);
```

### Device Types

The following device types exist and can be accessed with the respective `Device` constructor:

- `Device.mobile( ... )`
- `Device.tablet( ... )`
- `Device.desktop( ... )`
- `Device.watch( ... )`
- `Device.special( ... )`
    - used for screens with unusual apsect ratios.

These constructors allow you to create your own devices in case there is something missing in our collection of devices.

## `WidgetbookFrame`

The `WidgetbookFrame` represents a device frame wrapped around the `Widget`. The following frames are pre-defined:

- `WidgetbookFrame.defaultFrame`
- `WidgetbookFrame.noFrame`
- `WidgetbookFrame.deviceFrame`

# Collections

This package also features commonly used devices like various iPads, iPhone and Macs as well as Android devices like the Samsung Galaxy Series. 

The collections can be accessed by using the respective collection identifier. For instance:

```dart
Device iPhone11 = Apple.iPhone11;
```

The following collections exist:

Collection | Featured devices and screens
------------ | -------------
Apple | iPhone, iPad, iMac, MacBook, Pro Display XDR  
Samsung | Galaxy Series
Desktop | HD (1080p), 2K (1440p), 4K (2180p)

The specified identifiers of the collections are easily accessible via IntelliSense. 

# Let us know how you feel about Widgetbook

We are funded and aim to shape `Widgetbook` to your (and your team's) needs. If you have questions, feature requests or issues let us know on [Discord](https://discord.gg/zT4AMStAJA) or [GitHub](https://github.com/widgetbook/widgetbook). We're looking forward to build a community and discuss your feedback on our channel! 💙
