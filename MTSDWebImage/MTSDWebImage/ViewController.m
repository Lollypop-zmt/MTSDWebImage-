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
//控件
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//数据源
@property(nonatomic,strong)NSArray *appList;
//全局队列
@property(nonatomic,strong)NSOperationQueue *queue;
//操作缓存池
@property(nonatomic,strong)NSMutableDictionary *opCaChe;

//记录上一次的图片地址
@property(nonatomic,strong)NSString *lastURLString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //准备队列
     self.queue = [NSOperationQueue new];
    
    //实例化操作缓存池
    self.opCaChe = [[NSMutableDictionary alloc] init];
    
    [self loadData];
    
}

// 测试DownloadOperation : 点击屏幕,随机获取图片的地址,交给DownloadOperation去下载
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取随机图片地址
    int random = arc4random_uniform((uint32_t)self.appList.count);
    //获取随机模型
    APPModel *model = self.appList[random];
    
    // 在建立下载操作前,判断连续传入的图片地址是否一样,如果不一样,就把前一个下载操作取消掉
    if(![model.icon isEqualToString:self.lastURLString] && self.lastURLString != nil){
        //取出上一个图片的下载操作,用cancel取消掉
        DownLoadOperation *lastQueue = [self.opCaChe objectForKey:_lastURLString];
        [lastQueue cancel];
        //取消掉的操作从操作缓存池中移除
        [self.opCaChe removeObjectForKey:_lastURLString];
    }
    //记录上一次图片地址
    _lastURLString = model.icon;
    
    //自定义操作 获取随机的图片地址,交给DownloadOperation去下载
    DownLoadOperation *op = [DownLoadOperation downLoadOperationWithURLString:model.icon finished:^(UIImage *image) {
       // NSLog(@"%@ %@",image,[NSThread currentThread]);
        self.iconImageView.image = image;
        
        //下载完成后移除对应的操作
        [self.opCaChe removeObjectForKey:model.icon];
    }];
    
    //把操作添加到操作缓存池
    [self.opCaChe setObject:op forKey:model.icon];
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
