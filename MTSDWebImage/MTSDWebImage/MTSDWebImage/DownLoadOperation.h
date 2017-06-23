//
//  DownLoadOperation.h
//  MTSDWebImage
//
//  Created by user on 2017/6/23.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DownLoadOperation : NSOperation



/**
 创建操作和下载图片的主要方法

 @param URLString 图片地址
 @param finishedBlock 下载结束后的回调
 @return 自定义的下载操作
 */
+ (instancetype)downLoadOperationWithURLString:(NSString *)URLString finished:(void(^)(UIImage *image))finishedBlock;

@end
