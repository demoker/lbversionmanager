//
//  ViewController.m
//  LBVersionManager
//
//  Created by demoker on 2017/2/10.
//  Copyright © 2017年 fengshunlubao. All rights reserved.
//

#import "ViewController.h"
#import "LBVersionManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LBVersionManager setVersionInfoUrl:[NSURL URLWithString:@"https://app.lubaocar.com/iOS/LBDriver/release/update.json"]];
    [LBVersionManager setInstallModel:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
