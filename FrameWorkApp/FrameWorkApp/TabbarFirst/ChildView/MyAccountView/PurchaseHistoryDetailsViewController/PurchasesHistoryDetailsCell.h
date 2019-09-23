//
//  PurchasesHistoryDetailsCell.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 10/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchasesHistoryDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *productlab;
@property (weak, nonatomic) IBOutlet UILabel *upclab;
@property (weak, nonatomic) IBOutlet UILabel *Qtylab;
@property (weak, nonatomic) IBOutlet UILabel *yoursavinglab;
@property (weak, nonatomic) IBOutlet UILabel *unitpricelab;
@property (weak, nonatomic) IBOutlet UILabel *trotalpricelab;
-(void)cellondata:(NSMutableDictionary*)dict;

@property (weak, nonatomic) IBOutlet UILabel *titleidlab;
@end

NS_ASSUME_NONNULL_END
