//
//  DownloaderOperation.m
//  仿SD加载图片demo
//
//  Created by 钟昱林 on 2016/10/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "DownloaderOperation.h"

@implementation DownloaderOperation

//重写main方法,目的在这个方法做你想做的事情,默认是在子线程异步执行
- (void)main
{
    
    NSLog(@"%@",[NSThread currentThread]);
    
    NSURL *URL = [NSURL URLWithString:self.URLstr];
    
    NSData *data = [NSData dataWithContentsOfURL:URL];
    
    UIImage *image = [UIImage imageWithData:data];
    
    NSLog(@"%@",image);
    
}

@end
