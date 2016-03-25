//
//  ViewController.m
//  formtableDemo
//
//  Created by 林国强 on 16/3/23.
//  Copyright © 2016年 林国强. All rights reserved.
//
#define footViewHeight 60
#define footButtonHeight 50
#define normalMargin 15
#define Submit @"Submit"
#import "ViewController.h"
#import "GqFormTableView.h"
@interface ViewController ()
@property (nonatomic, strong) GqFormTableView *formTableView;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.formTableView];
  
    [self loadData];
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - footViewHeight, self.view.frame.size.width, footViewHeight)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(normalMargin/2.0, 0, footView.frame.size.width -  normalMargin, 0.5)];
    line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    [footView addSubview:line];
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(normalMargin, (footViewHeight - footButtonHeight)/2.0, footView.frame.size.width - 2 * normalMargin, footButtonHeight)];
    submitButton.backgroundColor = [UIColor orangeColor];
    [submitButton setTitle:Submit forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:submitButton];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (GqFormTableView *)formTableView
{
    if (_formTableView == nil) {
        _formTableView = [[GqFormTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - footViewHeight)];
    }
    return _formTableView;
}

- (void)submit
{
    BOOL flag = [self.formTableView checkContent];
    if (flag) {
        NSLog(@"提交成功！%@",self.data);
    }
}

- (void)loadData
{
//    for(int i = 0; i< 10; i++)
//    {
//        GqFormTableViewSectionGroup *group = [[GqFormTableViewSectionGroup alloc] init];
//        group.headName = [NSString stringWithFormat:@"%@_Head",@(i)];
//        group.footName = [NSString stringWithFormat:@"%@_Foot",@(i)];
//        int k = i + 1;
//        while (k <10) {
//            
//            GqFormTableViewModel *model = [[GqFormTableViewModel alloc] init];
//            model.title = [NSString stringWithFormat:@"%@_title",@(k)];
//            model.deatil = [NSString stringWithFormat:@"%@_deatil",@(k)];
//            model.placeholder = [NSString stringWithFormat:@"%@_placeholder",@(k)];
////            model.maxLength = k;
//            
//            [group.items addObject:model];
//            
//            k++;
//        }
//        [items addObject:group];
//    }
    
    for(int i = 0; i< 30; i++)
    {
        GqFormTableViewModel *model = [[GqFormTableViewModel alloc] init];
        model.title = [NSString stringWithFormat:@"%@_title",@(i)];
        model.deatil = [NSString stringWithFormat:@"%@_deatil",@(i)];
        model.placeholder = [NSString stringWithFormat:@"%@_placeholder",@(i)];
//        model.maxLength = i + 1;
        model.required = YES;
//        if (i == 0) {
//            model.regular = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
//        }
        [self.data addObject:model];
    }
    [self.formTableView reloadItems:self.data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
