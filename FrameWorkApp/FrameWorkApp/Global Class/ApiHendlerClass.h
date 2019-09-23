//
//  ApiHendlerClass.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 11/01/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@protocol ApiHendlerClassDelegate <NSObject>



@end

@interface ApiHendlerClass : NSObject
@property(strong,atomic)id<ApiHendlerClassDelegate>delegate;
-(void)getAccessToken:(NSString*)baseurl;
-(void)getLoginData:(NSString*)name pass:(NSString*)pass;
-(id)CircularPage;
-(void) dissmisscontroller;
-(void)logoutfunction;
+(NSMutableArray*)GetShoppinglistcount;
-(id)getPurcheaseHistoryPage;
-(void)GetshopperListIdApi;
-(id)shoppingListPage;

@end

NS_ASSUME_NONNULL_END
