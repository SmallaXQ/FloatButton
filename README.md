# FloatButton

自定义悬浮按钮，可随手势在屏幕任意位置滑动，类似于苹果手机自带辅助触控按钮！

## Requirements

- iOS 8.0+
- Swift 5.0

## Installation

Install with CocoaPods:

1. Add `pod 'FloatButton'` to your Podfile. 
2. Run `pod install` or `pod update`.

## How to use

```
// 布局用到了snpKit，用的时候依据项目本身修改即可
let floatButton = FloatButton(bgColor: UIColor.orange, titleOfButton: "测试")
        firstWindow?.addSubview(floatButton)
        floatButton.singleClickCallback = { [weak self] in
            self?.singleClick()
        }
        floatButton.snp.makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.equalTo(20)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
// 自定义block回调点击事件       
func singleClick() {
    debugPrint("点击事件调用Success!")
}
```

## Author

如有疑问，欢迎联系：smallaxq@gmail.com

## License

FloatButton is available under the MIT license. See the LICENSE file for more info.
