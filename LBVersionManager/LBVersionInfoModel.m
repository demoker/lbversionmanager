//
//  LBVersionInfoModel.m
//  LBBuyer
//
//  Created by demoker on 15/12/28.
//  Copyright © 2015年 Lubao. All rights reserved.
//

#import "LBVersionInfoModel.h"

@implementation LBVersionInfoModel

-(NSString *)updateInfoString{
    NSMutableString *str = [NSMutableString string];
    
    for (NSString *version in _updateInfo) {
        [str appendString:version];
        
        if (NO == [[_updateInfo lastObject] isEqual:version]) {
            [str appendString:@"\n"];
        }
    }
    
    return str;
}
@end
