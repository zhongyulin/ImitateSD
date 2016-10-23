//
//  DownloaderOperation.h
//  仿SD加载图片demo
//
//  Created by 钟昱林 on 2016/10/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DownloaderOperation : NSOperation



+ (instancetype)downloadWithURLstr:(NSString *)URLstr successBlock:(void (^)(UIImage *))successBlock;

@end
