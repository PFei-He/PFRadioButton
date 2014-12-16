//
//  PFRadioButton.m
//  PFRadioButton
//
//  Created by PFei_He on 14-9-3.
//  Copyright (c) 2014年 PF-Lib. All rights reserved.
//
//  https://github.com/PFei-He/PFRadioButton
//
//  vesion: 0.1.0
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "PFRadioButton.h"
#import "PFMixButton.h"

static const NSMutableArray *radioButtonCount;
static const NSMutableArray *titleCount;

typedef void (^tapBlock)(NSString *, NSUInteger);

@interface PFRadioButton ()
{
    PFMixButton *radioButton;  //单选按钮
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
        titleCount = [[NSMutableArray alloc] init];

        for (int i = 0; i < number; i++) {//创建按钮和文本
            radioButton = [[PFMixButton alloc] initWithFrame:CGRectMake(0, self.bounds.origin.y + i * 25, 200, 15) imageFrame:CGRectMake(0, 0, 14, 14) textFrame:CGRectMake(15, 0, 200, 15)];
            radioButton.text = textArray[i];
            radioButton.tag = i;
            if (i == 0) radioButton.selected = YES;
            [radioButton didSelect:^(PFMixButton *button) {
                [self buttonTap:button];
            }];
            [radioButtonCount addObject:radioButton];
            [titleCount addObject:textArray[i]];
            [self addSubview:radioButton];
        }
    }
    return self;
}

#pragma mark - Events Methods

//点击事件
- (void)buttonTap:(PFMixButton *)button
{
    if ([self.delegate respondsToSelector:@selector(radioButtonTitle:didSelectItemAtIndex:)]) {//监听代理并回调
        [self.delegate radioButtonTitle:titleCount[button.tag] didSelectItemAtIndex:button.tag];
    } else if (self.tapBlock) {//监听块并回调
        self.tapBlock(titleCount[button.tag], button.tag);
    }

    for (int i = 0; i < radioButtonCount.count; i++) {//获取被点击的按钮
        PFMixButton *button = [radioButtonCount objectAtIndex:i];
        button.selected = NO;
    }
    button.selected = YES;
}

#pragma mark - Public Methods

//获取按钮点击
- (void)didSelectItemAtIndexUsingBlock:(void (^)(NSString *, NSUInteger))block
{
    if (block) self.tapBlock = block, block = nil;
}

#pragma mark - Memory Management

- (void)dealloc
{
#if __has_feature(objc_arc)
    self.tapBlock = nil;

    self.delegate = nil;
#else
#endif
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
