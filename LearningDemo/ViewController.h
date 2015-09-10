//
//  ViewController.h
//  LearningDemo
//
//  Created by 李 俊 on 15/9/10.
//  Copyright (c) 2015年 李 俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *resultLb;
- (IBAction)operationAction:(id)sender;
- (IBAction)gcdAction:(id)sender;

@end

