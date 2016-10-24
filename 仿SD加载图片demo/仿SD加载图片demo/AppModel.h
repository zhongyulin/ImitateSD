//
//  AppModel.h
//  仿SD加载图片demo
//
//  Created by 钟昱林 on 2016/10/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

//名称
@property (nonatomic, copy) NSString *name;

//图片
@property (nonatomic, copy) NSString *icon;

//下载量
@property (nonatomic, copy) NSString *download;

@end
