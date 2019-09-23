//
//  ActivatedOffersCell.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 8/07/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoppingListViewcontroller.h"

NS_ASSUME_NONNULL_BEGIN
@class SoppingListViewcontroller;
@interface ActivatedOffersCell : UITableViewCell
{
    NSInteger index1;
}
-(void)CellOndata:(NSMutableDictionary*)dict soppingListViewcontroller:(SoppingListViewcontroller*)soppingListViewcontroller index:(NSInteger)index;
@property (weak, nonatomic) IBOutlet UILabel *shoppingproduct_name;
@property (weak, nonatomic) IBOutlet UILabel *shoppingExpdate;
@property (weak, nonatomic) IBOutlet UIView *shoppingShow;
@property (weak, nonatomic) IBOutlet UIView *hurview;
@property (weak, nonatomic) IBOutlet UIButton *btnact;
@property (weak, nonatomic) IBOutlet UILabel *titleid;
@property(atomic,weak)SoppingListViewcontroller*soppingListViewcontroller;

@end

NS_ASSUME_NONNULL_END
