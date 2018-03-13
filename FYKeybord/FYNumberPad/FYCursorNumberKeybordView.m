//
//  FYCursorNumberKeybordView.m
//  CreditCat
//
//  Created by 范杨 on 2018/3/13.
//  Copyright © 2018年 luming. All rights reserved.
//

#import "FYCursorNumberKeybordView.h"
#import "FYNumberPadModel.h"

@interface FYCursorNumberKeybordView()
/**
 目标输入框
 */
@property (strong, nonatomic) UITextField *targetTextField;
@end
@implementation FYCursorNumberKeybordView{
    NSArray *_dataArray;
}

- (instancetype)initWithTargetTextfield:(UITextField *)targetTextfield numberPadType:(FYNumberPadType)numberPadType{
    if (self = [super init]) {
        _targetTextField = targetTextfield;
        //替换键盘
        targetTextfield.inputView = self;
        switch (numberPadType) {
            case normalNumberPadType:
                _dataArray = [self p_createKeybordData];
                [self initNumberKeybordUIWithDataArray:_dataArray];
                break;
            case randomNumberPadType:
                _dataArray = [self p_getRandomArray:[self p_createKeybordData]];
                [self initNumberKeybordUIWithDataArray:_dataArray];
                break;
        }
        self.frame = CGRectMake(0, 0, ScreenWidth, 247);
        [targetTextfield becomeFirstResponder];
    }
    return self;
}

- (void)initNumberKeybordUIWithDataArray:(NSArray<FYNumberPadModel*> *)dataArray{
    self.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.centerX.equalTo(self.mas_centerX);
    }];
    tipLabel.textColor = [UIColor colorWithHexString:@"999999"];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.text = @"安全加密数字键盘";
    
    //键盘容器
    UIView *keybordContainerView = [[UIView alloc] init];
    [self addSubview:keybordContainerView];
    [keybordContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(8);
        make.left.right.bottom.equalTo(@0);
    }];
    keybordContainerView.backgroundColor = [UIColor clearColor];
    
    CGFloat const itemWidth = ScreenWidth/3.f;
    CGFloat const itemHeight = 219/4.f;
    
    //键盘布局
    for (int i = 0; i < dataArray.count; i ++) {
        UIButton *numberPadButton = [[UIButton alloc] init];
        [keybordContainerView addSubview:numberPadButton];
        CGFloat numberPadButtonX = i % 3 * itemWidth;
        CGFloat numberPadButtonY = i / 3 *itemHeight;
        if (i == dataArray.count - 1) {
            numberPadButtonX += itemWidth;
        }
        numberPadButton.frame = CGRectMake(numberPadButtonX, numberPadButtonY, itemWidth, itemHeight);
        numberPadButton.backgroundColor = [UIColor whiteColor];
        FYNumberPadModel *model = dataArray[i];
        [numberPadButton setTitle:model.keybordNumber forState:UIControlStateNormal];
        [numberPadButton setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        numberPadButton.titleLabel.font = [UIFont systemFontOfSize:24];
        numberPadButton.tag = i;
        [numberPadButton addTarget:self action:@selector(didClickNumberButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //删除按钮
    UIButton *deleteButton = [[UIButton alloc] init];
    [keybordContainerView addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(@0);
        make.width.equalTo(@(itemWidth));
        make.height.equalTo(@(itemHeight));
    }];
    [deleteButton setImage:[UIImage imageNamed:@"icon_kb_del"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(didClickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat const lineWidth = 1;
    //横线
    for (int i = 0; i < 3; i ++) {
        CGFloat horizontalLineViewX = 0;
        CGFloat horizontalLineViewY = i *itemHeight + itemHeight;
        UIView *horizontalLineView = [[UIView alloc] init];
        horizontalLineView.frame = CGRectMake(horizontalLineViewX, horizontalLineViewY, ScreenWidth, lineWidth);
        horizontalLineView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        [keybordContainerView addSubview:horizontalLineView];
    }
    
    //纵线
    for (int i = 0; i < 2; i ++) {
        CGFloat verticalLineViewX = i *itemWidth + itemWidth;
        CGFloat verticalLineViewY = 0;
        UIView *verticalLineView = [[UIView alloc] init];
        verticalLineView.frame = CGRectMake(verticalLineViewX, verticalLineViewY, lineWidth, 219);
        verticalLineView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        [keybordContainerView addSubview:verticalLineView];
    }
}
#pragma mark - target
- (void)didClickNumberButton:(UIButton *)button{
    FYNumberPadModel *model = _dataArray[button.tag];
    UITextRange *range = self.targetTextField.selectedTextRange;
    //确定光标位置
    NSInteger loc = [self.targetTextField offsetFromPosition:self.targetTextField.beginningOfDocument toPosition:self.targetTextField.selectedTextRange.start];
    
    //拼接字符串显示
    NSString *firstStr = [self.targetTextField.text substringToIndex:loc];
    NSString *secondStr = [self.targetTextField.text substringFromIndex:loc];
    self.targetTextField.text = [NSString stringWithFormat:@"%@%@%@",firstStr,model.secretNumberStr,secondStr];
    NSLog(@"%@=======%@",firstStr,secondStr);
    
    //输入完成后将光标保存在当前位置
    UITextPosition *start = [self.targetTextField positionFromPosition:range.end
                                                           inDirection:UITextLayoutDirectionRight
                                                                offset:1];
    if (start) {
        [self.targetTextField setSelectedTextRange:[self.targetTextField textRangeFromPosition:start toPosition:start]];
    }
    
    //代里传出
    if (_fyCursorNumberKeybordViewDelegate && [_fyCursorNumberKeybordViewDelegate respondsToSelector:@selector(fyCursorNumberKeybordView:clickNumberStr:)]) {
        [_fyCursorNumberKeybordViewDelegate fyCursorNumberKeybordView:self clickNumberStr:model.secretNumberStr];
    }
}

- (void)didClickDeleteButton{
    if (self.targetTextField.text.length > 0) {
        UITextRange *range = self.targetTextField.selectedTextRange;
        NSInteger loc = [self.targetTextField offsetFromPosition:self.targetTextField.beginningOfDocument toPosition:self.targetTextField.selectedTextRange.start];
        NSString *firstStr = [self.targetTextField.text substringToIndex:loc];
        NSString *secondStr = [self.targetTextField.text substringFromIndex:loc];
        //避免越界
        if (firstStr.length > 0) {
            //截取
            firstStr = [firstStr substringToIndex:firstStr.length - 1];
        }
        self.targetTextField.text = [NSString stringWithFormat:@"%@%@", firstStr, secondStr];
        
        //重新定位光标
        UITextPosition *start = [self.targetTextField positionFromPosition:range.start
                                                               inDirection:UITextLayoutDirectionLeft
                                                                    offset:1];
        if (start) {
            [self.targetTextField setSelectedTextRange:[self.targetTextField textRangeFromPosition:start toPosition:start]];
        }
        
        if (_fyCursorNumberKeybordViewDelegate && [_fyCursorNumberKeybordViewDelegate respondsToSelector:@selector(clickDeleteButtonWithFYCursorNumberKeybordView:)]) {
            [self.fyCursorNumberKeybordViewDelegate clickDeleteButtonWithFYCursorNumberKeybordView:self];
        }
    }
}

#pragma mark - private
- (NSArray *)p_getRandomArray:(NSArray *)originArray{
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithArray:originArray];
    NSMutableArray *randomArray = [NSMutableArray array];
    
    //随机次数
    NSInteger enumCount = dataArray.count;
    //随机池
    NSInteger randomPoolCount = enumCount;
    for (int i = 0; i < enumCount; i ++) {
        NSInteger randomIndex = (NSInteger)arc4random() % randomPoolCount;
        FYNumberPadModel *randomModel = dataArray[randomIndex];
        [dataArray removeObject:randomModel];
        [randomArray addObject:randomModel];
        randomPoolCount --;
    }
    
    return [randomArray copy];
}
- (NSArray <FYNumberPadModel *>*)p_createKeybordData{
    FYNumberPadModel *model1 = [[FYNumberPadModel alloc] initWithKeybordNumber:@"1"];
    FYNumberPadModel *model2 = [[FYNumberPadModel alloc] initWithKeybordNumber:@"2"];
    FYNumberPadModel *model3 = [[FYNumberPadModel alloc] initWithKeybordNumber:@"3"];
    
    FYNumberPadModel *model4 = [[FYNumberPadModel alloc] initWithKeybordNumber:@"4"];
    FYNumberPadModel *model5 = [[FYNumberPadModel alloc] initWithKeybordNumber:@"5"];
    FYNumberPadModel *model6 = [[FYNumberPadModel alloc] initWithKeybordNumber:@"6"];
    
    FYNumberPadModel *model7 = [[FYNumberPadModel alloc] initWithKeybordNumber:@"7"];
    FYNumberPadModel *model8 = [[FYNumberPadModel alloc] initWithKeybordNumber:@"8"];
    FYNumberPadModel *model9 = [[FYNumberPadModel alloc] initWithKeybordNumber:@"9"];
    
    FYNumberPadModel *model0 = [[FYNumberPadModel alloc] initWithKeybordNumber:@"0"];
    return @[model1, model2, model3, model4, model5, model6, model7, model8, model9, model0];
}


@end
