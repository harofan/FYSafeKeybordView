//
//  FYNumberPadModel.m
//  CreditCat
//
//  Created by 范杨 on 2018/2/2.
//  Copyright © 2018年 luming. All rights reserved.
//

#import "FYNumberPadModel.h"

@interface FYNumberPadModel()
@property (copy, nonatomic, readwrite) NSString *keybordNumber;
@property (copy, nonatomic, readwrite) NSString *secretNumberStr;//加密规则需要制定
@end
@implementation FYNumberPadModel
- (instancetype)initWithKeybordNumber:(NSString *)keybordNumber{
    if (self = [super init]) {
        self.keybordNumber = keybordNumber;
    }
    return self;
}
- (NSString *)secretNumberStr{
    return self.keybordNumber;
}
@end
