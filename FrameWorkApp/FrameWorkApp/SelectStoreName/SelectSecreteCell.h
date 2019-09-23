//
//  SelectSecreteCell.h
//  Bashas
//
//  Created by kamlesh prajapati on 18/11/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectSecreteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *city_name;
-(void)celldata:(NSMutableDictionary*)dict;
@property(strong,atomic)IBOutlet UIButton*checkmarkbtn;
@end

NS_ASSUME_NONNULL_END
