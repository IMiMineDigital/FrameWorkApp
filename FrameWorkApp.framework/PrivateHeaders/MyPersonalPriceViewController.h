//
//  MyPersonalPriceViewController.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 20/12/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol MyPersonalPriceViewControllerDelegate <NSObject>

- (void)customSetup;
-(id)function:(NSMutableArray*)dict;
-(void)backShoppinglistDeleted:(NSMutableDictionary*)dict;

-(void)hidentabbar;

-(void)showbolerview;
-(void)hidebolerview;
-(id)getShoppingListCountcircular:(NSMutableArray*)str;

-(void)hidetabbarview;
-(void)showtabbarview;
-(UIView*)hideviewfilteroffers:(UIView*)view;
@end



@interface MyPersonalPriceViewController : UIViewController

@property(strong,atomic)IBOutlet UICollectionView *collectionSingletable;
@property(strong,atomic)IBOutlet UIScrollView *sc;
@property(strong,atomic) NSMutableDictionary*idcatarray;
@property(strong,atomic)NSString*filtertype;
@property(strong,atomic) NSMutableDictionary *categoriesdict;



@property (strong, atomic) NSMutableArray*permanentsaaray;
@property (strong, atomic) NSMutableArray*Globalarraycircularwithadd;




@property(strong,atomic) NSMutableDictionary *FilterByOffersdict;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;;
@property (weak, nonatomic) IBOutlet UIView *audioRecorView;
@property (weak, nonatomic) IBOutlet UIImageView*timeimg;
@property (weak, nonatomic) IBOutlet UIButton *Audiobtn;
@property (weak, nonatomic) IBOutlet UILabel *withfraewaytitle;
@property (weak, nonatomic) IBOutlet UIView *Applesview;
@property (weak, nonatomic) IBOutlet UIView *Deafultpopupview;
@property (weak, nonatomic) IBOutlet UIView *Deafultpopupviewcolor;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UILabel *nothingtextlab;
@property (weak, nonatomic) IBOutlet UIButton *searchbtn;
@property (weak, nonatomic) IBOutlet UIView *PersonalAddView;
@property (weak, nonatomic) IBOutlet UILabel *BorderLab;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *cancelView;
@property(strong,atomic)IBOutlet UICollectionView *collectionDoubletable;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIView *searchView;






@property (weak, nonatomic) IBOutlet UIView *filterclassview;
@property (strong, atomic) IBOutlet UITableView *Filtertable;
@property (weak, nonatomic) IBOutlet UILabel *HeaderTitleFilterclass;
@property (weak, nonatomic) IBOutlet UIView *filterclassheaderView;






@property (weak, nonatomic) IBOutlet UIView *filtercatclassview;
@property (strong, atomic) IBOutlet UITableView *Filtercattable;
@property (weak, nonatomic) IBOutlet UILabel *HeaderTitleFilterCatclass;
@property (weak, nonatomic) IBOutlet UIView *filterCatclassheaderView;


    
    

@property (strong, atomic) IBOutlet UITableView *sortbyTable;
@property (weak, nonatomic) IBOutlet UIView *sortbyclassheaderView;
@property (weak, nonatomic) IBOutlet UILabel *HeaderTitleSortbyclass;
@property (weak, nonatomic) IBOutlet UIView *sortbyclassview;
    
    
    
    
@property(strong,nonatomic)id<MyPersonalPriceViewControllerDelegate>delegate;
@property(strong,atomic)NSString*comefrom;
@property(strong,atomic)IBOutlet UITextField*searchtxt;
-(void)GetCategoriesList:(NSMutableArray*)array;
-(void)GetListCatFromFilter:(NSMutableDictionary*)dict;
-(void)openDetails:(NSInteger)index;
-(void)updatedata:(NSInteger)index;
-(void)UpdateActivateFromRelatedItems:(NSInteger)index;
-(void)RelatedItems:(NSInteger)index;
-(void)UpdateGroupName:(NSMutableDictionary*)dict;
-(void)RemoveFromQuantityCircular:(NSMutableDictionary*)dict;
-(void)Removeprouct:(NSInteger)index;
-(void)addproduct:(NSInteger)index;
-(void)subproduct:(NSInteger)index;
-(void)BackRemoveQuantity:(NSMutableDictionary*)dict;
-(void)BackActivateFucDetails:(NSMutableDictionary*)dict;
-(void)BackActivateFuc:(NSMutableDictionary*)dict backdatadict:(NSMutableDictionary*)backdatadict;
-(void)backShoppinglistDeleted:(NSMutableDictionary*)dict;
-(void)RelatedHeaderActivateToCircular:(NSMutableDictionary*)dict;
-(void)AllDeleteShoppingListCircularUpdated;
-(void)shoppinglistcount;
-(void)apple1:(NSInteger)index;
-(void)apple2:(NSInteger)index;
-(void)shoppinglisttocircularQuantityUpdate:(NSMutableDictionary*)dict;

-(void)AddRelatedCountToatalQty:(NSMutableDictionary*)ReData;
-(void)SubRelatedCountToatalQty:(NSMutableDictionary*)ReData;

-(void)shoppingToCircularSubRelatedCountToatalQty:(NSMutableDictionary*)ReData;
-(void)ShoppingListToCircularAddRelatedCountToatalQty:(NSMutableDictionary*)ReData;
-(void)getshopinglistcount;

-(void)Filterviewclasshide;
-(void)Filterviewclassshow;



-(void)filterclasscatviewhide;
-(void)filterclasscatviewshow;
    
-(void)sortbyviewhide;
-(void)sortbyviewshow;
-(void)GetstoreUpdated;

-(void)ClearAllFiltersForMain;


-(void)ClearAllDataShoppingToCircular;


-(void)shoppingToCircularIndexdataClear:(NSMutableDictionary*)backdata;
@end

//BOOL animationsEnabled = [UIView areAnimationsEnabled];
//[UIView setAnimationsEnabled:NO];
//[myCollectionView reloadItemsAtIndexPaths:myIndexPaths];
//[UIView setAnimationsEnabled:animationsEnabled];
//AdPrice = "0.9900";
//AltTitleBarImage = "";
//BadgeFileName = "";
//BadgeId = 0;
//BadgeName = "";
//BrandId = 1;
//BrandName = "Sally Hansen";
//CPRPromoTypeId = 0;
//CPRPromoTypeName = "";
//CategoryID = 17;
//CategoryName = "Soup & Canned Goods";
//CategoryPriority = 12;
//ClickCount = 0;
//CouponDiscount = "0.0000";
//CouponID = 0;
//CouponImageURl = "http://images.immdemo.net/coupon/wlarge/couponImg.jpg";
//CouponLongDescription = "";
//CouponShortDescription = "";
//DateAdded = "9/8/2019 10:36:17 PM";
//Description = "CHICKEN OF THE SEA CHUNK LIGHT TUNA IN OIL";
//DietaryId = 0;
//DietaryName = "";
//DisplayPrice = "99<sup>&cent;</sup>";
//FinalPrice = "0.9900";
//FreeOffer = 0;
//Groupname = "";
//HasRelatedItems = 0;
//IsEmployeeOffer = 0;
//IsMidWeek = 0;
//Isbadged = False;
//LargeImagePath = "https://images.immdemo.net/product/wlarge/00048000001955.png";
//LimitPerTransection = 0;
//ListCount = 0;
//LoyaltyCardNumber = 5155567152;
//MemberID = 41761;
//MinAmount = 0;
//OfferDefinition = "";
//OfferDefinitionId = 0;
//OfferDetailId = 5;
//OfferTypeTagName = "My Sale Item";
//OriginatorID = 0;
//PackagingSize = "5 OZ";
//PageID = 1;
//PercentSavings = "8.33";
//PersonalCircularID = 247;
//PersonalCircularItemId = 23740;
//PriceAssociationCode = "";
//PricingMasterID = 4133332;
//PrimaryOfferTypeId = 1;
//PrimaryOfferTypeName = "Thank You Card Price";
//Quantity = 0;
//RedeemLimit = 1;
//RegularPrice = "1.08";
//RelatedItemCount = 0;
//RelevancyDetail = Pushed;
//RelevancyTypeD = 5;
//RelevantUPC = "4800000195 ";
//RequiredQty = 0;
//RequiresActivation = False;
//RewardQty = 0;
//RewardType = 0;
//RewardValue = "0.00";
//Savings = "0.0900";
//SectionNumber = 7;
//SmallImagePath = "https://images.immdemo.net/product/wlarge/00048000001955.png";
//SpecialInformation = "";
//StoreID = 384;
//TextSavings = "0.090000";
//TileNumber = 103;
//TileTemplateID = 1;
//TotalQuantity = 0;
//UPC = 4800000195;
//UPCRank = 0;
//ValidityEndDate = "9/10/19";
//ValidityStartDate = "9/4/19";
//inCircular = 1;
//oCouponShortDescription = "";
//oDisplayPrice = "99<sup>&cent;</sup>";
//oGroupname = "";
//rewardGroupname = "";
//}


