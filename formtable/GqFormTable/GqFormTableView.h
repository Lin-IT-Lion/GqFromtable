//
//  GqFormTableView.h
//  Pods
//
//  Created by 林国强 on 16/3/23.
//
//

#import <UIKit/UIKit.h>
#import "GqFormTableViewSectionGroup.h"
@protocol GqFormTableViewDelegate <NSObject>

@end

@interface GqFormTableView : UIView

@property (nonatomic ,weak) id<GqFormTableViewDelegate> delegate;

//items里为GqFormTableViewSectionGroup 或者 GqFormTableViewModel
- (void)reloadItems:(NSArray *)items;

- (BOOL)checkContent;
@end
