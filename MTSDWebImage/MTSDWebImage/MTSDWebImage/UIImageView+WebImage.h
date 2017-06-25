//
//  UIImageView+WebImage.h
//  MTSDWebImage
//
//  Created by user on 2017/6/25.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImage)

//分类定义属性要手动关联
@property(nonatomic,copy)NSString *lastURLString;

- (void)mtsd_setImageWithURLSteing:(NSString *)urlString;

@end
