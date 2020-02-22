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
-(void)budgeviewhide;
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

@property (weak, nonatomic) IBOutlet UIView *SearchingHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *SeachingTitlelab;
@property (weak, nonatomic) IBOutlet UILabel *SeachingTitleCountlab;


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


@property (weak, nonatomic) IBOutlet UIButton *singledoublebtn;



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
    
    

 @property (weak, nonatomic) IBOutlet UILabel *validateerrorlab;


@property (weak, nonatomic) IBOutlet UILabel *PersonalAddTitlelab;
@property (weak, nonatomic) IBOutlet UILabel *StoreNameAddlab;
@property (strong, nonatomic) IBOutlet UIView *PersonalAddViews;
@property (strong, nonatomic) IBOutlet UIView *ChangeStoreViews;




@property (weak, nonatomic) IBOutlet UIView *ChangeStorePopView;
@property (weak, nonatomic) IBOutlet UIButton *Storenamebtn;
@property (weak, nonatomic) IBOutlet UIButton *Findbtn;
@property (weak, nonatomic) IBOutlet UIButton *updatebtn;

@property (weak, nonatomic) IBOutlet UITextField *txtZipCodeAndAddress;

@property (weak, nonatomic) IBOutlet UITableView *tblForCurrentStoreList;

@property (weak, nonatomic) IBOutlet UILabel *Selectedstorenamelab;


    
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
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightForConstraintPersonalAds;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeStorePropertry;
@property (strong, nonatomic) IBOutlet UIView *viewForMainHeaderPersonalADDS;
@property (strong, nonatomic) IBOutlet UIView *viewForMainHeaderCategorysOffersSavingFilter;
@property (strong, nonatomic) IBOutlet UIView *viewForMainCategorysOffersFilter;
@property (strong, nonatomic) IBOutlet UIView *viewForMainSavingFilter;
@property (strong, nonatomic) IBOutlet UIView *sepeterViesChange;
@property (nonatomic) CGFloat lastContentOffset;
@property (strong, nonatomic) IBOutlet UIView *viewForCategorysFilterAb;
@property (strong, nonatomic) IBOutlet UIView *viewForOffersFilterAb;
@property (strong, nonatomic) IBOutlet UIView *viewForSavingFilterAb;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightForSavingConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightForCategoryOffersConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *WeightForSavingConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *WeightForCategoryConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *WeightForOffersConstraint;
@property (weak, nonatomic) IBOutlet UIButton *btnFullStoreAddressPropertry;
@property (strong, nonatomic) IBOutlet UILabel *lblForCategorysFilterAb;
@property (strong, nonatomic) IBOutlet UILabel *lblForOffersFilterAb;
@property (strong, nonatomic) IBOutlet UILabel *lblForSavingFilterAb;

@end
 


