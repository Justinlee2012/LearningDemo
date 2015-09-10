//
//  ViewController.m
//  LearningDemo
//
//  Created by 李 俊 on 15/9/10.
//  Copyright (c) 2015年 李 俊. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    imgUrlArr= @[@"http://www.qqzhi.com/uploadpic/2014-11-21/024451459.jpg",@"http://www.qq1234.org/uploads/allimg/140701/3_140701150032_5.jpg",@"http://qq1234.org/uploads/allimg/140701/3_140701153556_14.jpg",@"http://qq1234.org/uploads/allimg/140701/3_140701150032_16.png",@"http://qq1234.org/uploads/allimg/140701/3_140701150032_12.jpg",@"http://www.qq1234.org/uploads/allimg/140701/3_140701174657_13.jpg"];
    
    self.imgDoneNum=-1;
    
    [RACObserve(self, imgDoneNum) subscribeNext:^(id x) {
        if (((NSNumber *)x).intValue!=-1) {
            [self.resultLb setText:[NSString stringWithFormat:@"已经加载%@张图片,耗时%.3fS",x,tmpStartData==nil?0:[[NSDate date] timeIntervalSinceDate:tmpStartData]]];
        }
        else
        {
            [self.resultLb setText:@"请点击加载模式"];
        }
    }];
    
    RACSignal *btnSignal= [RACSignal combineLatest:@[RACObserve(self, imgDoneNum)] reduce:^(NSNumber *result){
        return @(result.intValue==6||result.intValue==-1);
    }];
    
    RAC(self.operationBtn,enabled) = btnSignal;
    RAC(self.gcdBtn,enabled) = btnSignal;

    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)downloadImage:(NSArray *)array
{
    UIImage * img;
    
    if (array.count==2) {
        if([[array objectAtIndex:0] isKindOfClass:[NSString class]]&&[[array objectAtIndex:1] isKindOfClass:[UIImageView class]])
        {
            NSString *url =[array objectAtIndex:0];
            UIImageView *imgView =[array objectAtIndex:1];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            img = [UIImage imageWithData:data];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [imgView setImage:img];
                self.imgDoneNum++;
            });
            
        }
    }
    else{
        return;
    }
}
-(void)cleanImgView
{
    tmpStartData = [NSDate date];
    self.imgDoneNum=0;
    self.imgView1.image=nil;
    self.imgView2.image=nil;
    self.imgView3.image=nil;
    self.imgView4.image=nil;
    self.imgView5.image=nil;
    self.imgView6.image=nil;
}
//NSOperation下载图片
- (IBAction)operationAction:(id)sender {
    
    [self cleanImgView];
    
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@[[imgUrlArr objectAtIndex:0],self.imgView1]];
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@[[imgUrlArr objectAtIndex:1],self.imgView2]];
    NSInvocationOperation *operation3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@[[imgUrlArr objectAtIndex:2],self.imgView3]];
    NSInvocationOperation *operation4 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@[[imgUrlArr objectAtIndex:3],self.imgView4]];
    NSInvocationOperation *operation5 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@[[imgUrlArr objectAtIndex:4],self.imgView5]];
    NSInvocationOperation *operation6 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@[[imgUrlArr objectAtIndex:5],self.imgView6]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
    [queue addOperation:operation5];
    [queue addOperation:operation6];
    
    
}
//GCD下载图片
- (IBAction)gcdAction:(id)sender {
    [self cleanImgView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self downloadImage:@[[imgUrlArr objectAtIndex:0],self.imgView1]];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self downloadImage:@[[imgUrlArr objectAtIndex:1],self.imgView2]];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self downloadImage:@[[imgUrlArr objectAtIndex:2],self.imgView3]];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self downloadImage:@[[imgUrlArr objectAtIndex:3],self.imgView4]];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self downloadImage:@[[imgUrlArr objectAtIndex:4],self.imgView5]];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self downloadImage:@[[imgUrlArr objectAtIndex:5],self.imgView6]];
    });
    
}
@end
