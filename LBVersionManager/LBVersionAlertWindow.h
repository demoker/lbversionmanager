//
//  LBVersionAlertWindow.h
//  LBVersionManager
//
//  Created by demoker on 2017/2/15.
//  Copyright © 2017年 fengshunlubao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIButtonBlock)(id);

@interface LBVersionAlertWindow : UIWindow

- (void)alertWithContent:(NSString *)content isForceUpdate:(BOOL)isForceUpdate Completion:(void(^)(BOOL isAccepted))completion;
- (void)alertWithTitle:(NSString *)title content:(NSString *)content isForceUpdate:(BOOL)isForceUpdate Completion:(void(^)(BOOL isAccepted))completion;

- (void)showWithCompletion:(void(^)(BOOL isAccepted))completion;

+ (LBVersionAlertWindow *)sharedInstance;

@end
