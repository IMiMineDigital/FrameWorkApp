//
//  ProductDetailsViewController.h
//  Bashas
//
//  Created by kamlesh prajapati on 9/10/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPersonalPriceViewController.h"
#import "Validation.h"
#import "UIImageView+AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ProductDetailsViewControllerDelegate <NSObject>
//-(void)BackActivateFuc:(NSMutableDictionary*)dict;
-(void)BackActivateFucDetails:(NSMutableDictionary*)dict;
-(void)backActivateParticipanting:(NSMutableDictionary*)dict;
-(void)backActivateFucMoreCouponse:(NSMutableDictionary*)dict;
-(void)BackRemoveQuantity:(NSMutableDictionary*)dict;
-(void)removeQuantityRelatedFromDetailspage:(NSMutableDictionary*)dicts;
-(void)shoppinglistcount;


-(void)BackRemoveQuantity:(NSMutableDictionary*)dict;
-(void)BackActivateFuc:(NSMutableDictionary*)dict backdatadict:(NSMutableDictionary*)backdatadict;

-(void)DetaileRelatedDetaileToUpdatedCircularAdd:(NSMutableDictionary*)dict;
-(void)UpdatedShoppingAddQtySubAqty:(NSMutableDictionary*)dict;


-(void)AddRelatedCountToatalQty:(NSMutableDictionary*)ReData;
-(void)SubRelatedCountToatalQty:(NSMutableDictionary*)ReData;

//related
-(void)AddTotalqty:(NSMutableDictionary*)dict;
-(void)SubTotalqty:(NSMutableDictionary*)dict;


-(void)CircularToshoppingToatlQtyadd:(NSMutableDictionary*)dict;
-(void)CircularToshoppingToatlQtysub:(NSMutableDictionary*)dict;
-(void)RemoveShoppinglist:(NSMutableDictionary*)dict;


-(void)DetailsToParticipantingAddQtyAndSubQty:(NSMutableDictionary*)dict;

-(void)DeatilsShoppinglistcount;



-(void)DetailsRelatedDetailsShoppinglist;


-(void)DetailsRelatedTodetailsTocircularTotalQtyAdd:(NSMutableDictionary*)dict;
-(void)DetaileRelatedDetaileToUpdatedCircularSub:(NSMutableDictionary*)dict;


-(void)shoppinglist;

-(void)shoppinglistviewpage;
-(void)shoppinglistViewpageAdd:(NSMutableDictionary*)dicts;
-(void)shoppinglistViewpageSub:(NSMutableDictionary*)dicts;
@end




@interface ProductDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *couponsevalueslab;
@property (weak, nonatomic) IBOutlet UIImageView *bannerimg;


@property(strong,atomic)id<ProductDetailsViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *product_name;
@property(strong,nonatomic)IBOutlet NSString *comefrom;

@property (weak, nonatomic) IBOutlet UILabel *additemsplus;
@property (weak, nonatomic) IBOutlet UILabel *saveprice;

@property (weak, nonatomic) IBOutlet UILabel *Getproductprice;
@property (weak, nonatomic) IBOutlet UIView *addtolistview;
@property (weak, nonatomic) IBOutlet UILabel *productlong_name;
@property (weak, nonatomic) IBOutlet UIView *shoadShow;
@property(strong,nonatomic) NSMutableDictionary *data;



@property(strong,nonatomic) NSMutableArray *circheckedcouponseArry;

@property (weak, nonatomic) IBOutlet UIButton *addbtn;

@property (weak, nonatomic) IBOutlet UILabel *ActivateBtn;
@property (weak, nonatomic) IBOutlet UIButton *activebtncolor;
@property(strong,nonatomic)IBOutlet NSString *shoopinglistcomeform;
@property(strong,nonatomic) NSMutableDictionary *shoppingListdata;
@property (weak, nonatomic) IBOutlet UIView *RelateditemsVies;
@property (weak, nonatomic) IBOutlet UILabel *withfraewaytitle;

@property (weak, nonatomic) IBOutlet UILabel *productprice;
@property (weak, nonatomic) IBOutlet UILabel *litleActlab;
@property (weak, nonatomic) IBOutlet UIImageView *btnimg;
@property (weak, nonatomic) IBOutlet UILabel *btntitle;
@property (weak, nonatomic) IBOutlet UIView *RelatedView;
@property (weak, nonatomic) IBOutlet UIButton *AdditemsBtn;
////// activate
@property (weak, nonatomic) IBOutlet UIView *removeview;
@property (weak, nonatomic) IBOutlet UIView *Activateview;

@property (weak, nonatomic) IBOutlet UILabel *countproductlab;
@property (weak, nonatomic) IBOutlet UIButton *addbtns;
@property (weak, nonatomic) IBOutlet UIButton *subbtn;
@property (weak, nonatomic) IBOutlet UILabel *addlab;
@property (weak, nonatomic) IBOutlet UILabel *sublab;
//@property (weak, nonatomic) IBOutlet UILabel *addtolist_titlelab;
//orfertype==2







@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UILabel *Regular_price2;
@property (weak, nonatomic) IBOutlet UILabel *Regular_priceTitle;

@property (weak, nonatomic) IBOutlet UILabel *labTitle2;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UIView *view2;


@property (weak, nonatomic) IBOutlet UILabel *labTitle3;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UIView *view3;


@property (weak, nonatomic) IBOutlet UILabel *labTitle4;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UIView *view4;

@property (weak, nonatomic) IBOutlet UILabel *labTitle5;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UIView *view5;

@property (weak, nonatomic) IBOutlet UILabel *labTitle6;
@property (weak, nonatomic) IBOutlet UILabel *lab6;
@property (weak, nonatomic) IBOutlet UIView *view6;

@property (weak, nonatomic) IBOutlet UILabel *labTitle7;
@property (weak, nonatomic) IBOutlet UILabel *lab7;
@property (weak, nonatomic) IBOutlet UIView *view7;

@property (weak, nonatomic) IBOutlet UIButton *Relateditems;
@property (weak, nonatomic) IBOutlet UIView *view8;
-(void)DetailToRelatedsBack:(NSMutableDictionary*)dict;
-(void)DetailToRelatedsRemoveBack:(NSMutableDictionary*)dict;
-(void)DetailToRelatedsAddqty:(NSMutableDictionary*)dict;
-(void)DetailToRelatedsshoppinglistcount;
-(void)DetailsToRelatedTotalQtySub:(NSMutableDictionary*)Redata;
-(void)DetailsToRelatedTotalQtyAdd:(NSMutableDictionary*)Redata;

-(void)DetailsToRelatedTotalqtyRep:(NSMutableDictionary*)dict;
-(void)detailsToRelatedTodetails:(NSMutableDictionary*)dict;

-(void)shoppingViewListApi;
-(void)ShoppingViewListUpdateAdd:(NSMutableDictionary*)dicts;
-(void)ShoppingViewListUpdateSub:(NSMutableDictionary*)dicts;
@end

NS_ASSUME_NONNULL_END
//Printing description of self->_shoppingListdata:
//{
//    CPRPromoTypeId = 1;
//    Couponid = 30640;
//    Description = "$2.00 OFF";
//    ExpirationDate = "2020-07-18";
//    GroupName = "";
//    HasRelatedItems = 0;
//    Hovermsg = 0;
//    Limit = 1;
//    OfferCaseType = Normal;
//    Price = "2.00";
//    PrimaryOfferTypeid = 2;
//    RUPC = 30640;
//    RequiredQty = 1;
//    Storeid = 126;
//    UPC = 30640;
//    condition = 2;
//}

