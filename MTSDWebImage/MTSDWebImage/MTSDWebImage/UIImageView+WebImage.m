//
//  UIImageView+WebImage.m
//  MTSDWebImage
//
//  Created by user on 2017/6/25.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import "MTSDWebImageManager.h"
#import <objc/runtime.h>
@implementation UIImageView (WebImage)

- (void)setLastURLString:(NSString *)lastURLString{
    
    // 关联对象 : 能够使分类的属性可以存存值
    /*
     1.要关联的对象
     2.要关联的对象的属性的key
     3.要关联的对象的属性的值
     4.要关联的对象的属性的存储的策略
     */
    objc_setAssociatedObject(self, @"key", lastURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (NSString *)lastURLString{
    
    return objc_getAssociatedObject(self, @"key");
}

- (void)mtsd_setImageWithURLSteing:(NSString *)urlString{
    
    // 在建立下载操作前,判断连续传入的图片地址是否一样,如果不一样,就把前一个下载操作取消掉
    if(![urlString isEqualToString:self.lastURLString] && self.lastURLString != nil){
        
        //单利接管取消操作
        [[MTSDWebImageManager shareManager] cancelLastOperation:self.lastURLString];
    }
    //记录上一次图片地址
    self.lastURLString = urlString;
    
    // 单例接管下载操作 : 取消操作失效(稍后进行封装)
    [[MTSDWebImageManager shareManager] downLoadImageWithURLString:urlString comoletion:^(UIImage *image) {
        self.image = image;
    }];

}

@end
