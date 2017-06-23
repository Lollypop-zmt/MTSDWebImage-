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

//接受外界传入的URL
@property(nonatomic,copy)NSString *URLString;

//回调block
@property(nonatomic,copy) void(^finishedBlock)(UIImage *iamge);

@end
