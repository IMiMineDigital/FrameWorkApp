//
//  ObjectType.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 16/12/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import "ObjectType.h"


@implementation ObjectType

-(instancetype)init
{
    if (self=[super init])
     {
        //NSLog(@" i am library");
     }
    return self;
}

-(void)loginfun:(NSMutableDictionary*)dict
{
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:USERDATA];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)GetGeoFance
{
//    LocationManger=[[CLLocationManager alloc] init];
//    [LocationManger requestAlwaysAuthorization];
//    LocationManger.delegate=self;
//    [LocationManger startUpdatingLocation];
//    LocationManger.desiredAccuracy=kCLLocationAccuracyBest;
//    NSLog(@"%@/%@",LocationManger.location.coordinate.latitude,LocationManger.location.coordinate.longitude);
    
    
}

@end
