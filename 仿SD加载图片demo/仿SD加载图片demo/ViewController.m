//
//  ViewController.m
//  仿SD加载图片demo
//
//  Created by 钟昱林 on 2016/10/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "DownloaderOperation.h"
@interface ViewController ()

//队列
@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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

#pragma mark - 自定义NSOperation方法
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
