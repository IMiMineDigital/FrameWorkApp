//
//  DoubleViewCollectionCell.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 5/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "DoubleViewCollectionCell.h"
#import "MyPersonalPriceViewController.h"
#import "ApiHendlerClass.h"
@implementation DoubleViewCollectionCell
{
    NSMutableArray*array;
    NSMutableDictionary*dealsdict;
    NSMutableArray*arra;
   
        NSInteger count;
        NSString*Expdate;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)cellOnData:(NSMutableDictionary*)str myPersonalPriceViewController:(MyPersonalPriceViewController*)myPersonalPriceViewController index1:(NSInteger)index1
{
    _myPersonalPriceViewController = myPersonalPriceViewController;
    index = index1;
    [self cellOnData:str];
}
-(void)cellOnData:(NSMutableDictionary*)str
{
    
    dealsdict=str;
    NSString*sttt=str[@"Quantity"];
    count=[sttt integerValue];
   if ([str[@"PrimaryOfferTypeId"] integerValue]==1)
    {    //My Sale Items
       [self Exparedate:str];
       
        _Activateview.hidden=YES;
        _removeview.hidden=YES;
         _withfraewaytitle.hidden=YES;
       _limitShowlab.hidden=NO;
         _perpoundlab.hidden=NO;
            _Getproductprice.hidden=YES;
        _stickersimg.hidden=YES;
    
        _ActivateBtn.backgroundColor=[UIColor colorWithRed:9/255.0 green:82/255.0 blue:149/255.0 alpha:1.0];//gra
             _perpoundlab.text=[NSString stringWithFormat:@"%@",[str[@"PackagingSize"] lowercaseString]];
       _product_price.textAlignment = NSTextAlignmentCenter;
        NSString* camelCaseString = [str valueForKey:@"Description"];
        [self stringByReplacingSnakeCaseWithCamelCase:camelCaseString lab:_product_name];
        [self savingsShowcouponse:str];
        _ActivateBtn.text=str[@"OfferTypeTagName"];
        [self setimgeFromProduct:str];
    _limitShowlab.text=[NSString stringWithFormat:@"Exp %@",Expdate];
        [self relateditemsvies:str];
        NSString*strr=[Validation convertHtmlPlainText:str[@"DisplayPrice"]];
       [self displaypriceFun:strr];

    }
    else if ([str[@"PrimaryOfferTypeId"] integerValue]==2)
    { //My Personal Coupon
    
            _removeview.hidden=YES;
           [self Exparedate:str];
           _Activateview.hidden=NO;
        _stickersimg.hidden=NO;
        _Getproductprice.hidden=NO;
        _perpoundlab.hidden=NO;
        _withfraewaytitle.hidden=NO;
        _withfraewaytitle.text=@"With Coupon";
        _stickersimg.hidden=NO;
        _product_price.textAlignment = NSTextAlignmentCenter;
        _ActivateBtn.backgroundColor=[UIColor colorWithRed:156/255.0 green:186/255.0 blue:95/255.0 alpha:1.0];//red
        _ActivateBtn.text=str[@"OfferTypeTagName"];
              _perpoundlab.text=[NSString stringWithFormat:@"%@",[str[@"PackagingSize"] lowercaseString]];
        [self relateditemsvies:str];
        [self limitshowingFun:str];
       _withfraewaytitle.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
        if ([str[@"OfferDefinitionId"] integerValue]==8 || [str[@"OfferDefinitionId"] integerValue]==5)
        {
            [Validation getPostImageFromServer_v2:str[@"CouponImageURl"] showOnpostimage:self.img];
        }
        else
        {
            [self setimgeFromProduct:str];
        }
        if ([[str valueForKey:@"OfferDefinitionId"] integerValue]==5)
        {
            NSString* camelCaseString = [str valueForKey:@"oCouponShortDescription"];
            [self stringByReplacingSnakeCaseWithCamelCase:[NSString stringWithFormat:@"* %@",camelCaseString] lab:_product_name];
            
        }
        else
        {
            NSString* camelCaseString = [str valueForKey:@"Description"];
            [self stringByReplacingSnakeCaseWithCamelCase:[NSString stringWithFormat:@"%@",camelCaseString] lab:_product_name];
        }
        
        
           [self coupnsedisplayprice:str];
           [self showStickerCoupon:str];
           [self savingsShowcouponse:str];
    }
    else if ([str[@"PrimaryOfferTypeId"] integerValue]==3)
    {
        _removeview.hidden=YES;
         _Activateview.hidden=NO;
        [self Exparedate:str];
        //My Personal Deal
        _stickersimg.hidden=YES;
       _Getproductprice.hidden=YES;
        _withfraewaytitle.hidden=NO;
        _withfraewaytitle.text=@"With MyFareway";
        _perpoundlab.hidden=NO;
        _withfraewaytitle.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
        _ActivateBtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];//red
        _perpoundlab.text=[NSString stringWithFormat:@"%@",[str[@"PackagingSize"] lowercaseString]];
        NSString* camelCaseString = [str valueForKey:@"Description"];
        [self stringByReplacingSnakeCaseWithCamelCase:camelCaseString lab:_product_name];
        _ActivateBtn.text=str[@"OfferTypeTagName"];
         _product_price.textAlignment = NSTextAlignmentCenter;
        _limitShowlab.text=[NSString stringWithFormat:@"Exp %@",Expdate];
        [self setimgeFromProduct:str];
        [self relateditemsvies:str];
        [self savingsShowcouponse:str];
         NSString*strr=[Validation convertHtmlPlainText:str[@"DisplayPrice"]];
        [self displaypriceFun:strr];
  }
    _limitShowlab.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    [_product_price setTextAlignment:NSTextAlignmentRight];
    [Validation addShadowToView:self.shoadShow];
    [Validation setRoundView:self.activbtn borderWidth:0 borderColor:nil radius:_activbtn.layer.frame.size.height/2];
    [Validation setRoundView:self.additemsplus borderWidth:0 borderColor:nil radius:_additemsplus.layer.frame.size.height/2];
    _additemsplus.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    [Validation setRoundView:self.removeview borderWidth:0 borderColor:nil radius:8];
    [Validation addShadowToViewwhite:self.Activateview];
}
-(void)Exparedate:(NSMutableDictionary*)str
{
        NSString*dateString=[NSString stringWithFormat:@"%@",str[@"ValidityEndDate"]];
         NSDateFormatter *format = [[NSDateFormatter alloc] init];
         [format setDateFormat:@"MM/dd/yy"];
         NSDate *date = [format dateFromString:dateString];
         [format setDateFormat:@"MM/dd"];
         Expdate = [format stringFromDate:date];
    
}
-(void)savingsShowcouponse:(NSMutableDictionary*)str
{
   
//    _linesaveprice.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
//    _linesaveprice2.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    
    _linesaveprice.backgroundColor=[UIColor blackColor];
    _linesaveprice2.backgroundColor=[UIColor blackColor];
    float myNumber = [str[@"AdPrice"] floatValue];
    if (myNumber>0.0000 && [str[@"PrimaryOfferTypeId"] integerValue]==2)
    {
        _adddigitallab.hidden=NO;
        _linesaveprice.hidden=NO;
        _linesaveprice2.hidden=NO;
        _savePrice.hidden=NO;
        _savePrice.text=[NSString stringWithFormat:@"Everyday Price $%@",str[@"RegularPrice"]];
        _adddigitallab.text=[NSString stringWithFormat:@"Promo Price $%.02f",myNumber];
//                            if ([str[@"PrimaryOfferTypeId"] integerValue]==2)
//                            {
//
                                                 if ([[str valueForKey:@"OfferDefinitionId"] integerValue]==4)
                                                  {
                                                            if ([[str valueForKey:@"RewardType"] integerValue]==1 && [[str valueForKey:@"FinalPrice"] floatValue]>0.0000)
                                                                  {
                                                                      _linesaveprice.hidden=YES;
                                                                      _savePrice.hidden=YES;
                                                                      _adddigitallab.hidden=YES;
                                                                      _linesaveprice2.hidden=YES;
                                                                  }
                                                   }
                             // }
    
            
      
        
    }
    else
    {
                        if ([str[@"PrimaryOfferTypeId"] integerValue]==1 || [str[@"PrimaryOfferTypeId"] integerValue]==3)
                        {
                            _linesaveprice.hidden=NO;
                            _savePrice.hidden=NO;
                            _adddigitallab.hidden=YES;
                            _linesaveprice2.hidden=YES;
                            _savePrice.text=[NSString stringWithFormat:@"Everyday Price $%@",str[@"RegularPrice"]];
                        }
                        else
                        {
                            _linesaveprice.hidden=YES;
                            _savePrice.hidden=YES;
                            _adddigitallab.hidden=YES;
                            _linesaveprice2.hidden=YES;
                           
                        }
        
       
    }

    
}
-(void)showStickerCoupon:(NSMutableDictionary*)dict
{
    
    //      NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    if ([dict[@"Isbadged"] boolValue]==true)
    {
        [Validation getPostImageFromServer_v2:dict[@"BadgeFileName"] showOnpostimage:self.stickersimg];
        [self savingsShowcouponse:dict];
    }
    else
    {
        _stickersimg.hidden=YES;
    }
    
    
    
}
-(void)coupnsedisplayprice:(NSMutableDictionary*)str
{
    float myNumber = [str[@"FinalPrice"] floatValue];
    NSString*FinalPrice=[NSString stringWithFormat:@"%.02f",myNumber];
 
    
    _product_price.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    if ([[str valueForKey:@"OfferDefinitionId"] integerValue]==5 && [[str valueForKey:@"RewardType"] integerValue]==2 && [[str valueForKey:@"FinalPrice"] floatValue]>0.0000)
    {
     
        NSString*staticstr=@"% OFF*";
        NSString*Rewardvalue=@"";
        Rewardvalue=[str valueForKey:@"RewardValue"];
        NSArray *myArray = [Rewardvalue componentsSeparatedByString:@"."];
        if ([myArray count]>1)
        { if ([myArray[1] isEqualToString:@"00"])
        {
            Rewardvalue=myArray[0];
        }
        }
        _product_price.text=[NSString stringWithFormat:@"%@ %@",Rewardvalue,staticstr];
        _Getproductprice.hidden=YES;
   }
    else if ([[str valueForKey:@"OfferDefinitionId"] integerValue]==4)
    {
         if ([[str valueForKey:@"RewardType"] integerValue]==2)
         {
                                      if ([[str valueForKey:@"FinalPrice"] floatValue]>0.0000)
                                        {
                                            NSString*staticstr=@"% OFF*";
                                            NSString*Rewardvalue=@"";
                                            Rewardvalue=[str valueForKey:@"RewardValue"];
                                            NSArray *myArray = [Rewardvalue componentsSeparatedByString:@"."];
                                            if ([myArray count]>1)
                                            { if ([myArray[1] isEqualToString:@"00"])
                                            {
                                                Rewardvalue=myArray[0];
                                            }
                                            }
                                            UIFont *BuyFont = [UIFont fontWithName:@"Helvetica-Bold" size:16];
                                            NSDictionary *arialDict = [NSDictionary dictionaryWithObject: BuyFont forKey:NSFontAttributeName];
                                            NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Buy %@\n",[str valueForKey:@"RequiredQty"]] attributes: arialDict];
                                            _product_price.attributedText = aAttrString;
                                            
                                            UIFont *otherfont = [UIFont fontWithName:@"Helvetica-Bold" size:13];
                                            NSDictionary *halDict = [NSDictionary dictionaryWithObject: otherfont forKey:NSFontAttributeName];
                                            NSMutableAttributedString *bAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Get %@ %@%@",[str valueForKey:@"RewardQty"],Rewardvalue,staticstr] attributes: halDict];
                                            _Getproductprice.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
                                            _Getproductprice.attributedText = bAttrString;
                                        }
        }
        else if([[str valueForKey:@"RewardType"] integerValue]==3 &&[[str valueForKey:@"FinalPrice"] floatValue]>0.0000)
        {
            NSString*DisplayPrice=[Validation convertHtmlPlainText:str[@"oDisplayPrice"]];
            [self displaypriceFun:[NSString stringWithFormat:@"%@",DisplayPrice]];
            _Getproductprice.hidden=YES;
        }
        else if ([[str valueForKey:@"RewardType"] integerValue]==1 && [FinalPrice floatValue]>0.0000)
        {
                           NSString*staticstr=@"OFF*";
                            NSString*Rewardvalue=@"";
                            Rewardvalue=[str valueForKey:@"RewardValue"];
                            NSArray *myArray = [Rewardvalue componentsSeparatedByString:@"."];
                            if ([myArray count]>1)
                            { if ([myArray[1] isEqualToString:@"00"])
                            {
                                Rewardvalue=myArray[0];
                            }
                            }
                            UIFont *BuyFont = [UIFont fontWithName:@"Helvetica-Bold" size:16];
                            NSDictionary *arialDict = [NSDictionary dictionaryWithObject: BuyFont forKey:NSFontAttributeName];
                            NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Buy %@\n",[str valueForKey:@"RequiredQty"]] attributes: arialDict];
                            _product_price.attributedText = aAttrString;
            
                            UIFont *otherfont = [UIFont fontWithName:@"Helvetica-Bold" size:13];
                            NSDictionary *halDict = [NSDictionary dictionaryWithObject: otherfont forKey:NSFontAttributeName];
                            NSMutableAttributedString *bAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Get %@ $%@ %@",[str valueForKey:@"RewardQty"],Rewardvalue,staticstr] attributes: halDict];
                            _Getproductprice.attributedText = bAttrString;
                            _Getproductprice.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
         }
        
    }
    else
    {
        
        
        NSString*DisplayPrice=[Validation convertHtmlPlainText:str[@"oDisplayPrice"]];
        [self displaypriceFun:[NSString stringWithFormat:@"%@",DisplayPrice]];
        _Getproductprice.hidden=YES;
    }
    
}
-(void)productpricefun:(NSMutableDictionary*)str
{
     _product_price.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
   if ([[str valueForKey:@"OfferDefinitionId"] integerValue]==5 && [[str valueForKey:@"RewardType"] integerValue]==2 && [[str valueForKey:@"FinalPrice"] floatValue]>0)
    {
        NSString*staticstr=@"% OFF*";
        NSString*Rewardvalue=@"";
        Rewardvalue=[str valueForKey:@"RewardValue"];
        NSArray *myArray = [Rewardvalue componentsSeparatedByString:@"."];
        if ([myArray count]>1)
        { if ([myArray[1] isEqualToString:@"00"])
        {
            Rewardvalue=myArray[0];
        }
        }
        _product_price.text=[NSString stringWithFormat:@"%@ %@",Rewardvalue,staticstr];
        _Getproductprice.hidden=YES;
        
    }
    else if ([[str valueForKey:@"OfferDefinitionId"] integerValue]==4)
    {
        if ([[str valueForKey:@"RewardType"] integerValue]==2)
        {
            
                          if ([[str valueForKey:@"AdPrice"] integerValue]==2)
                          {
                             
                              
                           }
            
            
            
            if ([[str valueForKey:@"FinalPrice"] floatValue]>0)
            {
                NSString*staticstr=@"% OFF*";
                NSString*Rewardvalue=@"";
                Rewardvalue=[str valueForKey:@"RewardValue"];
                NSArray *myArray = [Rewardvalue componentsSeparatedByString:@"."];
                if ([myArray count]>1)
                { if ([myArray[1] isEqualToString:@"00"])
                {
                    Rewardvalue=myArray[0];
                }
                }
                UIFont *BuyFont = [UIFont fontWithName:@"Helvetica-Bold" size:16];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject: BuyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Buy %@\n",[str valueForKey:@"RequiredQty"]] attributes: arialDict];
                _product_price.attributedText = aAttrString;
                
                UIFont *otherfont = [UIFont fontWithName:@"Helvetica-Bold" size:13];
                NSDictionary *halDict = [NSDictionary dictionaryWithObject: otherfont forKey:NSFontAttributeName];
                NSMutableAttributedString *bAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Get %@ %@%@",[str valueForKey:@"RewardQty"],Rewardvalue,staticstr] attributes: halDict];
             _Getproductprice.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
            _Getproductprice.attributedText = bAttrString;
                
                
            }
            else if([[str valueForKey:@"FinalPrice"] floatValue]==0)
            {
                NSString*staticstr=@"Free*";
                UIFont *BuyFont = [UIFont fontWithName:@"Helvetica-Bold" size:16];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject: BuyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Buy %@\n",[str valueForKey:@"RequiredQty"]] attributes: arialDict];
                _product_price.attributedText = aAttrString;
                
                UIFont *otherfont = [UIFont fontWithName:@"Helvetica-Bold" size:13];
                NSDictionary *halDict = [NSDictionary dictionaryWithObject: otherfont forKey:NSFontAttributeName];
                NSMutableAttributedString *bAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Get %@ %@",[str valueForKey:@"RewardQty"],staticstr] attributes: halDict];
                _Getproductprice.attributedText = bAttrString;
                _Getproductprice.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
            }
         }
       else if ([[str valueForKey:@"RewardType"] integerValue]==1 && [[str valueForKey:@"FinalPrice"] floatValue]>0)
        {
            NSString*staticstr=@"OFF*";
            NSString*Rewardvalue=@"";
            Rewardvalue=[str valueForKey:@"RewardValue"];
            NSArray *myArray = [Rewardvalue componentsSeparatedByString:@"."];
            if ([myArray count]>1)
            { if ([myArray[1] isEqualToString:@"00"])
            {
                Rewardvalue=myArray[0];
            }
            }
            
            UIFont *BuyFont = [UIFont fontWithName:@"Helvetica-Bold" size:16];
            NSDictionary *arialDict = [NSDictionary dictionaryWithObject: BuyFont forKey:NSFontAttributeName];
            NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Buy %@\n",[str valueForKey:@"RequiredQty"]] attributes: arialDict];
            _product_price.attributedText = aAttrString;
            
            
            
            UIFont *otherfont = [UIFont fontWithName:@"Helvetica-Bold" size:13];
            NSDictionary *halDict = [NSDictionary dictionaryWithObject: otherfont forKey:NSFontAttributeName];
            NSMutableAttributedString *bAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Get %@ $%@ %@",[str valueForKey:@"RewardQty"],Rewardvalue,staticstr] attributes: halDict];
            _Getproductprice.attributedText = bAttrString;
            _Getproductprice.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
        }
    }
    else
    {
        
        NSString*DisplayPrice=[Validation convertHtmlPlainText:str[@"oDisplayPrice"]];
        [self displaypriceFun:[NSString stringWithFormat:@"%@",DisplayPrice]];
        _Getproductprice.hidden=YES;
    }
    
}
-(void)limitshowingFun:(NSMutableDictionary*)dict
{
    
    if ([[dict valueForKey:@"MinAmount"] integerValue]>0)
    {
        UIFont *currentFont = _limitShowlab.font;
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: currentFont forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*With $%ld Purchase",(long)[[dict valueForKey:@"MinAmount"] integerValue]] attributes: arialDict];
        
        
        
           UIFont *limitFont = [UIFont fontWithName:@"arial" size:9.0];
         NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:limitFont forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n Limit %@,Exp %@",[dict valueForKey:@"LimitPerTransection"],Expdate]  attributes:verdanaDict];
        [aAttrString appendAttributedString:vAttrString];
       _limitShowlab.attributedText = aAttrString;

        
        
    }
    else if ([[dict valueForKey:@"RequiredQty"] integerValue]>1)
    {
        UIFont *currentFont = _limitShowlab.font;
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: currentFont forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*Must Buy %ld",(long)[[dict valueForKey:@"RequiredQty"] integerValue]] attributes: arialDict];
        
        
          UIFont *limitFont = [UIFont fontWithName:@"arial" size:9.0];
           NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:limitFont forKey:NSFontAttributeName];
           NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n Limit %@,Exp %@",[dict valueForKey:@"LimitPerTransection"],Expdate] attributes:verdanaDict];
        
        [aAttrString appendAttributedString:vAttrString];
        _limitShowlab.attributedText = aAttrString;
       
     }
    else
    {
        _limitShowlab.text=[NSString stringWithFormat:@"Limit %@,Exp %@",[dict valueForKey:@"LimitPerTransection"],Expdate];
  
     }
    
    
}
-(void)relateditemsvies:(NSMutableDictionary*)dict
{
    
    
      if ([dict[@"TotalQuantity"] integerValue]==0 && ([dict[@"PrimaryOfferTypeId"] integerValue]==3 || [dict[@"PrimaryOfferTypeId"] integerValue]==2))
     {
         _additemsplus.text=@"+";
     }
      else if( [dict[@"Quantity"] integerValue]==0 && [dict[@"PrimaryOfferTypeId"] integerValue]==1)
      {
          _additemsplus.text=@"+";
      }
     else if([dict[@"PrimaryOfferTypeId"] integerValue]==3 || [dict[@"PrimaryOfferTypeId"] integerValue]==2)
     {
         _additemsplus.text=[NSString stringWithFormat:@"%@",dict[@"TotalQuantity"]];
     }
     else if([dict[@"PrimaryOfferTypeId"] integerValue]==1)
     {
         _additemsplus.text=[NSString stringWithFormat:@"%@",dict[@"Quantity"]];
           NSLog(@"dict:%@",dict[@"Quantity"]);
     }
  
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    NSString *string=@"";
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",string]];
    
    //  [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [commentString length])];
    
    [_relateditemsbtn setAttributedTitle:commentString forState:UIControlStateNormal];
    [_relateditemsbtn setImage:[UIImage imageNamed:@"addRelated.jpg" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    
  
    
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
-(void)displaypriceFun:(NSString*)str
{
    
     _product_price.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    NSString*isfloatzero;
    if ([[str substringToIndex:1] isEqualToString:@"$"])
    {
//        NSString *qlwUnitsPlainText = [NSString stringWithFormat:@"%@",str];
//        _product_price.attributedText=[Validation plainStringToAttributedUnitsDouble:qlwUnitsPlainText:@"$"];
        NSString *qlwUnitsPlainText = [NSString stringWithFormat:@"%@",str];
      
        NSArray *myArray = [qlwUnitsPlainText componentsSeparatedByString:@"."];
        if (myArray.count==2)
        {
            if ([myArray[1] isEqualToString:@"00"])
            {
                isfloatzero=[NSString stringWithFormat:@"%@",myArray[0]];
                _product_price.attributedText=[Validation plainStringToAttributedUnitsDouble:isfloatzero:@"$"];
            }
            else
            {
                _product_price.attributedText=[Validation plainStringToAttributedUnitsDouble:qlwUnitsPlainText:@"$"];
                
            }
        }
        else
        {
            _product_price.attributedText=[Validation plainStringToAttributedUnitsDouble:qlwUnitsPlainText:@"$"];
        }
    }
    else if ([[str substringFromIndex: [str length] - 1] isEqualToString:@"¢"])
    {
        NSString *qlwUnitsPlainText = [NSString stringWithFormat:@"%@",str];
        _product_price.attributedText=[Validation plainStringToAttributedUnitsDouble:qlwUnitsPlainText:@"¢"];
    }
    else if ([[str substringFromIndex: [str length] - 1] isEqualToString:@"F"])
    {
        
        
        NSString *qlwUnitsPlainText = [NSString stringWithFormat:@"%@",str];
        _product_price.attributedText=[Validation plainStringToAttributedUnitsDouble:qlwUnitsPlainText:@"F"];
    }
   else
    {
        _product_price.text=[NSString stringWithFormat:@"%@",str];
        
    }

}

-(void)dispalyprice:(NSMutableDictionary*)str
{
    
    
    NSString*strr=[Validation convertHtmlPlainText:str[@"DisplayPrice"]];
    NSArray *myArray = [strr componentsSeparatedByString:@"."];
   
    for (int i=0; i<myArray.count; i++)
    {
        
        NSString*indexfirststr=(NSString*)myArray[0];
        NSString *firstLetter = [indexfirststr substringFromIndex:1];
  
        
        UIFont *currentFontmax =[UIFont fontWithName:@"Helvetica" size:13];
        NSDictionary *arialDicts = [NSDictionary dictionaryWithObject: currentFontmax forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:indexfirststr attributes: arialDicts];
        
        // [self displaypriceFun:indexfirststr];
        
        
        UIFont *currentFont =[UIFont fontWithName:@"Helvetica" size:11];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: currentFont forKey:NSFontAttributeName];
        NSMutableAttributedString *bAttrString = [[NSMutableAttributedString alloc] initWithString:myArray[1] attributes: arialDict];
        
        
        
        
        
        [aAttrString appendAttributedString:bAttrString];
        [self displaypriceFun:[NSString stringWithFormat:@"%@",indexfirststr]];
       
    }
    
}
-(void)setimgeFromProduct:(NSMutableDictionary*)dict
{
   // NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString*defaultimg=@"http://pty.bashas.com/webapiaccessclient/images/noimage-large.png";
    if ([dict[@"LargeImagePath"] isEqualToString:defaultimg] || [dict[@"LargeImagePath"] isEqualToString:@""])
    {
         //_img.image = [UIImage imageNamed:@"GEnoimage.jpg" inBundle:bundle compatibleWithTraitCollection:nil];
        [Validation getPostImageFromServer_v2:DEFAULTIMG_URL showOnpostimage:self.img];
    }
    else
    { [Validation getPostImageFromServer_v2:dict[@"LargeImagePath"] showOnpostimage:self.img];
    }
}
-(IBAction)addFav:(id)sender
{

 
        _product_titleactivelab.text=@"Activated";
        _removeview.hidden=YES;
        _activeimg.hidden=NO;
      [_myPersonalPriceViewController updatedata:index];
        _activbtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
      NSBundle *bundle = [NSBundle bundleForClass:[self class]];
     _activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
    
      [NSTimer scheduledTimerWithTimeInterval:0.001
                                     target:self
                                   selector:@selector(addivatedfunTimer:)
                                   userInfo:nil
                                    repeats:NO];
    
}
-(void)addivatedfunTimer:(NSTimer*)timer
{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString*today=[dateFormatter stringFromDate:[NSDate date]];
    
    NSString*dateString=(NSString*)[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@".expires"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    NSDate *date = [format dateFromString:dateString];
    [format setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString* expare = [format stringFromDate:date];
    
    if (![expare isEqualToString:today])
    {
        ApiHendlerClass*cls=[ApiHendlerClass new];
        [cls getAccessToken:ACCESSTOKEN_URL];
        
    }
  
    
}
-(IBAction)SeeDetails:(id)sender
{
    [_myPersonalPriceViewController openDetails:index];
}
-(IBAction)Relateditems:(id)sender
{   [_myPersonalPriceViewController RelatedItems:index];
}
-(IBAction)addproduct:(id)sender
{
    [_myPersonalPriceViewController addproduct:index];
}
-(IBAction)Subproduct:(id)sender
{
    [_myPersonalPriceViewController subproduct:index];
}
-(IBAction)removebtn:(id)sender
{

    _product_titleactivelab.text=@"Add";
    _removeview.hidden=YES;
     _activbtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];//red
     NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    _activeimg.image = [UIImage imageNamed:@"add.png" inBundle:bundle compatibleWithTraitCollection:nil];
 
    [NSTimer scheduledTimerWithTimeInterval:0.001
                                     target:self
                                   selector:@selector(removeActivatedTimer:)
                                   userInfo:nil
                                    repeats:NO];
}
-(void)removeActivatedTimer:(NSTimer*)timer
{
      [_myPersonalPriceViewController Removeprouct:index];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString*today=[dateFormatter stringFromDate:[NSDate date]];
    NSString*dateString=(NSString*)[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@".expires"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    NSDate *date = [format dateFromString:dateString];
    [format setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString* expare = [format stringFromDate:date];
    if (![expare isEqualToString:today])
    {
        ApiHendlerClass*cls=[ApiHendlerClass new];
        [cls getAccessToken:ACCESSTOKEN_URL];
        
    }
    
  
    
}
@end
