//
//  GqFormTableViewSectionGroup.m
//  Pods
//
//  Created by 林国强 on 16/3/24.
//
//

#import "GqFormTableViewSectionGroup.h"

@implementation GqFormTableViewSectionGroup

- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
