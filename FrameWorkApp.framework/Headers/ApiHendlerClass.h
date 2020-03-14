//
//  ApiHendlerClass.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 11/01/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//
#import "ApiHendlerClass.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class ApiHendlerClass;
@protocol ApiHendlerClassDelegate <NSObject>
@required
- (void)userDidUpdateStore:(ApiHendlerClass*)handler with:(NSString *)storeId;

@end





@interface ApiHendlerClass : NSObject 

@property (nonatomic, weak) id <ApiHendlerClassDelegate> Delegate;



-(void)getAccessToken:(NSString*)baseurl;
-(id)CircularPage;
-(void) dissmisscontroller;
-(void)logoutfunction;
+(NSMutableArray*)GetShoppinglistcount;
-(void)getOnlyLoginDataStore:(NSString*)name pass:(NSString*)pass;
-(id)getPurcheaseHistoryPage;
-(void)GetshopperListIdApi;
-(id)shoppingListPage;

+ (ApiHendlerClass *)sharedSingleton;
-(void)setStore:(NSString *)storeId;
-(void)GetErrorLog:(NSString*)FunctionName ErrorDetail:(NSString*)ErrorDetail;

@end

NS_ASSUME_NONNULL_END

