![](NKOActivityIndicatorView/Images.xcassets/AppIcon.appiconset/Icon-76.png)  

# NKOActivityIndicatorView
A [Lyst.com](http://www.lyst.com) lookalike activity indicator for iOS.


## Installation

The best way to integrate NKOActivityIndicatorView in your project is with CocoaPods. You can find more info about this dependency manager [here](http://cocoapods.org). Just add the following line to your **Podfile**.

```
pod 'NKOActivityIndicatorView'
```

## How does it work

**NKOActivityIndicatorView** behaviour and public interface are very similar to `UIActivityIndicatorView` ones. If you have experience working with it then you will make this component run in a couple of minutes (literally).

This example shows how to programmatically create and animate the component.
```
CGRect frame = CGRectMake(0.f, 0.f, 32.f, 32.f);

NKOActivityIndicatorView *activityIndicator = [[NKOActivityIndicatorView alloc] initWithFrame:frame];

[self.view addSubview:activityIndicator];

[activityIndicator startAnimating];
```

Simple, right?

## Customization

Unlike `UIActivityIndicatorView`, **NKOActivityIndicatorView** allows you to customize different visual attributes:
- color: sets the color of the line path.
- lineWidth: sets the line width of the line path.
- animationDuration (TODO): sets the duration of single loop iteration.
- hidesWhenStopped: calls view's setHidden when the animation is stopped.

## Example project

To help you understand a bit more how the component works you can clone this repository and try the example project.

# Screenshots

### iPhone

![Animation](/Screenshots/3.gif)

![First screenshot](/Screenshots/1.png)

![Second screenshot](/Screenshots/2.png)

# License

The MIT License (MIT)

Copyright (C) 2015 Carlos Vidal

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without
limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
OR OTHER DEALINGS IN THE SOFTWARE LICENSE
