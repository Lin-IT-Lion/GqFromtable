//
//  GqFormTableViewModel.h
//  Pods
//
//  Created by 林国强 on 16/3/24.
//
//

#import <Foundation/Foundation.h>

@interface GqFormTableViewModel : NSObject

//标题
@property (nonatomic, copy) NSString *title;

//内容
@property (nonatomic, copy) NSString *deatil;

//placeholder
@property (nonatomic, copy) NSString *placeholder;

//id主键
@property (nonatomic, copy) NSString *key;

//regular expression
@property (nonatomic, copy) NSString *regular;

//必填项
@property (nonatomic, assign) BOOL required;

//最大长度
@property (nonatomic, assign) NSInteger maxLength;


- (BOOL)checkRegular;
@end
