# Tools
一个开发中肯定能用到工具类，包括各种类扩展，一些小功能封装，以及一些动画封装

## 果冻效果（Animation/YCJellyView）
- 直接把YCJellyView添加到想要实现此功能的视图即可

  ![](./Sources/jellyView.gif)

## 弹框提示工具类
- 直接调用类方法 `+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message presentedBy:(id)object itemClickCallBack:(void (^)(NSString *title))callBack cancelTitle:(NSString *)cancelTitle otherTitles:(NSString *)title1,...`
  - title 标题
  - message 信息
  - object 从哪个对象弹出，传空或者传非controller对象，就从keyWindow的根控制器弹出
  - callBack 点击按钮的回调，参数是所点击的按钮的标题
  - cancelTitle 取消按钮标题，取消按钮是最底端按钮，且颜色与其他按钮不一样
  - title1 其他按钮，可以传多个值，以nil结尾

## 颜色相关工具类（UIColor的扩展）
- 传入十六进制的颜色值，返回UIColor对象`+(nonnull instancetype)yc_colorWithHex:(u_int32_t)hex`
- 传入0～255的颜色值，返回UIColor对象`+(nonnull instancetype)yc_colorWithRed:(u_int8_t)red green:(u_int8_t)green blue:(u_int8_t)blue` 
- 生成随机颜色`+(nonnull instancetype)yc_randomColor`

## 表情键盘视图(Swift)
- 自定义YCEmoticonView继承自UIView,使用时，导入YCEmoticonView文件夹到你的工程目录，设置textView.inputView为YCEmoticonView对象，并将textView作为参数传入
- 需要自定义表情素材时，直接修改YCEmoticonView文件夹下的bundle里面的plist文件和导入想入相应表情素材
- 模块里面的表情包括自定义表情与emoji表情
- 模块依赖SnpKit框架
- 写的比较匆忙，后续再格式化代码并完善功能...

![](./Sources/emoticonView.gif)
