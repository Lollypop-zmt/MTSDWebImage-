//
//  DownLoadOperation.m
//  MTSDWebImage
//
//  Created by user on 2017/6/23.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "DownLoadOperation.h"

@implementation DownLoadOperation


//操作的入口, 默认异步执行
- (void)main{
    //NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"传入图片地址 = %@",_URLString);
    //下载图片
    NSURL *url = [NSURL URLWithString:_URLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    //图片下载结束后用block传到外界
    if(_finishedBlock){
        
        //回到主线程回调代码块
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
           
            _finishedBlock(image);
        }];
    }
    
}

@end
