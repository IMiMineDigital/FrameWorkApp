//
//  DoubleViewCollectionCell.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 5/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Validation.h"
#import "UIImageView+AFNetworking.h"
#import "ObjectType.h"
#import "UIView+Toast.h"
#import <SVProgressHUD.h>
NS_ASSUME_NONNULL_BEGIN
@class MyPersonalPriceViewController;
@interface DoubleViewCollectionCell : UICollectionViewCell
{
    NSInteger index;
}
-(void)cellOnData:(NSMutableDictionary*)str myPersonalPriceViewController:(MyPersonalPriceViewController*)myPersonalPriceViewController index1:(NSInteger)index1;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *savepriceimg;
@property (weak, nonatomic) IBOutlet UILabel *product_name;
@property (weak, nonatomic) IBOutlet UILabel *product_price;
@property (weak, nonatomic) IBOutlet UIView *shoadShow;
@property (weak, nonatomic) IBOutlet UIButton *seeeDetailsBtn;
@property (weak, nonatomic) IBOutlet UIButton *activbtn;
@property (weak, nonatomic) IBOutlet UILabel *ActivateBtn;
@property (weak, nonatomic) IBOutlet UIButton *ProductDetailsBtn;
@property (weak, nonatomic) IBOutlet UILabel *product_addPrice;
@property (weak, nonatomic) IBOutlet UILabel *product_RePrice;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *linesaveprice;
@property (weak, nonatomic) IBOutlet UIView *cornerView;
@property (weak, nonatomic) IBOutlet UILabel *offlab;
@property (weak, nonatomic) IBOutlet UIView *additionalview;
@property (weak, nonatomic) IBOutlet UITextView *textvieeproce;
@property (weak, nonatomic) IBOutlet UILabel *adddigitallab;
@property (weak, nonatomic) IBOutlet UILabel *savePrice;
@property (weak, nonatomic) IBOutlet UILabel *perpoundlab;
@property (weak, nonatomic) IBOutlet UIView *savelineview;
@property (weak, nonatomic) IBOutlet UILabel *product_titleactivelab;
@property (weak, nonatomic) IBOutlet UIImageView *activeimg;
@property (weak, nonatomic) IBOutlet UILabel *withfraewaytitle;
@property (weak, nonatomic) IBOutlet UILabel *additemsplus;
@property (weak, nonatomic) IBOutlet UILabel *limitShowlab;
@property (weak, nonatomic) IBOutlet UIButton *relateditemsbtn;
@property (weak, nonatomic) IBOutlet UILabel *Getproductprice;
@property (weak, nonatomic) IBOutlet UIImageView *stickersimg;
@property (weak, nonatomic) IBOutlet UIView *removeview;
@property (weak, nonatomic) IBOutlet UIView *Activateview;
@property(atomic, weak)MyPersonalPriceViewController *myPersonalPriceViewController;
@property (weak, nonatomic) IBOutlet UIView *linesaveprice2;
@end

NS_ASSUME_NONNULL_END
//
//Printing description of str:
//{
//    AdPrice = "2.9900";
//    AltTitleBarImage = "";
//    BadgeFileName = "https://platform.immdemo.net/web/images/die_coupon_pic.png";
//    BadgeId = 5;
//    BadgeName = "Card+Coupon";
//    BrandId = 1;
//    BrandName = "Sally Hansen";
//    CPRPromoTypeId = 2;
//    CPRPromoTypeName = Group;
//    CategoryID = 2;
//    CategoryName = "Bakery & Bread";
//    CategoryPriority = 13;
//    ClickCount = 0;
//    CouponDiscount = "0.1495";
//    CouponID = 9020;
//    CouponImageURl = "http://images.immdemo.net/coupon/235/FWC_9020.jpeg";
//    CouponLongDescription = "Buy 2 Village Hearth Old Fashioned Wheat Hamburger Buns and get 5% OFF";
//    CouponShortDescription = "Buy 2 Village Hearth Old Fashioned Wheat Hamburger Buns and get 5% OFF";
//    DateAdded = "11/6/2019 3:16:23 AM";
//    Description = "VILLAGE HEARTH OLD FASHIONED HAMBURGER SESAME BUNS";
//    DietaryId = 0;
//    DietaryName = "";
//    DisplayPrice = "<sup>$</sup>2.84";
//    FinalPrice = "2.8405";
//    FreeOffer = 0;
//    Groupname = "A:2";
//    HasRelatedItems = 1;
//    IsEmployeeOffer = 0;
//    IsMidWeek = 0;
//    IsStacked = 1;
//    Isbadged = True;
//    LargeImagePath = "https://images.immdemo.net/product/235/7605700241_2_c5357a1a-67b2-4f03-97b7-386f834f5b9d.png";
//    LimitPerTransection = 1;
//    ListCount = 0;
//    LoyaltyCardNumber = 4804524499;
//    MemberID = 1;
//    MinAmount = 0;
//    OfferDay = 12;
//    OfferDayMsg = "";
//    OfferDefinition = "Buy [X item(s) or $X] from Group A and Get Reward R* from Group A";
//    OfferDefinitionId = 4;
//    OfferDetailId = 4;
//    OfferTypeTagName = "Digital Coupon";
//    OriginatorID = 0;
//    PackagingSize = "8 CT";
//    PageID = 1;
//    PercentSavings = "26.98";
//    PersonalCircularID = 9063;
//    PersonalCircularItemId = 962902;
//    PriceAssociationCode = "";
//    PricingMasterID = 0;
//    PrimaryOfferTypeId = 2;
//    PrimaryOfferTypeName = "Personal Coupons";
//    Quantity = 0;
//    RedeemLimit = 1;
//    RegularPrice = "3.89";
//    RelatedItemCount = 3;
//    RelevancyDetail = "Bought Profile";
//    RelevancyTypeD = 1;
//    RelevantUPC = 7605700241;
//    RequiredQty = 2;
//    RequiresActivation = True;
//    RewardQty = 1;
//    RewardType = 2;
//    RewardValue = "5.00";
//    Savings = "1.0495";
//    SectionNumber = 3;
//    SmallImagePath = "https://images.immdemo.net/product/235/7605700241_2_c5357a1a-67b2-4f03-97b7-386f834f5b9d.png";
//    SpecialInformation = "";
//    StoreID = 407;
//    TileNumber = 16;
//    TileTemplateID = 2;
//    TotalQuantity = 0;
//    UPC = 7605700241;
//    UPCRank = 2444;
//    ValidityEndDate = "11/16/19";
//    ValidityStartDate = "11/4/19";
//    inCircular = 1;
//    oCouponShortDescription = "Buy 2 Village Hearth Old Fashioned Wheat Hamburger Buns and get 5% OFF";
//    oDisplayPrice = "<sup>$</sup>2.84";
//    oGroupname = "A:2";
//    rewardGroupname = "";
//}
//2019-11-06 16:40:49.387931+0530 App[7607:191933] FinalPrice:2.840500
//(lldb)
