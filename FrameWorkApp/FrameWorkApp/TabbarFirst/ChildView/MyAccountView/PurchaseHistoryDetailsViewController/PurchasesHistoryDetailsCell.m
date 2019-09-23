//
//  PurchasesHistoryDetailsCell.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 10/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "PurchasesHistoryDetailsCell.h"
#import "Validation.h"
@implementation PurchasesHistoryDetailsCell

- (void)awakeFromNib
{
    [super awakeFromNib];
   [Validation addShadowToView:self.shadowView];
}
-(void)cellondata:(NSMutableDictionary*)dict
{
    
    _Qtylab.text=dict[@"iQuantity"];
    _unitpricelab.text=[NSString stringWithFormat:@"$%.02f",[dict[@"fUnitprice"] floatValue]];
    _trotalpricelab.text=[NSString stringWithFormat:@"$%@",dict[@"subtotalamount"]];
    _productlab.text=dict[@"vDescription"];
    _upclab.text=[NSString stringWithFormat:@"UPC:%@",dict[@"vUPCCode"]];
    _yoursavinglab.text=[NSString stringWithFormat:@"Your savings:$%@",dict[@"subsavingamount"]];
    _titleidlab.hidden=YES;
    if ([dict[@"couponflag"] isEqualToString:@"My Sale Item"])
    {
         _titleidlab.backgroundColor=[UIColor colorWithRed:9/255.0 green:82/255.0 blue:149/255.0 alpha:1.0];
           _titleidlab.text=@"My Sale Item";
        
    }
    else if ([dict[@"couponflag"] isEqualToString:@"Digital Coupon"])
    {
      _titleidlab.backgroundColor=[UIColor colorWithRed:156/255.0 green:186/255.0 blue:95/255.0 alpha:1.0];
           _titleidlab.text=@"Digital Coupon";
        
    }
    else if ([dict[@"couponflag"] isEqualToString:@"My Personal Deal"])
    {
         _titleidlab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];//red
        _titleidlab.text=@"My Personal Deal";
    }
    [self setimgeFromProduct:dict];
    
}
-(void)setimgeFromProduct:(NSMutableDictionary*)dict
{
    
   // NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString*defaultimg=@"http://fwstaging.immdemo.net/web/images/GEnoimage.jpg";
    if ([dict[@"image"] isEqualToString:defaultimg] || [dict[@"image"] isEqualToString:@""])
    {
        //_img.image=[UIImage imageNamed:@"GEnoimage.jpg" inBundle:bundle compatibleWithTraitCollection:nil];
          [Validation getPostImageFromServer_v2:DEFAULTIMG_URL showOnpostimage:self.img];
    }
    else
    {
        [Validation getPostImageFromServer_v2:dict[@"image"] showOnpostimage:self.img];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
