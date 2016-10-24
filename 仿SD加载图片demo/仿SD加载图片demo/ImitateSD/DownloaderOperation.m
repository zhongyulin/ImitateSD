//
//  DownloaderOperation.m
//  仿SD加载图片demo
//
//  Created by 钟昱林 on 2016/10/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "DownloaderOperation.h"

@interface DownloaderOperation ()

//图片下载地址
@property (copy, nonatomic) NSString *URLstr;

@property (copy, nonatomic) void(^successBlock) (UIImage *image);

@end

@implementation DownloaderOperation

//重写main方法,目的在这个方法做你想做的事情,默认是在子线程异步执行
- (void)main
{
    NSLog(@"传入 %@",self.URLstr);
    
    //延迟
    [NSThread sleepForTimeInterval:1.25];
    
    //图片下载
    NSURL *URL = [NSURL URLWithString:self.URLstr];
    
    NSData *data = [NSData dataWithContentsOfURL:URL];
    
    UIImage *image = [UIImage imageWithData:data];
    
    if (self.isCancelled == YES) {
        
        NSLog(@"取消 %@",self.URLstr);
        
        return;
    }
    
    //断言检查
    NSAssert(self.successBlock != nil, @"图片下载完成后,回调不能为空!");
    
    //图片下载完成后回调
//    if (self.successBlock != nil) {
    
        //返回主线程刷新
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.successBlock(image);
            
            NSLog(@"完成 %@",self.URLstr);
        }];
//    }
    
}

//实现实例化自定义操作方法
+ (instancetype)downloadWithURLstr:(NSString *)URLstr successBlock:(void (^)(UIImage *))successBlock
{
    DownloaderOperation *op = [[DownloaderOperation alloc] init];
    
    op.URLstr = URLstr;
    
    op.successBlock = successBlock;
    
    return op;
}



@end
