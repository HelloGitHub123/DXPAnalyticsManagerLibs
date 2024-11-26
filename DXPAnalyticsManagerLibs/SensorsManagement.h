//
//  SensorsManagement.h
//  DITOApp
//
//  Created by li.biao on 2021/7/14.
//  神策埋点

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SensorsManagement : NSObject

+ (instancetype)sharedInstance;

+ (instancetype)sharedInstanceWithLaunchOptions:(NSDictionary *)launchOptions baseUrl:(NSString *)baseUrl openLog:(BOOL)open;

@property (nonatomic, strong) NSDictionary *launchOptions;

@property (nonatomic, assign) BOOL sensorsDataEnabled;

// 事件名称
- (void)trackWithName:(NSString *)name;
// 事件名称+属性
- (void)trackWithName:(NSString *)name withProperties:(NSDictionary *)dic;

// 设置用户属性
- (void)setUserProfileProperties:(NSDictionary *)dic;

// 设置事件的公共属性
- (void)setRegisterSuperProperties:(NSDictionary *)dic;

// 取消注册公共属性
- (void)setUnregisterSuperProperty:(NSString *)key;

// 获取当前注册的公共属性
- (NSDictionary *)getCurrentSuperProperties;
@end

NS_ASSUME_NONNULL_END
