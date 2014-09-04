//
//  RootVC.m
//  PFRadioButton
//
//  Created by PFei_He on 14-9-3.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import "RootVC.h"
#import "PFRadioButton.h"

@interface RootVC ()

@end

@implementation RootVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    PFRadioButton *rb = [[PFRadioButton alloc] initWithFrame:CGRectMake(0, 50, 320, 80) number:3 textArray:@[@"abc", @"123", @"一二三"]];
    [rb didSelectItemAtIndexUsingBlock:^(UIButton *radioButton, UILabel *textLabel, NSUInteger index) {
        NSLog(@"%@%d", textLabel.text, index);
    }];
    [self.view addSubview:rb];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end