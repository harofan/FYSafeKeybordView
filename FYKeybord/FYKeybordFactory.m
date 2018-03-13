//
//  FYKeybordFactory.m
//  CreditCat
//
//  Created by 范杨 on 2018/3/12.
//  Copyright © 2018年 luming. All rights reserved.
//

#import "FYKeybordFactory.h"

@implementation FYKeybordFactory
+ (FYNumberKeybordView *)fy_createNumberKeybordViewWithNumberPadType:(FYNumberPadType)numberPadType{
    return [[FYNumberKeybordView alloc] initWithNumberPadType:numberPadType];
}

+ (FYIDPadView *)fy_createIDKeybordViewWithTargetTextField:(UITextField *)targetTextField{
    return [[FYIDPadView alloc] initWithTargetTextField:targetTextField];
}

+ (FYCursorNumberKeybordView *)fy_createCursorNumberKeybordViewWithTargetTextfield:(UITextField *)targetTextfield numberPadType:(FYNumberPadType)numberPadType{
    return [[FYCursorNumberKeybordView alloc] initWithTargetTextfield:targetTextfield numberPadType:numberPadType];
}
@end

