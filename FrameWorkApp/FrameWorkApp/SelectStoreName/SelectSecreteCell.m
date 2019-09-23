//
//  SelectSecreteCell.m
//  Bashas
//
//  Created by kamlesh prajapati on 18/11/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import "SelectSecreteCell.h"

@implementation SelectSecreteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)celldata:(NSMutableDictionary*)dict
{
   _city_name.text=[NSString stringWithFormat:@"%@",dict];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
