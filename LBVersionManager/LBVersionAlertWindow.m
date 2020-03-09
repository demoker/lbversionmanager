//
//  LBVersionAlertWindow.m
//  LBVersionManager
//
//  Created by demoker on 2017/2/15.
//  Copyright © 2017年 fengshunlubao. All rights reserved.
//

#import "LBVersionAlertWindow.h"

@interface LBVersionAlertWindow ()

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *versionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionContentLabel;

@property (assign,nonatomic) BOOL isForceUpdate;

@property (nonatomic, copy) void(^completion)(BOOL isAccepted);

@end

@implementation LBVersionAlertWindow

+ (LBVersionAlertWindow *)sharedInstance{
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LBVersionAlertWindow" owner:nil options:nil];
        for (id anObject in topLevelObjects) {
            if ([anObject isKindOfClass:[LBVersionAlertWindow class]]) {
                shareInstance = anObject;
                break;
            }
        }
       
         ((LBVersionAlertWindow *)shareInstance).frame = [[UIScreen mainScreen]bounds];
        
    });
    
    return shareInstance;
}

-(void)show{
    [self makeKeyWindow];
    self.hidden = NO;
}

-(void)dismiss{
    [self resignKeyWindow];
    self.hidden = YES;
}
#pragma mark - Action

- (IBAction)cancel:(id)sender {
    [self dismiss];
    
    self.completion(NO);
}

- (IBAction)update:(id)sender {
    [self dismiss];
    
    self.completion(YES);
}

- (void)alertWithTitle:(NSString *)title content:(NSString *)content isForceUpdate:(BOOL)isForceUpdate Completion:(void(^)(BOOL isAccepted))completion{
    
    self.versionTitleLabel.text = title;
    
    [self alertWithContent:content isForceUpdate:isForceUpdate Completion:completion];
    
}

- (void)alertWithContent:(NSString *)content isForceUpdate:(BOOL)isForceUpdate Completion:(void(^)(BOOL isAccepted))completion{
    
    self.versionContentLabel.text = content;
    self.isForceUpdate = isForceUpdate;
    self.completion = completion;
    
    if (isForceUpdate) {
        self.cancelButton.titleLabel.text = @"退出";
    }else{
        self.cancelButton.titleLabel.text = @"稍后再说";
    }
    
    [self show];
}

- (void)showWithCompletion:(void(^)(BOOL isAccepted))completion{
    
}


@end
