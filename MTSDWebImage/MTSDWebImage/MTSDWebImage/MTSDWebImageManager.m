//
//  MTSDWebImageManager.m
//  MTSDWebImage
//
//  Created by user on 2017/6/23.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "MTSDWebImageManager.h"
#import "DownLoadOperation.h"
#import "NSString+path.h"
@interface MTSDWebImageManager()

//全局队列
@property(nonatomic,strong)NSOperationQueue *queue;
//操作缓存池
@property(nonatomic,strong)NSMutableDictionary *opCaChe;
//图片缓存池
@property(nonatomic,strong)NSMutableDictionary *imageCaChe;

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
        //实例化
        self.queue = [NSOperationQueue new];
        self.opCaChe = [NSMutableDictionary new];
        self.imageCaChe = [NSMutableDictionary new];
    }
    return self;
}

- (void)downLoadImageWithURLString:(NSString *)URLString comoletion:(void (^)(UIImage *))completionBlock{
    
    //在下载图片前判断是否存在缓存(图片+沙盒)
    if([self checkCaChe:URLString]){
        if(completionBlock != nil){
            completionBlock([self.imageCaChe objectForKey:URLString]);
            return;
        }
        
    }
    
    
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
        
        //下载完成后内存缓存
        if(image != nil){
            [self.imageCaChe setObject:image forKey:URLString];
        }
        
        //下载完成后移除对应的操作
        [self.opCaChe removeObjectForKey:URLString];
    }];
    
    //把操作添加到操作缓存池
    [self.opCaChe setObject:op forKey:URLString];
    //操作加入队列
    [self.queue addOperation:op];
    
}


- (BOOL)checkCaChe:(NSString *)URLString{
    //判断内存缓存
    if([self.imageCaChe objectForKey:URLString]){
        NSLog(@"从内存中加载...");
        return YES;
    }
    
    //判断沙盒缓存
    //加载沙盒图片
    UIImage *imageCaChe = [UIImage imageWithContentsOfFile:[URLString appendCachePath]];
    if(imageCaChe != nil){
        NSLog(@"从沙盒中加载...");
        [self.imageCaChe setObject:imageCaChe forKey:URLString];
        return YES;
    }
    
    return NO;
}

- (void)cancelLastOperation:(NSString *)lastURLString{
    
    //取出上一个图片的下载操作,用cancel取消掉
    DownLoadOperation *lastQueue = [self.opCaChe objectForKey:lastURLString];
    [lastQueue cancel];
    //取消掉的操作从操作缓存池中移除
    [self.opCaChe removeObjectForKey:lastURLString];
    
    
}

@end
