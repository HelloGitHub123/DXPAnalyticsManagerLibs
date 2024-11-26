//
//  SensorsManagement.m
//  DITOApp
//
//  Created by li.biao on 2021/7/14.
//
#import "SensorsManagement.h"
static SensorsManagement *manager = nil;

#if __has_include(<SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>)
#import <Foundation/Foundation.h>
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>


@interface FirebaseAnalyticsService : NSObject

@end
#endif

@implementation SensorsManagement
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SensorsManagement alloc] init];
    });
    return manager;
}

#if __has_include(<SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>)

+ (instancetype)sharedInstanceWithLaunchOptions:(NSDictionary *)launchOptions baseUrl:(NSString *)baseUrl openLog:(BOOL)open
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SensorsManagement alloc] initWithLaunchOptions:launchOptions baseUrl:baseUrl openLog:open];
    });
    return manager;
}

- (instancetype)initWithLaunchOptions:(NSDictionary *)launchOptions baseUrl:(NSString *)baseUrl openLog:(BOOL)open
{
    self = [super init];
    if (self)
    {
        
        [self SensorsAnalyticsByOptions:launchOptions baseUrl:baseUrl openLog:open];
    }
    return self;
}


- (void)SensorsAnalyticsByOptions:(NSDictionary *)launchOptions baseUrl:(NSString *)baseUrl openLog:(BOOL)open{
    NSString * SensorsAnalyticsUrl = baseUrl; //@"http://192.168.193.9/portal-web/datagather/sa.gif?project=default&remark=default";
    
    SAConfigOptions *options = [[SAConfigOptions alloc] initWithServerURL:SensorsAnalyticsUrl launchOptions:launchOptions];
    //神策上报打通APP与H5
    options.enableJavaScriptBridge = YES;
    options.enableTrackAppCrash = YES;
    options.enableTrackPageLeave = YES;
    // 开启 Log
    options.enableLog = open;
    // 开启全埋点
    options.autoTrackEventType = SensorsAnalyticsEventTypeAppStart |
                                 SensorsAnalyticsEventTypeAppEnd |
                                 SensorsAnalyticsEventTypeAppClick |
                                 SensorsAnalyticsEventTypeAppViewScreen;
    /**
     * 其他配置，如开启可视化全埋点
     */
    // 初始化 SDK
    [SensorsAnalyticsSDK startWithConfigOptions:options];
    
}

// 单事件名称
- (void)trackWithName:(NSString *)name {
    if (!_sensorsDataEnabled) {
        return;
    }
    
    [[SensorsAnalyticsSDK sharedInstance] track:name];
}

// 事件名称+属性
- (void)trackWithName:(NSString *)name withProperties:(NSDictionary *)dic {
    if (!_sensorsDataEnabled) {
        return;
    }
    
    if (!dic || [dic allKeys].count == 0) {
        [self trackWithName:name];
        return;
    }
    
    [[SensorsAnalyticsSDK sharedInstance] track:name withProperties:dic];
}

// 设置用户属性
- (void)setUserProfileProperties:(NSDictionary *)dic {
    if (!_sensorsDataEnabled) {
        return;
    }
    
    if (!dic || [dic allKeys].count == 0) {
        return;
    }
    
    [[SensorsAnalyticsSDK sharedInstance] set:dic];
}

// 设置事件的公共属性
- (void)setRegisterSuperProperties:(NSDictionary *)dic {
    if (!_sensorsDataEnabled) {
        return;
    }
    
    if (!dic || [dic allKeys].count == 0) {
        return;
    }
    
    [[SensorsAnalyticsSDK sharedInstance] registerSuperProperties:dic];
}

// 取消注册公共属性
- (void)setUnregisterSuperProperty:(NSString *)key {
	if (!key || key.length == 0) {
		return;
	}
	
	[[SensorsAnalyticsSDK sharedInstance] unregisterSuperProperty:key];
}

// 获取当前注册的公共属性
- (NSDictionary *)getCurrentSuperProperties {
	NSDictionary *dic = [[SensorsAnalyticsSDK sharedInstance] currentSuperProperties];
	return dic;
}

#else
+ (instancetype)sharedInstanceWithLaunchOptions:(NSDictionary *)launchOptions baseUrl:(NSString *)baseUrl openLog:(BOOL)open{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SensorsManagement alloc] init];
    });
    return manager;
}

// 事件名称
- (void)trackWithName:(NSString *)name{
    
}
// 事件名称+属性
- (void)trackWithName:(NSString *)name withProperties:(NSDictionary *)dic{
    
}

// 设置用户属性
- (void)setUserProfileProperties:(NSDictionary *)dic{
    
}

// 设置事件的公共属性
- (void)setRegisterSuperProperties:(NSDictionary *)dic{
    
}
#endif



@end

