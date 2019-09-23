//
//  ParticipantingItemViewController.h
//  Bashas
//
//  Created by kamlesh prajapati on 9/10/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticipntingItemCell.h"
#import "ProductDetailsViewController.h"
#import "ObjectType.h"
#import "Validation.h"
#import "UIView+Toast.h"
#import <SVProgressHUD.h>
NS_ASSUME_NONNULL_BEGIN

@protocol ParticipantingItemViewControllerDelegate <NSObject>
// only Related items From Circular activation
//-(void)BackActivateFuc:(NSMutableDictionary*)dict;
-(void)BackActivateFuc:(NSMutableDictionary*)dict backdatadict:(NSMutableDictionary*)backdatadict;
//Details MoewCouponse
-(void)backActivateFucMoreCouponse:(NSMutableDictionary*)dict;

//related header activate to circular
-(void)RelatedHeaderActivateToCircular:(NSMutableDictionary*)dict;

// Related From MoewCouponse activation
-(void)BackActivateFucRelatedfromCouponse:(NSMutableDictionary*)dict;



-(void)UpdateGroupName:(NSMutableDictionary*)dict;
// quantity remove from circular
-(void)BackRemoveQuantity:(NSMutableDictionary*)dict;



-(void)shoppinglistcount;
-(void)DetailToRelatedsRemoveBack:(NSMutableDictionary*)dict;
-(void)DetailToRelatedsBack:(NSMutableDictionary*)dict;


-(void)DetailToRelatedsAddqty:(NSMutableDictionary*)dict;
-(void)DetailToRelatedsshoppinglistcount;



-(void)AddRelatedCountToatalQty:(NSMutableDictionary*)ReData;
-(void)SubRelatedCountToatalQty:(NSMutableDictionary*)ReData;

-(void)DetailsToRelatedTotalQtySub:(NSMutableDictionary*)Redata;
-(void)DetailsToRelatedTotalQtyAdd:(NSMutableDictionary*)Redata;
-(void)llllll;

-(void)DetailsToRelatedTotalqtyRep:(NSMutableDictionary*)dict;


-(void)detailsToRelatedTodetails:(NSMutableDictionary*)dict;



-(void)shoppingViewListApi;
-(void)ShoppingViewListUpdateAdd:(NSMutableDictionary*)dicts;
-(void)ShoppingViewListUpdateSub:(NSMutableDictionary*)dicts;
@end
@interface ParticipantingItemViewController : UIViewController

@property(strong,atomic)IBOutlet UITableView *ParticipantingTableData;
@property(strong,atomic)IBOutlet UICollectionView *CollectionView;
@property (weak, nonatomic) IBOutlet UIView *HeadershoadShow;
@property (weak, nonatomic) IBOutlet UIButton *ActivateBtn;
@property(strong,atomic)  NSMutableDictionary *dataDict;
@property(strong,atomic)NSString*comefrom;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *Headerstitle;

@property(strong,nonatomic)IBOutlet NSString *iscontrollercheckback;

@property (weak, nonatomic) IBOutlet UIView *Activateview;

@property (weak, nonatomic) IBOutlet UIButton *ActivateheaderBtn;


@property (weak, nonatomic) IBOutlet UILabel *product_titleactivelab;
@property (weak, nonatomic) IBOutlet UIImageView *activeimg;

@property (weak, nonatomic) IBOutlet UILabel *labtitleact;
@property(strong,atomic)IBOutlet UILabel*titleGroup;
@property(strong,atomic)id<ParticipantingItemViewControllerDelegate>Delegate;
-(void)SelectGroupbtn:(NSInteger)indexPath;
-(void)openDetails:(NSInteger)index;
-(void)updatedata:(NSInteger)index;
-(void)addproduct:(NSInteger)index;
-(void)subproduct:(NSInteger)index;
-(void)Removeprouct:(NSInteger)index;
-(void)SelectGroupbtn:(NSMutableArray*)array index:(NSInteger)indexPath;
-(void)backActivateParticipanting:(NSMutableDictionary*)dict;
-(void)removeQuantityFromDetailspage:(NSMutableDictionary*)dicts;
-(void)DetailsRelatedDetailsShoppinglist;
-(void)DetaileRelatedDetaileToUpdatedCircularAdd:(NSMutableDictionary*)dict;


-(void)AddTotalqty:(NSMutableDictionary*)dict;
-(void)SubTotalqty:(NSMutableDictionary*)dict;


-(void)DetailsToParticipantingAddQtyAndSubQty:(NSMutableDictionary*)dict;


-(void)DeatilsShoppinglistcount;


-(void)DetailsRelatedTodetailsTocircularTotalQtyAdd:(NSMutableDictionary*)dict;
-(void)DetaileRelatedDetaileToUpdatedCircularSub:(NSMutableDictionary*)dict;


-(void)shoppinglistviewpage;


-(void)shoppinglistViewpageAdd:(NSMutableDictionary*)dicts;
-(void)shoppinglistViewpageSub:(NSMutableDictionary*)dicts;
@end

NS_ASSUME_NONNULL_END

