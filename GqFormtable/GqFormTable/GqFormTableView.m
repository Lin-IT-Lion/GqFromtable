//
//  GqFormTableView.m
//  Pods
//
//  Created by 林国强 on 16/3/23.
//
//

//#define GqDebug

#define alert(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]
#define notNull @"%@不能为空"
#define dataError @"%@格式不正确"

#define GqFromTableRepeatTextViewHeight 44
#define GqFromTableRepeatFootHeadHeight 30
#define GqFromTableRepeatNormalMargin 15

#import "GqFormTableView.h"
#import "GqFromTableRepeatTextView.h"

@interface GqFormTableView()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation GqFormTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commInit];
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    #ifdef GqDebug
        _scrollView.backgroundColor = [UIColor redColor];
    #endif
        
    }
    return _scrollView;
}

- (void)commInit
{
    [self addSubview:self.scrollView];
}

- (void)reloadItems:(NSArray *)items
{
    self.data = [NSMutableArray arrayWithArray:items];
    [self reload];
}

- (void)reAdjustmentHeight
{
    CGFloat height = 0;
    
    for(NSObject *item in self.data)
    {
        if ([item isKindOfClass:[GqFormTableViewSectionGroup class]]) {
            GqFormTableViewSectionGroup *group = (GqFormTableViewSectionGroup *)item;
            height += group.items.count * GqFromTableRepeatTextViewHeight + 2 * GqFromTableRepeatFootHeadHeight;
        } else {
            height += GqFromTableRepeatTextViewHeight;
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(0, height);
    
}

- (NSInteger)getTotoallyNumber
{
    NSInteger totoallyNumber = 0;
    for(NSObject *item in self.data)
    {
        if ([item isKindOfClass:[GqFormTableViewSectionGroup class]]) {
            GqFormTableViewSectionGroup *group = (GqFormTableViewSectionGroup *)item;
            totoallyNumber += group.items.count;
        } else {
            totoallyNumber ++;
        }
    }
    return totoallyNumber;
}

- (NSInteger)getIndexOfSection:(GqFormTableViewSectionGroup *)group
{
    NSInteger index = 0;
    for (GqFormTableViewSectionGroup *item in self.data) {
        if ([item isKindOfClass:[GqFormTableViewSectionGroup class]]) {
            if (item == group) {
                break;
            }
            index ++ ;
        }
    }
    return index;
}

- (UIView *)createHeadView:(GqFormTableViewSectionGroup *)group lastFrame:(CGRect)lastFrame
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lastFrame), self.frame.size.width, GqFromTableRepeatFootHeadHeight)];
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(GqFromTableRepeatNormalMargin, 0, self.frame.size.width - GqFromTableRepeatNormalMargin, GqFromTableRepeatFootHeadHeight)];
    headLabel.text = group.headName;
    [headView addSubview:headLabel];
    return headView;
}

- (UIView *)createFootView:(GqFormTableViewSectionGroup *)group lastFrame:(CGRect)lastFrame
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lastFrame), self.frame.size.width, GqFromTableRepeatFootHeadHeight)];
    UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectMake(GqFromTableRepeatNormalMargin, 0, self.frame.size.width - GqFromTableRepeatNormalMargin, GqFromTableRepeatFootHeadHeight)];
    footLabel.text = group.footName;
    [footView addSubview:footLabel];
    return footView;
}

- (UIView *)createRepeat:(GqFormTableViewModel *)model lastFrame:(CGRect)lastFrame
{
    GqFromTableRepeatTextView *repeatView = [[GqFromTableRepeatTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lastFrame), self.frame.size.width, GqFromTableRepeatTextViewHeight)];
    repeatView.item = model;
    return repeatView;
}

- (BOOL)check:(GqFormTableViewModel *)model
{
    //校验必填
    if (model.required && model.deatil.length == 0) {
        NSString *tipString = [NSString stringWithFormat:notNull,model.title];
        alert(tipString);
        return false;
    }
    
    //校验正则
    if(model.regular.length > 0 && model.deatil.length > 0)
    {
        if ([model checkRegular] == NO) {
            NSString *tipString = [NSString stringWithFormat:dataError,model.title];
            alert(tipString);
            return false;
        }
    }
    
    //校验长度
    if(model.maxLength != 0 && model.deatil.length > 0)
    {
        if (model.deatil.length > model.maxLength) {
            NSString *tipString = [NSString stringWithFormat:dataError,model.title];
            alert(tipString);
            return false;
        }
    }
    
    return YES;
}

- (BOOL)checkContent
{
    for (NSObject *item in self.data) {
        if ([item isKindOfClass:[GqFormTableViewSectionGroup class]]) {
            GqFormTableViewSectionGroup *group = (GqFormTableViewSectionGroup *)item;
            for (GqFormTableViewModel *model in group.items) {
                if ([self check:model] == false) {
                    return false;
                }
            }
            
        } else if ([item isKindOfClass:[GqFormTableViewModel class]]){
            if ([self check:(GqFormTableViewModel *)item] == false) {
                return false;
            }
        }
    }
    return true;
}

- (void)reload
{
    
    [self reAdjustmentHeight];
    
    for(UIView *view in self.scrollView.subviews)
    {
        [view removeFromSuperview];
    }
    CGRect lastViewFrame = CGRectZero;
    
    for(NSObject *item in self.data)
    {
        if ([item isKindOfClass:[GqFormTableViewSectionGroup class]]) {
            GqFormTableViewSectionGroup *group = (GqFormTableViewSectionGroup *)item;
            
            //head
            UIView *headView = [self createHeadView:group lastFrame:lastViewFrame];
            lastViewFrame = headView.frame;
            [self.scrollView addSubview:headView];
            
            //repeat
            for(GqFormTableViewModel *model in group.items)
            {
                if ([model isKindOfClass:[GqFormTableViewModel class]]) {
                    UIView *repeatView = [self createRepeat:model lastFrame:lastViewFrame];
                    lastViewFrame = repeatView.frame;
                    [self.scrollView addSubview:repeatView];
                }
            }
            
            //foot
            UIView *footView = [self createFootView:group lastFrame:lastViewFrame];
            lastViewFrame = footView.frame;
            [self.scrollView addSubview:footView];
            
        } else if([item isKindOfClass:[GqFormTableViewModel class]]) {
            
            //repeat
            GqFormTableViewModel *model = (GqFormTableViewModel *)item;
            UIView *repeatView = [self createRepeat:model lastFrame:lastViewFrame];
            lastViewFrame = repeatView.frame;
            [self.scrollView addSubview:repeatView];

        }
    }
}

@end
