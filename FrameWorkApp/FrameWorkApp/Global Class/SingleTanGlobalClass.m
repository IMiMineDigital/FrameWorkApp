//
//  SingleTanGlobalClass.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 20/08/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "SingleTanGlobalClass.h"
 static SingleTanGlobalClass *datHelper = nil;
@implementation SingleTanGlobalClass
{
        NSMutableArray*searcharray;
        NSMutableArray*Circulararry;
        NSMutableArray*CouponsIdChangeArray;
        NSMutableArray*MoreCouponseIdChangeStore;
        NSMutableArray*MoreCouponseIdChangeStoreall;
        NSMutableArray*FilterdataStoreRetrunAll;
        NSMutableArray*LastFiltersByOffersarray;
    
    
    
       NSMutableArray*permanentsCircularwithoutaddArray;
}
+ (SingleTanGlobalClass*)instance {
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        datHelper = [SingleTanGlobalClass new];
    });
    return datHelper;
}
-(void)LocalDataStore:(NSMutableArray*)array
{
    
    searcharray=array;
    NSLog(@"SingleTanGlobalClass:%d",array.count);
}

-(NSMutableArray*)updatedata
{
    
    NSLog(@"storearray:%d",searcharray.count);
    return searcharray;
}









-(void)alldataCircularStore:(NSMutableArray*)array
{
    
     Circulararry=[[NSMutableArray alloc] init];
    NSLog(@"alldataCircularStore:%d",array.count);
    Circulararry=array;
    
}
-(NSMutableArray*)StoreCirculardata
{
    
    
     NSLog(@"StoreCirculardata:%d",Circulararry.count);
    return Circulararry;
    
}










-(void)CouponIdChangeStore:(NSMutableArray*)array
{
          CouponsIdChangeArray=[[NSMutableArray alloc] init];
      NSLog(@"CouponIdChangeStore:%d",CouponsIdChangeArray.count);
    CouponsIdChangeArray=array;
    
}
-(NSMutableArray*)CouponseIdChangeStore
{
    
    
    NSLog(@"CouponseIdChangeStore:%d",MoreCouponseIdChangeStore.count);
    return  CouponsIdChangeArray;
}





-(void)MoreCouponseIdChangeStore:(NSMutableArray*)array
{
      MoreCouponseIdChangeStore=[[NSMutableArray alloc] init];
    NSLog(@"MoreCouponseIdChangeStore:%d",MoreCouponseIdChangeStore.count);
    MoreCouponseIdChangeStore=array;
    
}
-(NSMutableArray*)MoreCouponseIdChangeStoreRetrun
{
        NSLog(@"MoreCouponseIdChangeStoreRetrun:%d",MoreCouponseIdChangeStore.count);
    
    return MoreCouponseIdChangeStore;
}






-(void)MoreCouponseIdChangeStoreAll:(NSMutableArray*)array
{

    for (int i=0; i<array.count; i++)
    {
        NSLog(@"ClickCount:%@",array[i][@"ClickCount"]);
        NSLog(@"ListCount:%@",array[i][@"ListCount"]);
    }
    
      // NSLog(@"MoreCouponseIdChangeStoreAll:%d",array.count);
    
    
         //  MoreCouponseIdChangeStoreall=[[NSMutableArray alloc] init];
            MoreCouponseIdChangeStoreall=array;
}
-(NSMutableArray*)MoreCouponseIdChangeStoreRetrunAll
{
    
    
   // NSLog(@"MoreCouponseIdChangeStoreRetrunAll:%d",MoreCouponseIdChangeStoreall.count);
    return MoreCouponseIdChangeStoreall;
}

-(void)FilterdataStore:(NSMutableArray*)array
{
    
        FilterdataStoreRetrunAll=[[NSMutableArray alloc] init];
    FilterdataStoreRetrunAll=array;
        
}
-(NSMutableArray*)FilterdataStoreRetrunAll
{
    
    return FilterdataStoreRetrunAll;
}
-(void)LastFiltersByOffersarray:(NSMutableArray*)array
{
    
     LastFiltersByOffersarray=[[NSMutableArray alloc] init];
        NSLog(@"LastFiltersByOffersarray:%d",array.count);
        LastFiltersByOffersarray=array;
}
-(NSMutableArray*)LastFiltersByOffersarrayAll
{
    
     NSLog(@"LastFiltersByOffersarrayAll:%d",LastFiltersByOffersarray.count);
    return LastFiltersByOffersarray;
    
}






-(void)permanentCirculardataStore:(NSMutableArray*)array
{
   
    permanentsCircularwithoutaddArray=array;
    NSLog(@"SingleTanGlobalClass:%d",array.count);
}

-(NSMutableArray*)permanentCirculardataStoreReturnAll
{
    
    NSLog(@"storearray:%d",permanentsCircularwithoutaddArray.count);
    return permanentsCircularwithoutaddArray;
}
- (id)init {
    if (self = [super init])
    {
       // datHelper=[SingleTanGlobalClass new];
        permanentsCircularwithoutaddArray = [[NSMutableArray alloc] init];
        MoreCouponseIdChangeStoreall= [[NSMutableArray alloc] init];
    }
    return self;
}
@end
