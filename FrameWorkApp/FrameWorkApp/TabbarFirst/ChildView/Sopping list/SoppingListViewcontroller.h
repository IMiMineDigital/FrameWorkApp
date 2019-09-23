//
//  SoppingListViewcontroller.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 21/04/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol SoppingListViewcontrollerDelegate <NSObject>
-(id)getShoppingListCount:(NSMutableArray*)str;
-(void)backShoppinglistDeleted:(NSMutableDictionary*)dict;
-(void)AddMypersonalPriceController;
-(void)UpdateCircularForShopping;
-(void)Deleteshoppinglist:(NSMutableDictionary*)dict;
-(void)showbolerview;
-(void)hidebolerview;
-(void)budgeviewhide;
-(void)backCircularpageForShoppinglist;
-(void)filterviewhide;
-(UIView*)hideview:(UIView*)view;
-(void)shoppingToCircularUpdateqty:(NSMutableDictionary*)dict;
-(void)shoppingToCircularUpdateTotalqtyadd:(NSMutableDictionary*)dicts;
-(void)shoppingToCircularUpdateTotalqtysub:(NSMutableDictionary*)dicts;
@end
@interface SoppingListViewcontroller : UIViewController
@property(weak,nonatomic)id<SoppingListViewcontrollerDelegate>delegate;
@property(strong,atomic)NSMutableArray*arrayobj;
@property (weak, nonatomic) NSString *Checkback;
@property (weak, nonatomic) IBOutlet UIView *EmailView;

@property (weak, nonatomic) IBOutlet UIView *cancelView;
@property (weak, nonatomic) IBOutlet UIButton *sendbtn;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;

@property(strong,atomic)NSString * isCheckfilter;

@property(strong,atomic)NSMutableArray *btnFilterShoppingListArray;



@property(strong,atomic)NSMutableArray *CirCouponseidChecked;

@property (weak, nonatomic) IBOutlet UIView *bolerView;

@property (weak, nonatomic) IBOutlet UILabel *qtylab;
@property (weak, nonatomic) IBOutlet UILabel *pricelab;
@property (weak, nonatomic) IBOutlet UILabel *Explab;

@property (strong, nonatomic) IBOutlet UIView *AdditemsView;
@property (weak, nonatomic) IBOutlet UITextView *additemsTextField;
@property (weak, nonatomic) IBOutlet UIButton *additemsbtnsend;
@property(strong,atomic)IBOutlet UIView*shoppingFilterView;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (unsafe_unretained, atomic)NSInteger shoppinindexno;
@property(strong,nonatomic)IBOutlet UITableView *activatedOffersTable;
@property(strong,atomic)IBOutlet UITableView *soppingTable;
@property (weak, nonatomic) IBOutlet UIView *headerview;
-(void)deleterowlist:(NSInteger)index;
-(void)backShoppinglistDeleted:(NSMutableDictionary*)dict;
-(void)ischeckfiler:(NSString*)str;
-(void)addproduct:(NSInteger)index;
-(void)subproduct:(NSInteger)index;
-(void)addproductzero:(NSInteger)index;
-(void)Subproductzero:(NSInteger)index;
-(void)detailspage:(NSInteger)index;
-(void)UpdatedShoppingAddQtySubAqty:(NSMutableDictionary*)dict;
-(void)detailspagee:(NSInteger)index;
-(void)CircularToshoppingToatlQtyadd:(NSMutableDictionary*)dict;
-(void)CircularToshoppingToatlQtysub:(NSMutableDictionary*)dict;
-(void)RemoveShoppinglist:(NSMutableDictionary*)dict;


-(void)shoppinglists;
@end

NS_ASSUME_NONNULL_END
