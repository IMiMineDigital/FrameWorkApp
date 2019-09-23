//
//  FooterCell.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 20/07/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Validation.h"
#import "MyPersonalPriceViewController.h"
NS_ASSUME_NONNULL_BEGIN
@class MyPersonalPriceViewController;
@interface FooterCell : UICollectionViewCell
{
    NSInteger index1;
}
-(void)celldata:(MyPersonalPriceViewController*)myPersonalPriceViewController index:(NSInteger)index;



@property (weak, nonatomic)MyPersonalPriceViewController *myPersonalPriceViewController;
@property (weak, nonatomic) IBOutlet UIButton *Applebtn1;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UIButton *Applebtn2;
@end

NS_ASSUME_NONNULL_END
