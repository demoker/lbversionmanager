//
//  LBVersionService.m
//  LBBuyer
//
//  Created by demoker on 15/12/28.
//  Copyright © 2015年 Lubao. All rights reserved.
//

#import "LBVersionManager.h"
#import "NSString+VersionCompare.h"
#import "LBVersionAlertWindow.h"

@interface LBVersionManager ()

@property (retain, nonatomic) LBVersionInfoModel * versionModel;

@end

@implementation LBVersionManager

#pragma mark - SINGLETON

+ (void)setVersionInfoUrl:(NSURL*)url{
    [[LBVersionManager sharedInstance]setVersionInfoUrl:url];
}

+(void)setInstallModel:(BOOL)isForceInstall{
    [[LBVersionManager sharedInstance]setIsForceInstall:isForceInstall];
}

+ (LBVersionManager *)sharedInstance{

    static dispatch_once_t once;
    static LBVersionManager * __singleton__;
    dispatch_once( &once, ^{
        __singleton__ = [[LBVersionManager alloc] init];
        
        [[NSNotificationCenter defaultCenter]addObserver:__singleton__ selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    } );
    return __singleton__;
}

#pragma mark - INIT

-(id)init{
    self = [super init];
    if (self) {
        self.isForceInstall = YES;
    }
    return self;
}

#pragma mark - VERSION CHECK

- (void)checkUpatewhenSuccess:(VersionCheckSuccessCallback)success
                    andFailed:(VersionCheckFaildCallback)failed{
    
    
    if (!self.versionInfoUrl) {
        failed(@"Not found version url");
    }else{
        
        __weak typeof(self) weakSelf = self;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.URLCache = [NSURLCache sharedURLCache]; // NEW LINE ON TOP OF OTHERWISE WORKING CODE
        configuration.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        [[session dataTaskWithURL:self.versionInfoUrl
                completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                    
                    if (error){
                        failed(error.localizedDescription);
                    }else{
                      
                        NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        NSDictionary * resultDict = [self dictionaryWithJsonString:resultString];
                        
                        LBVersionInfoModel *versionModel = [[LBVersionInfoModel alloc]init];
                        
                        [resultDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                            [versionModel setValue:obj forKey:key];
                        }];
                        
                        weakSelf.versionModel = versionModel;
                        NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
                        
                        if ([localVersion compareVersion:versionModel.version]==NSOrderedAscending) {
                            success(versionModel);
                        }else{
                            success(NULL);
                        }
                    }
                    
                }] resume];
    }
}

#pragma mark - Notification

-(void)applicationDidBecomeActive{
    [self checkUpatewhenSuccess:^(LBVersionInfoModel *versionInfoModel) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (versionInfoModel) {
                
                [[LBVersionAlertWindow sharedInstance]alertWithTitle:versionInfoModel.updateTitle content:versionInfoModel.updateInfoString isForceUpdate:YES Completion:^(BOOL isAccepted) {
                    if (isAccepted) {//立即更新
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:versionInfoModel.AppUrl] options:@{} completionHandler:^(BOOL success) {
                                    exit(0);
                                }];
                            }else{
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:versionInfoModel.AppUrl]];
                                exit(0);
                            }
                            
                        });
                        
                    }else if (_isForceInstall) {// 强制更新点击了退出
                        exit(0);
                    }
                }];
            }
        });
        
    } andFailed:^(NSString *reason) {
        
    }];
}

#pragma mark - private helper

- (NSString *)jsonFromData:(id)data{
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                        
                                                       options:NSJSONWritingPrettyPrinted
                        
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}

@end
