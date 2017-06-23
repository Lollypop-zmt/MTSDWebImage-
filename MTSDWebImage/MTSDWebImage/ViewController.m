//
//  ViewController.m
//  MTSDWebImage
//
//  Created by user on 2017/6/23.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "DownLoadOperation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //准备队列
    NSOperationQueue *queue = [NSOperationQueue new];
    
    //准备下载图片
    NSString *URLString = @"http://paper.taizhou.com.cn/tzwb/res/1/2/2015-01/20/12/res03_attpic_brief.jpg";
    
    //自定义操作
    DownLoadOperation *op = [DownLoadOperation downLoadOperationWithURLString:URLString finished:^(UIImage *image) {
        NSLog(@"%@ %@",image,[NSThread currentThread]);
    }];
    
    //操作加入队列
    [queue addOperation:op];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
