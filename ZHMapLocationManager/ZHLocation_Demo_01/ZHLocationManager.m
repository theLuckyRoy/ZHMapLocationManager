//
//  ZHLocationManager.m
//  ZHLocation_Demo_01
//
//  Created by luckyRoy on 2017/3/2.
//  Copyright © 2017年 object.Test. All rights reserved.
//

#import "ZHLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIDevice.h>

static ZHLocationManager *shareManger = nil;

@interface ZHLocationManager ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locaManager;

@end

@implementation ZHLocationManager

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManger = [self new];
    });
    return shareManger;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.locaManager = [CLLocationManager new];
        
        if ([self.locaManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            //需要时定位
            [self.locaManager requestWhenInUseAuthorization];
            //永久定位
//            [self.locaManager requestAlwaysAuthorization];
        
        }
        
        self.locaManager.delegate = self;
        
//        self.locaManager.distanceFilter = 10;
//        
//        self.locaManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        //临时永久定位 iOS9后
        if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
            self.locaManager.allowsBackgroundLocationUpdates = YES;
        }
        NSLog(@"device: %lf",[UIDevice currentDevice].systemVersion.floatValue);

    }
    return self;
}

+ (void)startLocation
{
    [[self shareManager] startLocation];
}

+ (void)stopLocation
{
    [[self shareManager] stopLocation];
}

- (void)startLocation
{
    [self.locaManager startUpdatingLocation];
}

- (void)stopLocation
{
    [self.locaManager stopUpdatingLocation];
}


#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"--locations--:%@",locations);
}

@end
