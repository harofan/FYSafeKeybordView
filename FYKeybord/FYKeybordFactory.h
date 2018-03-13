//
//  FYKeybordFactory.h
//  CreditCat
//
//  Created by 范杨 on 2018/3/12.
//  Copyright © 2018年 luming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYNumberKeybordView.h"//数字键盘
#import "FYIDPadView.h"//光标身份证键盘
#import "FYCursorNumberKeybordView.h"//光标数字键盘

@interface FYKeybordFactory : NSObject

/**
 创建数字键盘(不需要管光标的情况下,且需要自己实现相应的代理)
 */
+ (FYNumberKeybordView *)fy_createNumberKeybordViewWithNumberPadType:(FYNumberPadType)numberPadType;

/**
 创建数字键盘(需要管光标的情况下,不需要自己实现相应的代理)
 */
+ (FYCursorNumberKeybordView *)fy_createCursorNumberKeybordViewWithTargetTextfield:(UITextField *)targetTextfield numberPadType:(FYNumberPadType)numberPadType;

/**
 创建身份证键盘(光标需要控制,调用者不需要主动实现代理,只需要在textfield实现系统的代理就可以拿到输入框的内容)
 */
+ (FYIDPadView *)fy_createIDKeybordViewWithTargetTextField:(UITextField *)targetTextField;
@end

