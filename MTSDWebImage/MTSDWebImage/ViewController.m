//
//  ViewController.m
//  MTSDWebImage
//
//  Created by user on 2017/6/23.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "DownLoadOperation.h"
#import "AFNetworking.h"
#import "APPModel.h"
#import "YYModel.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property(nonatomic,strong)NSArray *appList;
@property(nonatomic,strong)NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //准备队列
     self.queue = [NSOperationQueue new];
    
    
    [self loadData];
    
}

// 测试DownloadOperation : 点击屏幕,随机获取图片的地址,交给DownloadOperation去下载
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取随机图片地址
    int random = arc4random_uniform((uint32_t)self.appList.count);
    //获取随机模型
    APPModel *model = self.appList[random];
    
//    //准备下载图片
//    NSString *URLString = @"http://paper.taizhou.com.cn/tzwb/res/1/2/2015-01/20/12/res03_attpic_brief.jpg";
//    
    //自定义操作
    DownLoadOperation *op = [DownLoadOperation downLoadOperationWithURLString:model.icon finished:^(UIImage *image) {
       // NSLog(@"%@ %@",image,[NSThread currentThread]);
        self.iconImageView.image = image;
        
    }];
    
    //操作加入队列
    [self.queue addOperation:op];

    
}

// 获取JSON数据 : 测试DownloadOperation的数据的来源,拿到数据后再去点击屏幕
- (void)loadData {
    
    NSString *URLString = @"https://raw.githubusercontent.com/zhangxiaochuZXC/SHHM06/master/apps.json";
    
    [[AFHTTPSessionManager manager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // AFN会自动的JSON数据进行反序列化 : responseObject就是JSON反序列化完成后的结果
        NSArray *dictArr = responseObject;
        self.appList = [NSArray yy_modelArrayWithClass:[APPModel class] json:dictArr];
        NSLog(@"%@",self.appList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
