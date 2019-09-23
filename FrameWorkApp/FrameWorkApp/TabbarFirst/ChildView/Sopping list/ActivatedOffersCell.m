//
//  ActivatedOffersCell.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 8/07/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "ActivatedOffersCell.h"
#import "Validation.h"
#import "SoppingListViewcontroller.h"
@implementation ActivatedOffersCell
{
       NSMutableDictionary*dict;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [Validation addShadowToView:self.shoppingShow];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
    [_shoppingShow addGestureRecognizer:tap];
}
-(void)handleImageTap:(UITapGestureRecognizer*)gestureRecognizer
{
    [self endEditing:YES];
    _titleid.hidden=YES;
    
}
-(void)CellOndata:(NSMutableDictionary*)dict soppingListViewcontroller:(SoppingListViewcontroller*)soppingListViewcontroller index:(NSInteger)index
{
     _titleid.hidden=YES;
     [Validation setRoundView:_hurview borderWidth:0 borderColor:0 radius:_hurview.layer.frame.size.height/2];
     index1=index;
    dict=dict;
     if ([dict[@"PrimaryOfferTypeid"] integerValue]==2)
     {
 
         _titleid.text=@"Digital Coupon";
          _shoppingproduct_name.text=[NSString stringWithFormat:@"%@",dict[@"Description"]];
         _hurview.backgroundColor=[UIColor colorWithRed:156/255.0 green:186/255.0 blue:95/255.0 alpha:1.0];
         _titleid.backgroundColor=[UIColor colorWithRed:156/255.0 green:186/255.0 blue:95/255.0 alpha:1.0];
     }
    else if ([dict[@"PrimaryOfferTypeid"] integerValue]==3)
    {
        
            _shoppingproduct_name.text=[NSString stringWithFormat:@"%@\n$%.02f",dict[@"Description"],[dict[@"Price"] floatValue]];
          _hurview.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
         _titleid.text=@"My Personal Deal";
         _titleid.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    }
  
  
  
    NSString*dateString=[NSString stringWithFormat:@"%@",dict[@"ExpirationDate"]];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:dateString];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSString* Expdate = [format stringFromDate:date];
   _shoppingExpdate.text=[NSString stringWithFormat:@"%@",Expdate];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}
-(IBAction)Hurbtn:(id)sender
{
    _titleid.hidden=NO;
}

@end
