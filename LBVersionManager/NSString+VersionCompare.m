//
//  NSString+VersionCompare.m
//  LBVersionManager
//
//  Created by demoker on 2017/2/10.
//  Copyright © 2017年 fengshunlubao. All rights reserved.
//

#import "NSString+VersionCompare.h"

@implementation NSString (VersionCompare)

-(NSComparisonResult)compareVersion:(NSString*)otherVersion
{
    NSMutableArray * selfArray =[NSMutableArray arrayWithArray: [self componentsSeparatedByString:@"."]];
    NSMutableArray * otherArray =[NSMutableArray arrayWithArray:[otherVersion componentsSeparatedByString:@"."]];
    
    if(otherArray.count < selfArray.count)
    {
        while (otherArray.count<selfArray.count)
        {
            [otherArray addObject:@"0"];
        }
    }
    else
    {
        while (selfArray.count < otherArray.count)
        {
            [selfArray addObject:@"0"];
        }
    }
    
    for(int i=0;i<selfArray.count;i++)
    {
        int selfValue = [[selfArray objectAtIndex:i] intValue];
        int otherValue = [[otherArray objectAtIndex:i] intValue];
        if(selfValue == otherValue)
        {
            continue;
        }
        if(otherValue>selfValue)
        {
            return NSOrderedAscending;
        }
        else
        {
            return NSOrderedDescending;
        }
    }
    return NSOrderedSame;
}


@end
