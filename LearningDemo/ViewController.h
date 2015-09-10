//
//  ViewController.h
//  LearningDemo
//
//  Created by 李 俊 on 15/9/10.
//  Copyright (c) 2015年 李 俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSArray *imgUrlArr;
    NSDate* tmpStartData;
}
@property (weak, nonatomic) IBOutlet UILabel *resultLb;
- (IBAction)operationAction:(id)sender;
- (IBAction)gcdAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView4;
@property (weak, nonatomic) IBOutlet UIImageView *imgView5;
@property (weak, nonatomic) IBOutlet UIImageView *imgView6;
@property (weak, nonatomic) IBOutlet UIButton *operationBtn;
@property (weak, nonatomic) IBOutlet UIButton *gcdBtn;
@property (assign, nonatomic) int imgDoneNum;
@end

