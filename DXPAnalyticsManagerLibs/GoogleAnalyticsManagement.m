//
//  GoogleAnalyticsManagement.m
//  DITOApp
//
//  Created by 李标 on 2023/5/9.
//
#define isGoogleNull(x)                (!x || [x isKindOfClass:[NSNull class]])
#define isGoogleEmptyString(x)         (isGoogleNull(x) || [x isEqual:@""] || [x isEqual:@"(null)"] || [x isEqual:@"null"])
#import "GoogleAnalyticsManagement.h"
static GoogleAnalyticsManagement *manager = nil;

#if __has_include(<FirebaseAnalytics/FirebaseAnalytics.h>)
#import <Foundation/Foundation.h>
#import <FirebaseAnalytics/FIRAnalytics.h>

@interface FirebaseAnalyticsService : NSObject

@end
#endif
@implementation GoogleAnalyticsManagement
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GoogleAnalyticsManagement alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#if __has_include(<FirebaseAnalytics/FirebaseAnalytics.h>)




- (void)logEventWithName:(NSString *)eventName withProperties:(NSDictionary *)dic {
    @try {
        if (!_gaEnable) {
            return;
        }
        if (isGoogleEmptyString(eventName)) {
            return;
        }
        NSDictionary *paramsDic = dic;
        if (!dic || [dic allKeys].count == 0) {
            paramsDic = @{};
        }
        [FIRAnalytics logEventWithName:eventName parameters:paramsDic];
    } @catch (NSException *exception) {
        
    }
    
}

#pragma mark -- 用户属性
// 设置用户属性
- (void)setUserProfilePropertiesWithName:(NSString *)propertiesName PropertiesValue:(NSString *)propertiesValue {
    if (isGoogleEmptyString(propertiesValue) || isGoogleEmptyString(propertiesName) || !_gaEnable) {
        return;
    }
    
    [FIRAnalytics setUserPropertyString:propertiesValue forName:propertiesName];
}

// 删除用户属性
- (void)deleteUserProfilePropertiesWithName:(NSString *)propertiesName {
    if (isGoogleEmptyString(propertiesName)  || !_gaEnable) {
        return;
    }
    [FIRAnalytics setUserPropertyString:nil forName:propertiesName];
    
}

#pragma mark -- 屏幕跟踪
// 记录屏幕跟踪
- (void)logScreenViewEventWithScreenName:(NSString *)screenName screenClass:(NSString *)screenClass {
    if (isGoogleEmptyString(screenName) || !_gaEnable) {
        return;
    }
    
    if (isGoogleEmptyString(screenClass)) {
        [FIRAnalytics logEventWithName:kFIREventScreenView parameters:@{kFIRParameterScreenName:screenName}];
    } else {
        [FIRAnalytics logEventWithName:kFIREventScreenView parameters:@{kFIRParameterScreenClass:screenClass, kFIRParameterScreenName:screenName}];
    }
}

#pragma mark -- 用户ID
// 设置用户ID
- (void)setGoogleAnalyticsUserID:(NSString *)userId {
    if (isGoogleEmptyString(userId) || !_gaEnable) {
        return;
    }
    [FIRAnalytics setUserID:userId];
}
#else
// 事件名称+属性
- (void)logEventWithName:(NSString *)eventName withProperties:(NSDictionary *)dic{
    
}

// 设置用户属性
- (void)setUserProfilePropertiesWithName:(NSString *)propertiesName PropertiesValue:(NSString *)propertiesValue{
    
}
// 删除用户属性
- (void)deleteUserProfilePropertiesWithName:(NSString *)propertiesName{
    
}

// 记录屏幕跟踪
- (void)logScreenViewEventWithScreenName:(NSString *)screenName screenClass:(NSString *)screenClass{
    
}

// 设置用户ID
- (void)setGoogleAnalyticsUserID:(NSString *)userId{
    
}
#endif



@end






