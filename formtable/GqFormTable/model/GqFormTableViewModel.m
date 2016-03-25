//
//  GqFormTableViewModel.m
//  Pods
//
//  Created by 林国强 on 16/3/24.
//
//

#import "GqFormTableViewModel.h"

@implementation GqFormTableViewModel


- (BOOL)checkRegular
{
    BOOL flag = NO;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",self.regular];
    flag = [predicate evaluateWithObject:self.deatil];
    return flag;
}

@end
