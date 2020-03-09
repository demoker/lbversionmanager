//
//  LBVersionInfoModel.h
//  LBBuyer
//
//  Created by demoker on 15/12/28.
//  Copyright © 2015年 Lubao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBVersionInfoModel : NSObject

@property (strong,nonatomic) NSString *updateTitle;//版本标题
@property (strong,nonatomic) NSString *version;//版本号:1.0.0
@property (strong,nonatomic) NSArray *updateInfo;//升级信息 1.xxx 2.xxx
@property (strong,nonatomic) NSString *size;//包大小
@property (strong,nonatomic) NSString *AppUrl;//包下载地址

-(NSString *)updateInfoString;

@end
