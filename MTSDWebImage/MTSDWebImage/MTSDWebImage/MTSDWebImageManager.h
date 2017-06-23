//
//  MTSDWebImageManager.h
//  MTSDWebImage
//
//  Created by user on 2017/6/23.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MTSDWebImageManager : NSObject
//单例
+ (instancetype)shareManager;


/**
 单利下载主方法

 @param URLString 图片路径
 @param completionBlock 下载完成的回调
 */
- (void)downLoadImageWithURLString:(NSString *)URLString comoletion:(void(^)(UIImage *image))completionBlock;

/**
 单利取消操作

 @param lastURLString 最后一个操作
 */
- (void)cancelLastOperation:(NSString *)lastURLString;

@end
