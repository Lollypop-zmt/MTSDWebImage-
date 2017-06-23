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
    
    //自定义操作
    DownLoadOperation *op = [DownLoadOperation new];
    
    //操作加入队列
    [queue addOperation:op];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
