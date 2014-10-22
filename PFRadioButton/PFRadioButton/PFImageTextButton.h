//
//  PFImageTextButton.h
//  PFRadioButton
//
//  Created by PFei_He on 14-10-22.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PFImageTextButtonStateNormal,    //普通状态
    PFImageTextButtonStateSelected,  //选中状态
}PFImageTextButtonState;

@class PFImageTextButton;

@protocol PFImageTextButtonDelegate <NSObject>

/**
 *  @brief 点击事件
 */
- (void)didSelect:(PFImageTextButton *)button;

@end

@interface PFImageTextButton : UIView

///按钮文字
@property (nonatomic, copy)     NSString                        *text;

///按钮状态
@property (nonatomic, assign)   PFImageTextButtonState          state;

///代理
@property (nonatomic, weak)     id<PFImageTextButtonDelegate>   delegate;

/**
 *  @brief 设置按钮的尺寸
 *  @param imageFrame: 图片尺寸
 *  @param textFrame: 文字尺寸
 */
- (id)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame textFrame:(CGRect)textFrame;

/**
 * @brief 点击事件
 */
- (void)didSelect:(void (^)(PFImageTextButton *button))block;

@end
