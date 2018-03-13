//
//  FYCursorNumberKeybordView.h
//  CreditCat
//
//  Created by 范杨 on 2018/3/13.
//  Copyright © 2018年 luming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYKeybordEnumFile.h"

@class FYCursorNumberKeybordView;
@protocol FYCursorNumberKeybordViewDelegate <NSObject>
//内部已经处理完毕,除非你有特殊需求否则不建议实现
@optional
- (void)fyCursorNumberKeybordView:(FYCursorNumberKeybordView *)fyCursorNumberKeybordView clickNumberStr:(NSString *)clickNumberStr;
- (void)clickDeleteButtonWithFYCursorNumberKeybordView:(FYCursorNumberKeybordView *)fyCursorNumberKeybordView;
@end
@interface FYCursorNumberKeybordView : UIView
@property (weak, nonatomic) id<FYCursorNumberKeybordViewDelegate>fyCursorNumberKeybordViewDelegate;
- (instancetype)initWithTargetTextfield:(UITextField *)targetTextfield numberPadType:(FYNumberPadType)numberPadType;
@end
