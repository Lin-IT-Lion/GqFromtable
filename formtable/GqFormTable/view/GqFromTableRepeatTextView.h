//
//  GqFromTableRepeatTextView.h
//  Pods
//
//  Created by 林国强 on 16/3/24.
//
//

#import <UIKit/UIKit.h>
#import "GqFormTableViewModel.h"

@interface GqFromTableRepeatTextView : UIView

@property (nonatomic, strong) GqFormTableViewModel *item;

@property (nonatomic, strong ,readonly) UILabel *titleLabel;

@property (nonatomic, strong ,readonly) UITextField *contextText;

@end
