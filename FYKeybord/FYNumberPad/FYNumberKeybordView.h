//
//  FYNumberKeybordView.h
//  CreditCat
//
//  Created by 范杨 on 2018/2/2.
//  Copyright © 2018年 luming. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "FYKeybordEnumFile.h"

@class FYNumberKeybordView;
@protocol FYNumberKeybordViewDelegate <NSObject>
@required
- (void)fyNumberKeybordView:(FYNumberKeybordView *)numberKeybordView clickNumberStr:(NSString *)clickNumberStr;
- (void)clickDeleteButtonWithFYNumberKeybordView:(FYNumberKeybordView *)numberKeybordView;
@end
@interface FYNumberKeybordView : UIView
@property (weak, nonatomic) id<FYNumberKeybordViewDelegate>fyNumberKeybordDelegate;
- (instancetype)initWithNumberPadType:(FYNumberPadType)numberPadType;
@end
