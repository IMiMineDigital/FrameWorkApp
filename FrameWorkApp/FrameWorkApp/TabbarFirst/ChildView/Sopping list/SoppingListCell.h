//
//  SoppingListCell.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 21/04/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SoppingListViewcontroller;
@interface SoppingListCell : UITableViewCell
{
    NSInteger index;
}
-(void)cellOnData:(NSMutableDictionary*)str soppingListViewcontroller:(SoppingListViewcontroller*)soppingListViewcontroller index1:(NSInteger)index1;
@property (weak, nonatomic) IBOutlet UIView *shoadShow;
@property (weak, nonatomic) IBOutlet UIView *hurview;
@property (weak, nonatomic) IBOutlet UILabel *product_name;
@property (weak, nonatomic) IBOutlet UILabel *titleid;
@property (weak, nonatomic) IBOutlet UILabel *product_price;

@property (weak, nonatomic) IBOutlet UILabel *Coupnproduct_name;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UIButton *AddOwndeletebtn;
@property (weak, nonatomic) IBOutlet UILabel *qtylab;
@property (weak, nonatomic) IBOutlet UILabel *addlab;
@property (weak, nonatomic) IBOutlet UILabel *sublab;
@property (weak, nonatomic) IBOutlet UIButton *subbtn;
-(void)celldata:(NSMutableDictionary*)data;
@property (weak, nonatomic) IBOutlet UIButton *removeview;

@property (weak, nonatomic) IBOutlet UIButton *deletebtn;
@property(atomic, weak)SoppingListViewcontroller *soppingListViewcontroller;
@end

NS_ASSUME_NONNULL_END
