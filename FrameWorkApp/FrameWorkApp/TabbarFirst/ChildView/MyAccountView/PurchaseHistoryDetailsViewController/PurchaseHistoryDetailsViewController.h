//
//  PurchaseHistoryDetailsViewController.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 10/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchaseHistoryDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *datelab;
@property (weak, nonatomic) IBOutlet UILabel *locationlab;
@property (weak, nonatomic) IBOutlet UILabel *totalpricepaidlab;
@property (weak, nonatomic) IBOutlet UILabel *totalitemslab;
@property (weak, nonatomic) IBOutlet UILabel *totalsavingslab;
@property (weak, nonatomic) IBOutlet UILabel *Totalpricebuttomlab;
@property(strong,nonatomic) NSMutableDictionary*purchaseid;
@property(strong,atomic)IBOutlet UITableView *historyDetailstable;
@end

NS_ASSUME_NONNULL_END
