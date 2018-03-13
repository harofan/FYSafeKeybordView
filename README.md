# FYSafeKeybordView


## 前言

这是一个高可扩展性,使用简单的自定义安全键盘.利用工厂调用不同的类方法我们可以生产出相应的键盘,并且支持扩展,目前主要支持了数字和身份证键盘,每个键盘的UI调整也很简单,并且支持键盘没输入一个键,输出的字符串都可以加密.

### 集成方法

直接将`FYKeybord`文件夹整体拖入工程即可,明明都有前缀不会冲突.
需要导入`Masonry`框架以及实现一个能根据16进制自动转RGB颜色的方法以及一个屏幕宽度宏.
删除按钮的样式图片默认没有添加,如果需要请自行去`Resource`文件夹拖取.

### 使用方法

1.不考虑光标可以移动,只需要按顺序输入,删除则是从最后一位删除可以如此使用:

    FYNumberKeybordView *keybordView = [FYKeybordFactory fy_createNumberKeybordViewWithNumberPadType:randomNumberPadType];
    [self.view addSubview:keybordView];
    [keybordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@247);
    }];
    
这里需要注意的是该键盘需要手动实现`FYNumberKeybordView `的代理方法和frame,也没什么难的.

效果如下:

![效果](https://github.com/RPGLiker/FYSafeKeybordView/blob/master/resource/1.png)

2.考虑光标的移动,键盘的弹起替换就要用新的接口了,只需要这一行代码,如果你需要定制frame请去子类中修改:

    [FYKeybordFactory fy_createCursorNumberKeybordViewWithTargetTextfield:textField numberPadType:randomNumberPadType];
    
效果如下:

![效果](https://github.com/RPGLiker/FYSafeKeybordView/blob/master/resource/2.png)

3.身份证键盘和上面的使用方法类似:

    [FYKeybordFactory fy_createIDKeybordViewWithTargetTextField:textField];

效果如下:

![效果](https://github.com/RPGLiker/FYSafeKeybordView/blob/master/resource/3.png)

4.本demo是没有修改加密后的字符串的,如果你需要修改可以在`FYNumberPadModel`类的`secretNumberStr` GET 方法中进行添加