//
//  PFRadioButton.m
//  PFRadioButton
//
//  Created by PFei_He on 14-9-3.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import "PFRadioButton.h"

static const NSUInteger kRadioButtonWidth = 22;
static const NSUInteger kRadioButtonHeight = 22;

static const NSMutableArray *radioButtonCount;
static const NSMutableArray *textLabelCount;

typedef void (^tapBlock)(UIButton *, UILabel *, NSUInteger);

@interface PFRadioButton ()
{
    UIButton *radioButton;  //按钮
    UILabel *textLabel;     //文本
}

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
        textLabelCount = [[NSMutableArray alloc] init];

        for (int i = 0; i < number; i++) {//创建按钮和文本
            radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
            radioButton.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + i * 25, kRadioButtonWidth, kRadioButtonHeight);
            radioButton.adjustsImageWhenHighlighted = NO;
            [radioButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"images.bundle/RadioButton-Normal" ofType:@"png"]] forState:UIControlStateNormal];
            [radioButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"images.bundle/RadioButton-Selected" ofType:@"png"]] forState:UIControlStateSelected];
            radioButton.tag = i;
            if (i == 0) radioButton.selected = YES;
            [radioButton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            [radioButtonCount addObject:radioButton];
            [self addSubview:radioButton];

            textLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRadioButtonWidth, radioButton.frame.origin.y, self.bounds.size.width - kRadioButtonWidth - 5, radioButton.frame.size.height)];
            textLabel.text = [NSString stringWithFormat:textArray[i], nil];
            [textLabelCount addObject:textLabel];
            [self addSubview:textLabel];
        }
    }
    return self;
}

#pragma mark - Events Methods

//按钮点击事件
- (void)buttonTap:(UIButton *)button
{
    if (!self.delegate && self.tapBlock) {//监听块并回调
        self.tapBlock(radioButton, textLabelCount[button.tag], button.tag);
    } else if ([self.delegate respondsToSelector:@selector(radioButton:textLabel:didSelectItemAtIndex:)]) {//监听代理并回调
        [self.delegate radioButton:radioButton textLabel:textLabelCount[button.tag] didSelectItemAtIndex:button.tag];
    }

    for (int i = 0; i < radioButtonCount.count; i++) {//获取被点击的按钮
        UIButton *button = [radioButtonCount objectAtIndex:i];
        button.selected = NO;
    }
    button.selected = YES;
}

#pragma mark - Public Methods

//获取按钮点击
- (void)didSelectItemAtIndexUsingBlock:(void (^)(UIButton *, UILabel *, NSUInteger))block
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
