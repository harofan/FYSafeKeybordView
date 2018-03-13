//
//  FYIDPadView.h
//  CreditCat
//
//  Created by 范杨 on 2018/3/12.
//  Copyright © 2018年 luming. All rights reserved.
//
#import <UIKit/UIKit.h>

@class FYIDPadView;
@protocol FYIDPadViewDelegate <NSObject>
//内部已经处理完毕,除非你有特殊需求否则不建议实现
@optional
- (void)fyIDKeybordView:(FYIDPadView *)idKeybordView clickIDNumberStr:(NSString *)clickIDNumberStr;
- (void)clickDeleteButtonWithFYIDKeybordView:(FYIDPadView *)idKeybordView;
@end
@interface FYIDPadView : UIView
@property (weak, nonatomic) id<FYIDPadViewDelegate>fyIDKeybordDelegate;
- (instancetype)initWithTargetTextField:(UITextField *)targetTextField;
@end
