//
//  GqFormTableViewSectionGroup.h
//  Pods
//
//  Created by 林国强 on 16/3/24.
//
//

#import <Foundation/Foundation.h>
#import "GqFormTableViewModel.h"

@interface GqFormTableViewSectionGroup : NSObject

@property (nonatomic, copy) NSString *headName;

@property (nonatomic, copy) NSString *footName;

@property (nonatomic ,strong) NSMutableArray *items;

@end
