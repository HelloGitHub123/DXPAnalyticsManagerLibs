//
//  GoogleAnalyticsManagement.h
//  DITOApp
//
//  Created by 李标 on 2023/5/9.
//  谷歌埋点 分析

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface GoogleAnalyticsManagement : NSObject
 
@property (nonatomic, assign) BOOL gaEnable;

+ (instancetype)sharedInstance;


// 事件名称+属性
- (void)logEventWithName:(NSString *)eventName withProperties:(NSDictionary *)dic;

// 设置用户属性
- (void)setUserProfilePropertiesWithName:(NSString *)propertiesName PropertiesValue:(NSString *)propertiesValue;
// 删除用户属性
- (void)deleteUserProfilePropertiesWithName:(NSString *)propertiesName;

// 记录屏幕跟踪
- (void)logScreenViewEventWithScreenName:(NSString *)screenName screenClass:(NSString *)screenClass;

// 设置用户ID
- (void)setGoogleAnalyticsUserID:(NSString *)userId;
@end

NS_ASSUME_NONNULL_END
