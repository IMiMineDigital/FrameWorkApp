//
//  PurchaseHistoryCell.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 8/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseHistoryViewController.h"
NS_ASSUME_NONNULL_BEGIN


@interface PurchaseHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *shoadShow;
@property (weak, nonatomic) IBOutlet UIButton *linkbtn;
@property (weak, nonatomic) IBOutlet UILabel *locationlab;
@property (weak, nonatomic) IBOutlet UILabel *totalspentlab;
@property (weak, nonatomic) IBOutlet UILabel *totalsavingslab;
-(void)cellondata:(NSMutableDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
