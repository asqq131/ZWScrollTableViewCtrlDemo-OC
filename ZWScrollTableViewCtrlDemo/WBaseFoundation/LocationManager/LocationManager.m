//
//  LocationManager.m
//  YoLo
//
//  Created by ZWu H on 2016/11/23.
//  Copyright © 2016年 wu. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>

@implementation LocationManager

- (id)init {
    if (self = [super init]) {
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"定位服务当前可能尚未打开，请设置打开！");
            
        } else {
            // 定位管理器
            self.manager = [[CLLocationManager alloc] init];
            self.geocoder = [[CLGeocoder alloc] init];
            
            // 如果没有授权则请求用户授权
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
                [self.manager requestWhenInUseAuthorization];
                
            }
//            else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
//                
//            }
            
            // 设置代理
            self.manager.delegate = self;
            // 设置定位精度
            self.manager.desiredAccuracy = kCLLocationAccuracyBest;
            // 定位频率,每隔多少米定位一次
            CLLocationDistance distance = 10.0; // 十米定位一次
            self.manager.distanceFilter = distance;
        }
    }
    
    return self;
}

#pragma mark 启动跟踪定位
- (void)startLocationAtCallBack:(CallBackLoaction)callBack {
    [self.manager startUpdatingLocation];
    self.callBackLoaction = callBack;
}

#pragma mark 根据地名确定地理坐标
- (void)getCoordinateByAddress:(NSString *)address {
    // 地理编码
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        // 取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark = [placemarks firstObject];
        CLLocation *location = placemark.location; // 位置
        CLRegion *region = placemark.region; // 区域
        NSDictionary *addressDic = placemark.addressDictionary; // 详细地址信息字典,包含以下部分信息
//        NSString *name=placemark.name; // 地名
//        NSString *thoroughfare=placemark.thoroughfare; // 街道
//        NSString *subThoroughfare=placemark.subThoroughfare; // 街道相关信息，例如门牌等
//        NSString *locality=placemark.locality; // 城市
//        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
//        NSString *administrativeArea=placemark.administrativeArea; // 省/州
//        NSString *subAdministrativeArea=placemark.subAdministrativeArea; // 其他行政区域信息
//        NSString *postalCode=placemark.postalCode; // 邮编
//        NSString *ISOcountryCode=placemark.ISOcountryCode; // 国家编码
//        NSString *country=placemark.country; // 国家
//        NSString *inlandWater=placemark.inlandWater; // 水源、湖泊
//        NSString *ocean=placemark.ocean; // 海洋
//        NSArray *areasOfInterest=placemark.areasOfInterest; // 关联的或利益相关的地标
        NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
    }];
}

#pragma mark 根据坐标取得地名
- (void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude {
    // 反地理编码
    __weak __typeof(self)weakSelf = self;
    CLLocation *location=[[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        weakSelf.callBackLoaction(placemark, nil);
    }];
}

#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
// 可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations firstObject]; // 取出第一个位置
    CLLocationCoordinate2D coordinate = location.coordinate; //位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    // 如果不需要实时定位，使用完即使关闭定位服务
    [self.manager stopUpdatingLocation];
    
    // 反地理编码
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.callBackLoaction(nil, error);
}

@end

