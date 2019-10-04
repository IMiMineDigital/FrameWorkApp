//
//  HomeViewController.h
//  Bashas
//
//  Created by kamlesh prajapati on 20/10/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN
@protocol HomeViewControllerDelegate <NSObject>
- (void)customSetup;
-(void)getdata:(NSMutableArray*)dict;
-(void)GetCategoriesList:(NSMutableArray*)array;
-(void)GetListCatFromFilter:(NSMutableDictionary*)dict;
-(void)dismisFun;
-(void)backShoppinglistDeleted:(NSMutableDictionary*)dict;


-(void)ischeckfiler:(NSString*)str;
-(void)shoppinh:(NSString*)str;
//k5muDp
-(void)soppinglist:(UIViewController*)con;
-(void)shoppinglisttocircularQuantityUpdate:(NSMutableDictionary*)dict;



-(void)AddRelatedCountToatalQty:(NSMutableDictionary*)ReData;
-(void)SubRelatedCountToatalQty:(NSMutableDictionary*)ReData;

-(void)Filterviewclasshide;
-(void)Filterviewclassshow;


-(void)filterclasscatviewhide;
-(void)filterclasscatviewshow;


    -(void)sortbyviewhide;
    -(void)sortbyviewshow;


-(void)ClearAllDataShoppingToCircular;
@end
@interface HomeViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UIButton *soppingbtn;
@property (weak, nonatomic) IBOutlet UIButton *menubtn;
@property (weak, nonatomic) NSMutableArray*receivefiltertypearray;
@property (weak, nonatomic) NSMutableArray*idcatarray;
@property (weak, nonatomic) NSMutableArray*FilterByoffersarray;
@property (weak, nonatomic) IBOutlet UIButton *savingbtn;
@property (weak, nonatomic) IBOutlet UIButton *filterbtn;
@property (weak, nonatomic) IBOutlet UIButton *Homebtn;
@property (weak, nonatomic) IBOutlet UIButton *Shoppinglistbtn;
@property (weak, nonatomic) IBOutlet UIButton *Mylistbtn;





@property (weak, nonatomic) IBOutlet UIButton *Filtercatbtn;
@property (weak, nonatomic) IBOutlet UIButton *FilterOffersbtn;
@property (weak, nonatomic) IBOutlet UIImageView *Filtercatimg;
@property (weak, nonatomic) IBOutlet UIImageView *FilterOffersimg;






@property (weak, nonatomic) IBOutlet UIView *activeIndicatorView;

//@property(strong,atomic)IBOutlet UIView*shoppingFilterView;
@property (weak, nonatomic) IBOutlet UIView *myAccountView;

@property (weak, nonatomic) IBOutlet UIView *bolerView;

@property(strong,atomic)UINavigationController *navcontroller;
@property(strong,atomic)IBOutlet UIView*Filterview;
@property(strong,atomic)NSString * isCheckController;
@property (weak, nonatomic) IBOutlet UIButton *Doublebtnimage;
@property(strong,atomic)IBOutlet UIView*budgeView;



@property (weak, nonatomic) IBOutlet UILabel *Shopingcount;
@property(strong,atomic)IBOutlet UIView*ParentView;
@property(strong,atomic)NSString * comefrom;
@property(strong,atomic)NSString* filtertype;
@property(strong,nonatomic)id<HomeViewControllerDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIButton *MoreBtn;
@property(strong,atomic)IBOutlet UIView*btnView;
-(void) hideBottomBar;
-(void) showBottomBar;
-(void)customSetup;
-(void)CircularPage;
-(void)showDisbordViewController;
-(void)AddMypersonalPriceController;
-(id)function:(NSMutableArray*)dict;
- (IBAction)filtersBTn:(UIButton*)sender;
-(void)isHomeView;
-(id)shoppinglistFiler:(NSMutableArray*)array;
-(id)getShoppingListCount:(NSMutableArray*)str;
-(void)Deleteshoppinglist:(NSMutableDictionary*)dict;
-(void)getshopinglist;
-(void)UpdateCircularForShopping;
-(void)hidentabbar;
-(void)hidebolerview;
-(void)showbolerview;
-(void)budgeviewhide;
-(void)backCircularpageForShoppinglist;
-(void)shoppingToCircularUpdateqty:(NSMutableDictionary*)dict;
-(UIView*)hideview:(UIView*)view;
-(void)shoppingToCircularUpdateTotalqtyadd:(NSMutableDictionary*)dicts;
-(void)shoppingToCircularUpdateTotalqtysub:(NSMutableDictionary*)dicts;


-(void)hidetabbarview;
-(void)showtabbarview;


-(UIView*)hideviewfilteroffers:(UIView*)view;

-(void)shoppingTocircularAllDelete;
-(void)shoppingTocircularindexdataClear:(NSMutableDictionary*)dicts;
@end

NS_ASSUME_NONNULL_END
