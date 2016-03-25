//
//  GqFromTableRepeatTextView.m
//  Pods
//
//  Created by 林国强 on 16/3/24.
//
//

#define TitleLabelWidth 100
#define NormalMargin 15

#import "GqFromTableRepeatTextView.h"

@interface GqFromTableRepeatTextView() <UITextFieldDelegate>

@end

@implementation GqFromTableRepeatTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_titleLabel];
    
    _contextText = [[UITextField alloc] init];
    _contextText.font = [UIFont systemFontOfSize:14];
    _contextText.textAlignment = NSTextAlignmentLeft;
    _contextText.textColor = [UIColor blackColor];
    _contextText.delegate = self;
    [_contextText addTarget:self action:@selector(textFiledEditChanged) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_contextText];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(NormalMargin, 0, TitleLabelWidth, self.frame.size.height);
    
    self.contextText.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + NormalMargin, 0, self.frame.size.width - CGRectGetMaxX(self.titleLabel.frame) - 2 * NormalMargin, self.frame.size.height);
    
}

- (void)setItem:(GqFormTableViewModel *)item
{
    _item = item;
    
    self.titleLabel.text = item.title;
    
    self.contextText.text = item.deatil;
    
    self.contextText.placeholder = item.placeholder;
}

#pragma UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.item.maxLength == 0) {
        return YES;
    }
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger kMaxLength = self.item.maxLength;
    if (toBeString.length > kMaxLength && range.length!=1){
        textField.text = [toBeString substringToIndex:kMaxLength];
        return NO;
    }
    return YES;
}

- (void)textFiledEditChanged {
    
    if (self.item.maxLength == 0) {
        self.item.deatil = self.contextText.text;
        return ;
    }
    NSInteger kMaxLength = self.item.maxLength;
    NSString *toBeString = self.contextText.text;
    NSString *lang = [self.textInputMode primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        if (toBeString.length > kMaxLength) {
            self.contextText.text = [toBeString substringToIndex:kMaxLength];
        }
    }
    self.item.deatil = self.contextText.text;
}

@end
