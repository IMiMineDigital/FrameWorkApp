//
//  PurchaseHistoryViewController.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 8/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PurchaseHistoryViewControllerDelegate <NSObject>
-(void)AddMypersonalPriceController;
@end
@interface PurchaseHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property(strong,atomic)IBOutlet UITableView *historytable;


@property(strong,nonatomic)id<PurchaseHistoryViewControllerDelegate>delegate;
@property (weak, nonatomic) NSString *Checkback;



@end

NS_ASSUME_NONNULL_END
