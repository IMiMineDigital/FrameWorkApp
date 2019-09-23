//
//  SoppingListCell.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 21/04/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "SoppingListCell.h"
#import "Validation.h"
#import "SoppingListViewcontroller.h"
@implementation SoppingListCell
{
    NSMutableDictionary*dict;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [Validation addShadowToView:self.shoadShow];
    _addlab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    _sublab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    [Validation setRoundView:self.addlab borderWidth:0 borderColor:nil radius:_addlab.layer.frame.size.height/2];
    [Validation setRoundView:self.sublab borderWidth:0 borderColor:nil radius:_sublab.layer.frame.size.height/2];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
    [_shoadShow addGestureRecognizer:tap];
}
-(void)handleImageTap:(UITapGestureRecognizer*)gestureRecognizer
{
    [self endEditing:YES];
    _titleid.hidden=YES;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)cellOnData:(NSMutableDictionary*)str soppingListViewcontroller:(SoppingListViewcontroller*)soppingListViewcontroller index1:(NSInteger)index1
{
    _soppingListViewcontroller=soppingListViewcontroller;
    index = index1;
    dict=str;
    [self celldata:str];
}


-(void)celldata:(NSMutableDictionary*)data
{
    
   
        _titleid.hidden=YES;
       _hurview.hidden=NO;
       _product_price.hidden=YES;
       [Validation setRoundView:_hurview borderWidth:0 borderColor:0 radius:_hurview.layer.frame.size.height/2];
       [_deletebtn setTitleColor:[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0] forState:UIControlStateNormal];
          NSString* camelCaseString = [data valueForKey:@"LongDescription"];
            [self stringByReplacingSnakeCaseWithCamelCase:camelCaseString lab:_product_name];
         _product_price.text=[NSString stringWithFormat:@"$%.02f",[data[@"SalesPrice"] floatValue]];
         _qtylab.text=[NSString stringWithFormat:@"%@",data[@"Quantity"]];
    
      if ([data[@"PrimaryOfferTypeId"] integerValue]==1)
       {
           
               _product_price.hidden=YES;
               _AddOwndeletebtn.hidden=YES;
               _deletebtn.hidden=NO;
              _Coupnproduct_name.hidden=YES;
             _titleid.backgroundColor=[UIColor colorWithRed:9/255.0 green:82/255.0 blue:149/255.0 alpha:1.0];
             _titleid.text=@"My Sale Items";
           // _product_price.hidden=NO;
            _hurview.backgroundColor=[UIColor colorWithRed:9/255.0 green:82/255.0 blue:149/255.0 alpha:1.0];
            [self setimgeFromProduct:data];
       }
      else if ([data[@"PrimaryOfferTypeId"] integerValue]==0)
      {
           _Coupnproduct_name.hidden=YES;
           _hurview.hidden=YES;
           _AddOwndeletebtn.hidden=NO;
           _deletebtn.hidden=YES;
           _product_price.hidden=YES;
          [self setimgeFromProductzero:data];
          
     
      }
        else if ([data[@"PrimaryOfferTypeId"] integerValue]==3)
         {
              _titleid.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
               _AddOwndeletebtn.hidden=YES;
               _deletebtn.hidden=NO;
                 _product_price.hidden=YES;
               //_product_price.hidden=NO;
               _Coupnproduct_name.hidden=YES;
               _titleid.text=@"My Personal Deal";
                _hurview.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
             [self setimgeFromProduct:data];
      }
        else if ([data[@"PrimaryOfferTypeId"] integerValue]==2)
        {
            _titleid.backgroundColor=[UIColor colorWithRed:156/255.0 green:186/255.0 blue:95/255.0 alpha:1.0];
            _AddOwndeletebtn.hidden=YES;
            _deletebtn.hidden=NO;
            //_product_price.hidden=NO;
                _product_price.hidden=YES;
            _Coupnproduct_name.hidden=YES;
            _titleid.text=@"Digital Coupons";
            _hurview.backgroundColor=[UIColor colorWithRed:156/255.0 green:186/255.0 blue:95/255.0 alpha:1.0];
            [self setimgeFromProduct:data];
        }
  
}
-(void)setimgeFromProductzero:(NSMutableDictionary*)dict
{
  //  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString*defaultimg=@"";
    if ([dict[@"ImageURL"] isEqualToString:defaultimg])
    {
    // _img.image = [UIImage imageNamed:@"GEnoimage.jpg" inBundle:bundle compatibleWithTraitCollection:nil];
        [Validation getPostImageFromServer_v2:DEFAULTIMG_URL showOnpostimage:self.img];
    }
   
}
-(void)setimgeFromProduct:(NSMutableDictionary*)dict
{
   //  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
     NSString*defaultimg=@"http://pty.bashas.com/webapiaccessclient/images/noimage-large.png";
    if ([dict[@"ImageURL"] isEqualToString:defaultimg] || [dict[@"ImageURL"] isEqualToString:@""])
    {
      //_img.image = [UIImage imageNamed:@"GEnoimage.jpg" inBundle:bundle compatibleWithTraitCollection:nil];
          [Validation getPostImageFromServer_v2:DEFAULTIMG_URL showOnpostimage:self.img];
    }
    else
    { [Validation getPostImageFromServer_v2:dict[@"ImageURL"] showOnpostimage:self.img];
    }
  
}
-(IBAction)Hurbtn:(UIButton*)sender
{
  _titleid.hidden=NO;
}
-(IBAction)addbtn:(UIButton*)sender
{
    _addlab.backgroundColor=[UIColor lightGrayColor];
    [Validation zoomIn:_addlab];
    [NSTimer scheduledTimerWithTimeInterval:0.001
                                     target:self
                                   selector:@selector(addTimer:)
                                   userInfo:nil
                                    repeats:NO];
}
-(void)addTimer:(NSTimer*)timer{
    
    if ([[dict valueForKey:@"PrimaryOfferTypeId"]integerValue]==0)
    {
       [_soppingListViewcontroller addproductzero:index];
     }
    else
    {
        
        [_soppingListViewcontroller addproduct:index];
    }
    _addlab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    
}

-(IBAction)subbtn:(UIButton*)sender
{
    _sublab.backgroundColor=[UIColor lightGrayColor];
    [Validation zoomIn:_sublab];
    [NSTimer scheduledTimerWithTimeInterval:0.001
                                     target:self
                                   selector:@selector(SubTimer:)
                                   userInfo:nil
                                    repeats:NO];

}
-(void)SubTimer:(NSTimer*)timer
{
    if ([[dict valueForKey:@"PrimaryOfferTypeId"]integerValue]==0)
    {
        [_soppingListViewcontroller Subproductzero:index];
    }
    else
    {
        [_soppingListViewcontroller subproduct:index];
    }
    _sublab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
}
-(IBAction)Detailspage:(id)sender
{
//     if ([[dict valueForKey:@"PrimaryOfferTypeId"]integerValue]==1 || [[dict valueForKey:@"PrimaryOfferTypeId"]integerValue]==2 || [[dict valueForKey:@"PrimaryOfferTypeId"]integerValue]==3)
//     {
//        //[_soppingListViewcontroller detailspage:index];
//     }
    
}
-(void)stringByReplacingSnakeCaseWithCamelCase:(NSString *)string lab:(UILabel*)lab
{
    
    NSString*camstring;
    NSString*camstring1;
    camstring1=@"";
    NSArray *myArray = [string componentsSeparatedByString:@" "];
    for (int i=0; i<[myArray count]; i++)
    {
        if ([myArray[i] isEqualToString:@""])
        {
            NSMutableArray *arary = [[NSMutableArray alloc] initWithArray:[myArray[i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@""]]];
        }
        else
        {
            camstring = [NSString stringWithFormat:@"%@%@ ",[[myArray[i] substringToIndex:1] uppercaseString],[[myArray[i] substringFromIndex:1] lowercaseString]];
            camstring1=[NSString stringWithFormat:@"%@%@",camstring1,camstring];
        }
    }
    lab.text=camstring1;
}
@end
