//
//  PFRadioButton.m
//  PFRadioButton
//
//  Created by PFei_He on 14-9-3.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import "PFRadioButton.h"

static const NSUInteger kRadioButtonHeight = 22;

static const NSMutableArray *radioButtonCount;
static const NSMutableArray *titleCount;

typedef void (^tapBlock)(NSString *, NSUInteger);

@interface PFRadioButton ()

///点击事件
@property (nonatomic, copy) tapBlock tapBlock;

@end

@implementation PFRadioButton

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame number:(NSUInteger)number textArray:(NSArray *)textArray
{
    self = [super initWithFrame:frame];
    if (self) {
        radioButtonCount = [[NSMutableArray alloc] init];
        titleCount = [[NSMutableArray alloc] init];

        for (int i = 0; i < number; i++) {//创建按钮和文本
            _radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _radioButton.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + i * 25, frame.size.width, kRadioButtonHeight);

            //高亮状态下是否点击一下就取消点击效果（此处为选中效果，故此属性无效）
//            radioButton.adjustsImageWhenHighlighted = NO;

            //正常
            [_radioButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"images.bundle/RadioButton-Normal" ofType:@"png"]] forState:UIControlStateNormal];
            [_radioButton setTitle:textArray[i] forState:UIControlStateNormal];
            [_radioButton setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];

            //选中
            [_radioButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"images.bundle/RadioButton-Selected" ofType:@"png"]] forState:UIControlStateSelected];
            [_radioButton setTitle:textArray[i] forState:UIControlStateSelected];
            [_radioButton setTitleColor:[UIColor cyanColor] forState:UIControlStateSelected];

            //按钮内容居左显示（默认为居中）
            _radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

            _radioButton.titleLabel.font = [UIFont systemFontOfSize:15];
            _radioButton.tag = i;
            if (i == 0) _radioButton.selected = YES;
            [_radioButton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            [radioButtonCount addObject:_radioButton];
            [titleCount addObject:textArray[i]];
            [self addSubview:_radioButton];
        }
    }
    return self;
}

#pragma mark - Events Methods

//按钮点击事件
- (void)buttonTap:(UIButton *)button
{
    if (!self.delegate && self.tapBlock) {//监听块并回调
        self.tapBlock(titleCount[button.tag], button.tag);
    } else if ([self.delegate respondsToSelector:@selector(radioButtonWithTitle:didSelectItemAtIndex:)]) {//监听代理并回调
        [self.delegate radioButtonWithTitle:titleCount[button.tag] didSelectItemAtIndex:button.tag];
    }

    for (int i = 0; i < radioButtonCount.count; i++) {//获取被点击的按钮
        UIButton *button = [radioButtonCount objectAtIndex:i];
        button.selected = NO;
    }
    button.selected = YES;
}

#pragma mark - Public Methods

//获取按钮点击
- (void)radioButtonWithTitleDidSelectItemAtIndexUsingBlock:(void (^)(NSString *, NSUInteger))block
{
    if (block) self.tapBlock = block, block = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
