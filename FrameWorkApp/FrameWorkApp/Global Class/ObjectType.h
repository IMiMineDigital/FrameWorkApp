//
//  ObjectType.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 16/12/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Validation.h"
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface ObjectType : NSObject

{
    CLLocationManager*LocationManger;
    
}
-(instancetype)init;
-(void)loginfun:(NSMutableDictionary*)dict;

#define APP_RED_COLOR    [UIColor colorWithRed:234/255.0 green:63/255.0 blue:72/255.0 alpha:1.0]
#define APP_GREY_COLOR    [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]
#define isiPhone4S                  [UIScreen mainScreen].bounds.size.height < 500

#define isiPhone6                   [UIScreen mainScreen].bounds.size.height == 667

#define isiPhone8Plus               [UIScreen mainScreen].bounds.size.height == 736

#define isiPhone5s                  [UIScreen mainScreen].bounds.size.height == 568
#define isiPhoneX                  [UIScreen mainScreen].bounds.size.height == 812

#define isiPad                      [UIScreen mainScreen].bounds.size.height == 1024

#define isiPadSmall                  [UIScreen mainScreen].bounds.size.height == 834

#define isiPhoneXsMax               [UIScreen mainScreen].bounds.size.height == 896



#define TOAST_CENTER @"CSToastPositionCenter"
#define TOAST_BOTTOM @"CSToastPositionBottom"
#define TOAST_TIMEOUT 2.0

#define USERDATA @"UseInformation"
#define ACCESS_TOKEN @"Access_Token"

//#define GLOBAL_URL @"https://fwstaging.immdemo.net/api/"
//
//
//
//#define LOGIN_URL @"v1/Account/Login"
//#define ACCESSTOKEN_URL   @"api/v1/Token"
//
//#define PRINTURL_URL @"https://fwstaging.immdemo.net/web/printshoppinglist.aspx?"
//#define RESEND_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/ResetPassword?"
//#define CIRCULAR_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/Offers?"
//#define OTP_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/ValidateOTP?"
//#define FORGOTPASS_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/GenerateOTP"
//#define STORE_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/StoresByZipCode?"
//#define SIGNUP_URL  @"https://fwstagingapi.immdemo.net/api/v1/Account/SignUp"
//
//#define MORECOUPONS_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/CouponGallary?"
//#define SENDMAIL_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/EmailShoppingList"
////#define LOGIN_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/Login"
//#define ACTIVATE_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/ShoppingList"
//#define RELATED_ITEMS_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/RelatedItems?"
//#define SAVING_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/Saving?"
//#define SEARCHING_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/searchItems?"
//#define REMOVE_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/ShoppingListItemByupc?"
//#define ADDPRODUCT_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoppingList/List/Item?MemberId"
//#define GETSHOPPERLISTID_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoppingList/List?MemberId"
//#define SHOPPINGLIST_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/ShoppingListByvTYC?"
//#define ALLDELETE_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/ShoppingListByTYC?"
//#define SINGLEROWDELETE_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/ShoppingListById?"
//#define PURCHASEHISTORY_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/PurchaseHistory?"
//#define PURCHASEHITORYDETAILS_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/PurchaseHistoryDetails?"
//#define ADDITEMSOWN_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/List/MyOwnItem"
//#define ALLADDOWNREMOVE_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/AllownItems?"
//#define DELETEROWADDOWNITEMS @"https://fwstagingapi.immdemo.net/api/v1/ShoppingList/List/MyOwnItem?"
//#define ACTIVATEDOFFERS_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/ActivatedCoupons?"







#define PRINTURL_URL @"https://fwstaging.immdemo.net/web/printshoppinglist.aspx?"
#define RESEND_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/ResetPassword?"
#define CIRCULAR_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/Offers?"
#define OTP_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/ValidateOTP?"
#define FORGOTPASS_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/GenerateOTP"
#define STORE_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/StoresByZipCode?"
#define SIGNUP_URL  @"https://fwstagingapi.immdemo.net/api/v1/Account/SignUp"
#define ACCESSTOKEN_URL   @"https://fwstagingapi.immdemo.net/api/v1/Token"
#define MORECOUPONS_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/CouponGallary?"
#define SENDMAIL_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/EmailShoppingList"
#define LOGIN_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/Login"
#define ACTIVATE_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/ShoppingList"
#define RELATED_ITEMS_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/RelatedItems?"
#define SAVING_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/Saving?"
#define SEARCHING_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/searchItems?"
#define REMOVE_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/ShoppingListItemByupc?"
#define ADDPRODUCT_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoppingList/List/Item?MemberId"
#define GETSHOPPERLISTID_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoppingList/List?MemberId"
#define SHOPPINGLIST_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/ShoppingListByvTYC?"
#define ALLDELETE_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/ShoppingListByTYC?"
#define SINGLEROWDELETE_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/ShoppingListById?"
#define PURCHASEHISTORY_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/PurchaseHistory?"
#define PURCHASEHITORYDETAILS_URL @"https://fwstagingapi.immdemo.net/api/v1/Account/PurchaseHistoryDetails?"
#define ADDITEMSOWN_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/List/MyOwnItem"
#define ALLADDOWNREMOVE_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/AllownItems?"
#define DELETEROWADDOWNITEMS @"https://fwstagingapi.immdemo.net/api/v1/ShoppingList/List/MyOwnItem?"
#define ACTIVATEDOFFERS_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoopingList/ActivatedCoupons?"
#define SOPPINGLISTIDZERO_URL @"https://fwstagingapi.immdemo.net/api/v1/ShoppingList/List/MyOwnItem?"
#define DEFAULTIMG_URL @"https://fwstaging.immdemo.net/web/images/GEnoimage.jpg"
#define kErrorMessageAudioRecordingFailed   @"Unable to start Audio recording due to failure in Recording Engine"
#define SHOPPINGLISTDETAILS_URL @"https://fwstagingapi.immdemo.net/api/v1/Circular/ItemDetails?"





@end

NS_ASSUME_NONNULL_END

