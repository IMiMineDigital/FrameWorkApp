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
