//
//  PurchaseHistoryCell.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 8/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "PurchaseHistoryCell.h"
#import "Validation.h"
#import "PurchaseHistoryViewController.h"
@implementation PurchaseHistoryCell
{
    NSInteger index;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [Validation addShadowToView:self.shoadShow];
}

-(void)cellondata:(NSMutableDictionary*)dict
{
    
      _linkbtn.titleLabel.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
      [_linkbtn setTitle:[dict valueForKey:@"purchasedate"] forState:UIControlStateNormal];
     _locationlab.text=dict[@"storelocation"];
     _totalspentlab.text=[NSString stringWithFormat:@"$%.02f",[dict[@"totalamount"] floatValue]];
      _totalsavingslab.text=[NSString stringWithFormat:@"$%.02f",[dict[@"remainamount"] floatValue]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
