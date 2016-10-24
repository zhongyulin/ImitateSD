//
//  ViewController.m
//  仿SD加载图片demo
//
//  Created by 钟昱林 on 2016/10/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "DownloaderOperation.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "AppModel.h"
@interface ViewController ()

//队列
@property (strong, nonatomic) NSOperationQueue *queue;
//模型数组
@property (strong, nonatomic) NSArray *appList;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//操作缓存池
@property (strong, nonatomic) NSMutableDictionary *opCaches;
//记录上次图片的地址
@property (copy, nonatomic) NSString *lastURLstr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //实例化队列
    self.queue = [[NSOperationQueue alloc] init];
    
    //实例化操作缓存池
    self.opCaches = [[NSMutableDictionary alloc] init];
    
    //加载JSON数据
    [self loadJsonData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //创建变量保存随机数
    int random = arc4random_uniform((uint32_t)self.appList.count);
    
    //创建对象 随机获取
    AppModel *model = self.appList[random];
    
    //判断本次的图片地址与上次点击的图片的地址是否一样,如果不一样的话,则取消上次正在下载的操作
    if (![model.icon isEqualToString:self.lastURLstr] && self.lastURLstr != nil) {
        
        //取消上一次点击的图片 正在执行的下载的操作
        [[self.opCaches objectForKey:self.lastURLstr] cancel];
        
        //把操作从缓存池中移除
        [self.opCaches removeObjectForKey:self.lastURLstr];
    }
    
    //记录图片地址
    self.lastURLstr = model.icon;
    
    //创建操作
    DownloaderOperation *op = [DownloaderOperation downloadWithURLstr:model.icon successBlock:^(UIImage *image) {
        
        //刷新UI
        self.iconImageView.image = image;
        
        //图片下载完成后移除操作
        [self.opCaches removeObjectForKey:model.icon];
    }];
    
    //将创建的操作添加到操作缓存池中
    [self.opCaches setObject:op forKey:model.icon];
    
    //将操作添加到队列
    [self.queue addOperation:op];
    
}

#pragma mark - 获取JSON数据
- (void)loadJsonData
{
    //创建网络管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //加载数据
    [manager GET:@"https://raw.githubusercontent.com/zhongyulin/ServeFiler02/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@ -- %@",[responseObject class], responseObject);
        
        NSArray *dictArray = responseObject;
        
        //字典转模型
        self.appList = [NSArray yy_modelArrayWithClass:[AppModel class] json:dictArray];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 类方法自定义NSOperation
/*
- (void)demo2
{
    //实例化队列
    self.queue = [[NSOperationQueue alloc] init];
    
    //图片地址
    NSString *url = @"http://i1.t.hjfile.cn/ing_new/201305_2/376781a3-97c0-46a1-88c0-926579667f54_200X150.jpg";
    
    //回调的代码块
    void(^successBlock)() = ^(UIImage *image){
        
        NSLog(@"vc %@ -- %@", image, [NSThread currentThread]);
    };
    
    //实例化自定义操作
    DownloaderOperation *op = [DownloaderOperation downloadWithURLstr:url successBlock:successBlock];
    
    //将操作添加到队列
    [self.queue addOperation:op];
}
*/

#pragma mark - 对象方法自定义NSOperation
/*
- (void)demo1
{
    //实例化队列
    self.queue = [[NSOperationQueue alloc] init];
    
    //实例化操作
    DownloaderOperation *op = [[DownloaderOperation alloc] init];
    
    //自定义下载图片
    op.URLstr = @"http://i1.t.hjfile.cn/ing_new/201305_2/376781a3-97c0-46a1-88c0-926579667f54_200X150.jpg";
    
    //定义并回调代码块
    void(^successBlock)() = ^(UIImage *image){
        
        NSLog(@"vc %@ %@",image, [NSThread currentThread]);
    };
    
    op.successBlock = successBlock;
    
    //将操作添加到队列
    [self.queue addOperation:op];

}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
