//
//  ParticipntingItemCell.h
//  Bashas
//
//  Created by kamlesh prajapati on 9/10/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticipantingItemViewController.h"
#import "UIImageView+AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN
@class ParticipantingItemViewController;
@interface ParticipntingItemCell : UITableViewCell{
    NSInteger index;
}

-(void)cellOnData:(NSMutableDictionary*)str participantingItemViewController:(ParticipantingItemViewController*)participantingItemViewController index1:(NSInteger)index1;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *savepriceimg;
@property (weak, nonatomic) IBOutlet UILabel *product_name;
@property (weak, nonatomic) IBOutlet UILabel *product_price;
@property (weak, nonatomic) IBOutlet UIView *shoadShow;
@property (weak, nonatomic) IBOutlet UIButton *seeeDetailsBtn;
@property (weak, nonatomic) IBOutlet UIButton *relateditemsbtn;
@property (weak, nonatomic) IBOutlet UILabel *ActivateBtn;
@property (weak, nonatomic) IBOutlet UIButton *ProductDetailsBtn;
@property (weak, nonatomic) IBOutlet UILabel *product_addPrice;
@property (weak, nonatomic) IBOutlet UILabel *product_RePrice;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *cornerView;
@property (weak, nonatomic) IBOutlet UILabel *offlab;
@property (weak, nonatomic) IBOutlet UILabel *additemsplus;

@property (weak, nonatomic) IBOutlet UITextView *textvieeproce;
@property (weak, nonatomic) IBOutlet UILabel *savePrice;
@property (weak, nonatomic) IBOutlet UILabel *perpoundlab;
@property (weak, nonatomic) IBOutlet UIView *savelineview;

@property (weak, nonatomic) IBOutlet UIView *animationview;


@property (weak, nonatomic) IBOutlet UILabel *limitShowlab;

@property (weak, nonatomic) IBOutlet UIButton *activbtn;
@property (weak, nonatomic) IBOutlet UILabel *product_titleactivelab;
@property (weak, nonatomic) IBOutlet UIImageView *activeimg;
@property(atomic, weak)ParticipantingItemViewController *participantingItemViewController;
@property (weak, nonatomic) IBOutlet UIView *linesaveprice2;
@property (weak, nonatomic) IBOutlet UILabel *adddigitallab;
@property (weak, nonatomic) IBOutlet UILabel *withfraewaytitle;
//@property (weak, nonatomic) IBOutlet UILabel *addtolist_titlelab;
@property (weak, nonatomic) IBOutlet UIView *linesaveprice;
@property (weak, nonatomic) IBOutlet UILabel *countproductlab;
@property (weak, nonatomic) IBOutlet UIButton *addbtn;
@property (weak, nonatomic) IBOutlet UIButton *subbtn;
@property (weak, nonatomic) IBOutlet UILabel *addlab;
@property (weak, nonatomic) IBOutlet UILabel *sublab;
@property (weak, nonatomic) IBOutlet UIView *addtolistview;

@property (weak, nonatomic) IBOutlet UIView *removeview;
@property (weak, nonatomic) IBOutlet UIView *Activateview;
@property (weak, nonatomic) IBOutlet UIButton *removebtn;
@end

NS_ASSUME_NONNULL_END

