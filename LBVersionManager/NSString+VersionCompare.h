//
//  NSString+VersionCompare.h
//  LBVersionManager
//
//  Created by demoker on 2017/2/10.
//  Copyright © 2017年 fengshunlubao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VersionCompare)

/*
 此方法供版本号（例如 1.0.0 2.0.0 格式的）进行比较
 */

-(NSComparisonResult)compareVersion:(NSString*)otherVersion;

@end
