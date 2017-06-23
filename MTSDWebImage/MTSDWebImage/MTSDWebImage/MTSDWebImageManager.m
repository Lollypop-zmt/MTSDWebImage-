//
//  MTSDWebImageManager.m
//  MTSDWebImage
//
//  Created by user on 2017/6/23.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "MTSDWebImageManager.h"
#import "DownLoadOperation.h"
@interface MTSDWebImageManager()

//全局队列
@property(nonatomic,strong)NSOperationQueue *queue;
//操作缓存池
@property(nonatomic,strong)NSMutableDictionary *opCaChe;


@end

@implementation MTSDWebImageManager

//单例
+ (instancetype)shareManager{
    
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    
    return instance;
}

- (instancetype)init{
    if(self = [super init]){
        self.queue = [NSOperationQueue new];
        self.opCaChe = [NSMutableDictionary new];
    }
    return self;
}

- (void)downLoadImageWithURLString:(NSString *)URLString comoletion:(void (^)(UIImage *))completionBlock{
    
    // 在建立下载操作前,判断要建立的下载操作是否存在,如果存在,就不要再建立重复的下载操作
    if([self.opCaChe objectForKey:URLString] != nil){
        return;
    }
    //自定义操作 获取随机的图片地址,交给DownloadOperation去下载
    DownLoadOperation *op = [DownLoadOperation downLoadOperationWithURLString:URLString finished:^(UIImage *image) {
        
        // 单例把拿到的图片对象回调给VC
        if(completionBlock){
            completionBlock(image);
        }
        
        //下载完成后移除对应的操作
        [self.opCaChe removeObjectForKey:URLString];
    }];
    
    //把操作添加到操作缓存池
    [self.opCaChe setObject:op forKey:URLString];
    //操作加入队列
    [self.queue addOperation:op];
    

    
}

@end
