//
//  LBVersionService.h
//  LBBuyer
//
//  Created by demoker on 15/12/28.
//  Copyright © 2015年 Lubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBVersionInfoModel.h"

typedef void (^VersionCheckSuccessCallback)(LBVersionInfoModel *versionInfoModel);
typedef void (^VersionCheckFaildCallback)(NSString *reason);

/*!
 *  @author cokecoffe
 *
 *  @brief 版本检测更新
 *
 *  @since 1.0
 */
@interface LBVersionManager : NSObject

@property (strong, nonatomic) NSURL *versionInfoUrl;//版本json的链接
@property (assign, nonatomic) BOOL isForceInstall;//是否强制安装,默认YES

//@property (assign, nonatomic) BOOL useUniversalAlert;//是否使用内置的提示框，如果不是，需要指定代理处理提示框的显示

+ (void)setVersionInfoUrl:(NSURL*)url;
+ (void)setInstallModel:(BOOL)isForceInstall;

+ (LBVersionManager *)sharedInstance;

- (void)checkUpatewhenSuccess:(VersionCheckSuccessCallback)success
                    andFailed:(VersionCheckFaildCallback)failed;

@end
