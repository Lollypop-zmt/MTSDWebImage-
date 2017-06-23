//
//  DownLoadOperation.m
//  MTSDWebImage
//
//  Created by user on 2017/6/23.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "DownLoadOperation.h"

@interface DownLoadOperation()

//接受外界传入的URL
@property(nonatomic,copy)NSString *URLString;

//回调block
@property(nonatomic,copy) void(^finishedBlock)(UIImage *iamge);


@end

@implementation DownLoadOperation

+ (instancetype)downLoadOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *))finishedBlock{
    
    DownLoadOperation *op = [DownLoadOperation new];
    //记录全局的图片地址
    op.URLString =  URLString;
    // 记录全局的回调代码块
    op.finishedBlock = finishedBlock;
    
    return op;
}


//操作的入口, 默认异步执行
- (void)main{
    //NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"传入图片地址 = %@",_URLString);
    //下载图片
    NSURL *url = [NSURL URLWithString:_URLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    //模拟网络延迟
    [NSThread sleepForTimeInterval:1.0];
    
    if(self.isCancelled == YES){
        NSLog(@"取消 = %@",self.URLString);
        return;
    }
    
    //图片下载结束后用block传到外界
    if(_finishedBlock){
        
        //回到主线程回调代码块
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"完成 = %@",self.URLString);
            
            _finishedBlock(image);
        }];
    }
    
}

@end
