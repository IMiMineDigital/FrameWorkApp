//
//  SavingViewController.h
//  Bashas
//
//  Created by kamlesh prajapati on 5/10/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Validation.h"
#import "UIView+Toast.h"
#import <SVProgressHUD.h>

@protocol SavingViewControllerDelegate <NSObject>

-(void)showDisbordViewController;

@end
@interface SavingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *BackBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *mypersonalDeals;
@property (weak, nonatomic) IBOutlet UILabel *MyPersonalCoupons;
@property (weak, nonatomic) IBOutlet UILabel *MysaleItems;
@property (weak, nonatomic) IBOutlet UILabel *totoalsaving;
@property(strong,nonatomic)id <SavingViewControllerDelegate >delegate;
@end
