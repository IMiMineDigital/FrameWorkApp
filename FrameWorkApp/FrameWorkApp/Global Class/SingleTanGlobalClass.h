//
//  SingleTanGlobalClass.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 20/08/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleTanGlobalClass : NSObject
+ (SingleTanGlobalClass*)instance;
-(void)LocalDataStore:(NSMutableArray*)array;
-(NSMutableArray*)updatedata;
-(void)alldataCircularStore:(NSMutableArray*)array;
-(NSMutableArray*)StoreCirculardata;
-(void)CouponIdChangeStore:(NSMutableArray*)array;
-(NSMutableArray*)CouponseIdChangeStore;
-(void)MoreCouponseIdChangeStore:(NSMutableArray*)array;
-(NSMutableArray*)MoreCouponseIdChangeStoreRetrun;
-(void)MoreCouponseIdChangeStoreAll:(NSMutableArray*)array;

-(NSMutableArray*)MoreCouponseIdChangeStoreRetrunAll;

-(void)FilterdataStore:(NSMutableArray*)array;
-(NSMutableArray*)FilterdataStoreRetrunAll;

-(void)LastFiltersByOffersarray:(NSMutableArray*)array;
-(NSMutableArray*)LastFiltersByOffersarrayAll;

-(void)permanentCirculardataStore:(NSMutableArray*)array;
-(NSMutableArray*)permanentCirculardataStoreReturnAll;


- (id)init;
@end

NS_ASSUME_NONNULL_END
