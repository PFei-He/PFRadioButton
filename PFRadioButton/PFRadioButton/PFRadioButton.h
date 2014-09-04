//
//  PFRadioButton.h
//  PFRadioButton
//
//  Created by PFei_He on 14-9-3.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFRadioButtonDelegate <NSObject>

/**
 *  @brief 实现按钮点击事件
 *  @param radioButton: 按钮
 *  @param textLabel: 文本
 *  @param index: 序号
 */
- (void)radioButton:(UIButton *)radioButton textLabel:(UILabel *)textLabel didSelectItemAtIndex:(NSInteger)index;

@end

@interface PFRadioButton : UIView

@property (nonatomic, weak) id<PFRadioButtonDelegate> delegate;

/**
 *  @brief 初始化单选按钮
 *  @param number: 按钮个数
 *  @param textArray: 文本数组
 */
- (id)initWithFrame:(CGRect)frame number:(NSUInteger)number textArray:(NSArray *)textArray;

/**
 *  @brief 实现按钮点击事件
 *  @param radioButton: 按钮
 *  @param textLabel: 文本
 *  @param index: 序号
 */
- (void)didSelectItemAtIndexUsingBlock:(void (^)(UIButton *radioButton, UILabel *textLabel, NSUInteger index))block;

@end
