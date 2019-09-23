//
//  ParticipntingItemCell.m
//  Bashas
//
//  Created by kamlesh prajapati on 9/10/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import "ParticipntingItemCell.h"
#import "AFNetworking.h"
#import "Validation.h"
#import "UIImageView+AFNetworking.h"
#import "ObjectType.h"
#import "UIView+Toast.h"
#import <SVProgressHUD.h>
#import "ParticipantingItemViewController.h"
#import "ApiHendlerClass.h"
@implementation ParticipntingItemCell
{
    NSString*Expdate;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
   [_shoadShow addGestureRecognizer:tap];
}
-(void)handleImageTap:(UITapGestureRecognizer*)gestureRecognizer
{
          [self endEditing:YES];
//       _addtolistview.hidden=YES;
//        _additemsplus.hidden=NO;
//        _relateditemsbtn.hidden=NO;
    _relateditemsbtn.hidden=NO;
    _addtolistview.hidden=NO;
    _additemsplus.hidden=NO;
}
-(void)cellOnData:(NSMutableDictionary*)str participantingItemViewController:(ParticipantingItemViewController*)participantingItemViewController index1:(NSInteger)index1
{
    _participantingItemViewController=participantingItemViewController;
     index=index1;
    [self cellOnData:str];
    
}
-(void)cellOnData:(NSMutableDictionary*)str
{
    

    if ([str[@"PrimaryOfferTypeId"] integerValue]==1)
    {
        //My Sale Items
        
            _removeview.hidden=YES;
            [self Exparedate:str];
             _limitShowlab.hidden=NO;
   
         _perpoundlab.hidden=NO;
         _withfraewaytitle.hidden=YES;
         _perpoundlab.text=str[@"PackagingSize"];
         _product_price.textAlignment = NSTextAlignmentCenter;
         _limitShowlab.text=[NSString stringWithFormat:@"Exp %@",Expdate];
         _product_name.text=[str valueForKey:@"Description"];
         _ActivateBtn.backgroundColor=[UIColor colorWithRed:9/255.0 green:82/255.0 blue:149/255.0 alpha:1.0];//gra
        _ActivateBtn.text=str[@"OfferTypeTagName"];
         [self setimgeFromProduct:str];
        NSString* camelCaseString = [str valueForKey:@"Description"];
        [self stringByReplacingSnakeCaseWithCamelCase:camelCaseString lab:_product_name];
        NSString*strr=[Validation convertHtmlPlainText:str[@"oDisplayPrice"]];
        [self displaypriceFun:strr];
         [self relateditemsvies:str];
    }
    else if([str[@"PrimaryOfferTypeId"] integerValue]==2)
    {
        //My Personal Coupon
        [self Exparedate:str];
            _Activateview.hidden=YES;
           _withfraewaytitle.hidden=NO;
          _removeview.hidden=YES;
        
    
          _limitShowlab.hidden=NO;
         _perpoundlab.hidden=YES;
          _product_price.textAlignment = NSTextAlignmentCenter;
          _product_name.text=[str valueForKey:@"Description"];
          _ActivateBtn.text=str[@"OfferTypeTagName"];
            _withfraewaytitle.text=@"With Coupon";
          _withfraewaytitle.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];

         [self setimgeFromProduct:str];
        _ActivateBtn.backgroundColor=[UIColor colorWithRed:156/255.0 green:186/255.0 blue:95/255.0 alpha:1.0];//red
   
       _removeview.hidden=YES;

        NSString*strr=[Validation convertHtmlPlainText:str[@"oDisplayPrice"]];
        _product_price.text=[NSString stringWithFormat:@"%@",strr];
        NSString* camelCaseString = [str valueForKey:@"Description"];
        [self stringByReplacingSnakeCaseWithCamelCase:camelCaseString lab:_product_name];

         [self limitshowingFun:str];
         [self savingShowid_TWO:str];
         [self ShowingOnDisplePriceId_two:str];
         [self productpricefun:str];
          [self relateditemsvies:str];
    }
    else if([str[@"PrimaryOfferTypeId"] integerValue]==3)
    {
        //My Personal Deal
       
        [self Exparedate:str];
     
        _perpoundlab.hidden=NO;
   
        _limitShowlab.text=[NSString stringWithFormat:@"Exp %@",Expdate];
        _adddigitallab.hidden=YES;
        _withfraewaytitle.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
        _withfraewaytitle.hidden=NO;
        _withfraewaytitle.text=@"With MyFareway";
        _perpoundlab.text=str[@"PackagingSize"];
        _product_name.text=[str valueForKey:@"Description"];
        _product_price.textAlignment = NSTextAlignmentCenter;
        _ActivateBtn.text=str[@"OfferTypeTagName"];
        [self setimgeFromProduct:str];
        _ActivateBtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];//red
        NSString* camelCaseString = [str valueForKey:@"Description"];
        [self stringByReplacingSnakeCaseWithCamelCase:camelCaseString lab:_product_name];
        NSString*strr=[Validation convertHtmlPlainText:str[@"oDisplayPrice"]];
        [self displaypriceFun:strr];
          [self relateditemsvies:str];
    }
 
     [self savingShowid_TWO:str];
    _addlab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    _sublab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
      _countproductlab.text=[NSString stringWithFormat:@"%@",str[@"Quantity"]];
      //_additemsplus.text=[NSString stringWithFormat:@"%@",str[@"Quantity"]];
  
     _countproductlab.textColor=[UIColor blackColor];
    _limitShowlab.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
     [Validation addShadowToView:self.shoadShow];
     [_product_price setTextAlignment:NSTextAlignmentRight];
     [Validation setRoundView:self.activbtn borderWidth:0 borderColor:nil radius:_activbtn.layer.frame.size.height/2];
     [Validation setRoundView:self.addlab borderWidth:0 borderColor:nil radius:_addlab.layer.frame.size.height/2];
     [Validation setRoundView:self.sublab borderWidth:0 borderColor:nil radius:_sublab.layer.frame.size.height/2];
     [Validation setRoundView:self.removeview borderWidth:0 borderColor:nil radius:10];
     [Validation addShadowToViewwhite:self.Activateview];
     [Validation setRoundView:self.additemsplus borderWidth:0 borderColor:nil radius:_additemsplus.layer.frame.size.height/2];
    _additemsplus.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
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
-(void)ShowingOnDisplePriceId_two:(NSMutableDictionary*)str
{
    float myFloat=[[str valueForKey:@"RewardValue"] floatValue];
    NSString* RewardValue = [NSString stringWithFormat:@"%.f", myFloat];
    
    if ([[str valueForKey:@"OfferDefinitionId"] integerValue]==5 && [[str valueForKey:@"RewardType"] integerValue]==2 && [[str valueForKey:@"oFinalPrice"] integerValue]>0)
    {
        NSString*staticstr=@"% off";
        _product_price.text=[NSString stringWithFormat:@"%@ %@",[str valueForKey:@"RewardValue"],staticstr];
    }
    else if ([[str valueForKey:@"OfferDefinitionId"] integerValue]==4)
    {
        if ([[str valueForKey:@"RewardType"] integerValue]==2 && [[str valueForKey:@"oFinalPrice"] integerValue]>0)
        {
            
            NSString*staticstr=@"% off*";
            _product_price.text=[NSString stringWithFormat:@"Buy %@ Get %@ %@ %@",[str valueForKey:@"RequiredQty"],[str valueForKey:@"RewardQty"],RewardValue,staticstr];
        }
        else if ([[str valueForKey:@"RewardType"] integerValue]==1 && [[str valueForKey:@"oFinalPrice"] integerValue]>0)
        {
            NSString*staticstr=@"off*";
            _product_price.text=[NSString stringWithFormat:@"Buy %@ Get %@ $%@ %@",[str valueForKey:@"RequiredQty"],[str valueForKey:@"RewardQty"],RewardValue,staticstr];
        }
    }
    else
    {
         NSString*strr=[Validation convertHtmlPlainText:str[@"oDisplayPrice"]];
        _product_price.text=[NSString stringWithFormat:@"%@*",strr];
    }
}
-(void)relateditemsvies:(NSMutableDictionary*)dict
{
   
        _additemsplus.text=@"+";
  
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];

        NSString *string=@"";
        NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",string]];
//        [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [commentString length])];
    
        [_relateditemsbtn setAttributedTitle:commentString forState:UIControlStateNormal];
        [_relateditemsbtn setImage:[UIImage imageNamed:@"addRelated.jpg" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
 
    
    
    
}
-(IBAction)Relateditems:(id)sender
{
//     _addtolistview.hidden=NO;
//     _relateditemsbtn.hidden=YES;
//     _additemsplus.hidden=YES;
    
    _addtolistview.hidden=NO;
    _relateditemsbtn.hidden=NO;
    _additemsplus.hidden=NO;
}
-(void)savingShowid_TWO:(NSMutableDictionary*)str
{
    _linesaveprice.backgroundColor=[UIColor blackColor];
    _linesaveprice2.backgroundColor=[UIColor blackColor];
//    _linesaveprice.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
//    _linesaveprice2.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    float myNumber = [str[@"AdPrice"] floatValue];
    if (myNumber>0.00)
    {
        _adddigitallab.hidden=NO;
        _linesaveprice.hidden=NO;
        _linesaveprice2.hidden=NO;
        _savePrice.hidden=NO;
        _savePrice.text=[NSString stringWithFormat:@"Everyday Price $%@",str[@"RegularPrice"]];
        _adddigitallab.text=[NSString stringWithFormat:@"Promo Price $%.02f",myNumber];
        
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
-(void)displaypriceFun:(NSString*)str
{
    _product_price.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    NSString*isfloatzero;
    if ([[str substringToIndex:1] isEqualToString:@"$"])
    {
  
        
        NSString *qlwUnitsPlainText = [NSString stringWithFormat:@"%@",str];
        NSArray *myArray = [qlwUnitsPlainText componentsSeparatedByString:@"."];
        if (myArray.count==2)
        {
            if ([myArray[1] isEqualToString:@"00"])
            {
                isfloatzero=[NSString stringWithFormat:@"%@",myArray[0]];
                _product_price.attributedText=[Validation plainStringToAttributedUnits:isfloatzero:@"$"];
            }
            else
            {
                _product_price.attributedText=[Validation plainStringToAttributedUnits:qlwUnitsPlainText:@"$"];
                
            }
        }
        else
        {
            _product_price.attributedText=[Validation plainStringToAttributedUnits:qlwUnitsPlainText:@"$"];
        }
        
 
    }
    else if ([[str substringFromIndex: [str length] - 1] isEqualToString:@"¢"])
    {
        NSString *qlwUnitsPlainText = [NSString stringWithFormat:@"%@",str];
        _product_price.attributedText=[Validation plainStringToAttributedUnits:qlwUnitsPlainText:@"¢"];
    }
    else if ([[str substringFromIndex: [str length] - 1] isEqualToString:@"F"])
    {
        
        
        NSString *qlwUnitsPlainText = [NSString stringWithFormat:@"%@",str];
        _product_price.attributedText=[Validation plainStringToAttributedUnits:qlwUnitsPlainText:@"F"];
    }
    else
    {
        _product_price.text=[NSString stringWithFormat:@"%@",str];
    }

}
-(void)limitshowingFun:(NSMutableDictionary*)dict
{
    if ([[dict valueForKey:@"MinAmount"] integerValue]>0)
    {
        UIFont *currentFont = _limitShowlab.font;
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: currentFont forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*With $%ld Purchase",(long)[[dict valueForKey:@"MinAmount"] integerValue]] attributes: arialDict];
        
         UIFont *limitFont = [UIFont fontWithName:@"arial" size:12.0];
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:limitFont forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n Limit %@,Exp %@",[dict valueForKey:@"LimitPerTransection"],Expdate]  attributes:verdanaDict];
        [aAttrString appendAttributedString:vAttrString];
        
        
        
        _limitShowlab.attributedText = aAttrString;
        NSString* camelCaseString = [dict valueForKey:@"CouponShortDescription"];
        [self stringByReplacingSnakeCaseWithCamelCase:[NSString stringWithFormat:@"*%@",camelCaseString] lab:_product_name];
        
        
    }
    else if ([[dict valueForKey:@"RequiredQty"] integerValue]>1)
    {
        UIFont *currentFont = _limitShowlab.font;
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: currentFont forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*Must Buy %ld",(long)[[dict valueForKey:@"RequiredQty"] integerValue]] attributes: arialDict];
        
        
        UIFont *limitFont = [UIFont fontWithName:@"arial" size:12.0];
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:limitFont forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n Limit %@,Exp %@",[dict valueForKey:@"LimitPerTransection"],Expdate] attributes:verdanaDict];
        
        [aAttrString appendAttributedString:vAttrString];
        _limitShowlab.attributedText = aAttrString;
        NSString* camelCaseString = [dict valueForKey:@"Description"];
        [self stringByReplacingSnakeCaseWithCamelCase:[NSString stringWithFormat:@"%@",camelCaseString] lab:_product_name];
        
     }
    else
    {
        _limitShowlab.text=[NSString stringWithFormat:@"Limit %@,Exp %@",[dict valueForKey:@"LimitPerTransection"],Expdate];
        NSString* camelCaseString = [dict valueForKey:@"Description"];
        [self stringByReplacingSnakeCaseWithCamelCase:[NSString stringWithFormat:@"%@",camelCaseString] lab:_product_name];
        
        
    }
    
    
    
    
}
-(void)setimgeFromProduct:(NSMutableDictionary*)dict
{
   NSString*defaultimg=@"http://pty.bashas.com/webapiaccessclient/images/noimage-large.png";
     // NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    if ([dict[@"LargeImagePath"] isEqualToString:defaultimg] ||[dict[@"LargeImagePath"] isEqualToString:@""])
    {
        // _img.image = [UIImage imageNamed:@"GEnoimage.jpg" inBundle:bundle compatibleWithTraitCollection:nil];
       [Validation getPostImageFromServer_v2:DEFAULTIMG_URL showOnpostimage:self.img];
    }
    else
    { [Validation getPostImageFromServer_v2:dict[@"LargeImagePath"] showOnpostimage:self.img];
    }
    
}
-(void)productpricefun:(NSMutableDictionary*)str
{
    
    float myFloat=[[str valueForKey:@"RewardValue"] floatValue];
    NSString* RewardValue = [NSString stringWithFormat:@"%.f", myFloat];
    
    
    if ([[str valueForKey:@"OfferDefinitionId"] integerValue]==5 && [[str valueForKey:@"RewardType"] integerValue]==2 && [[str valueForKey:@"oFinalPrice"] floatValue]>0)
    {
        NSString*staticstr=@"% OFF*";
        NSString*Rewardvalue=@"";
        Rewardvalue=[str valueForKey:@"RewardValue"];
        NSArray *myArray = [Rewardvalue componentsSeparatedByString:@"."];
        if ([myArray count]>1)
        {
            if ([myArray[1] isEqualToString:@"00"])
            {
                Rewardvalue=myArray[0];
            }
            
        }
        _product_price.text=[NSString stringWithFormat:@"%@ %@",Rewardvalue,staticstr];
        
    }
    else if ([[str valueForKey:@"OfferDefinitionId"] integerValue]==4)
    {
        if ([[str valueForKey:@"RewardType"] integerValue]==2)
        {
            
            if ([[str valueForKey:@"oFinalPrice"] floatValue]>0)
            {
                NSString*staticstr=@"% OFF*";
                
                UIFont *BuyFont = [UIFont fontWithName:@"Helvetica-Bold" size:20];
                
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject: BuyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Buy %@\n",[str valueForKey:@"RequiredQty"]] attributes: arialDict];
                
                
                UIFont *otherfont = [UIFont fontWithName:@"Helvetica-Bold" size:20];
                NSDictionary *halDict = [NSDictionary dictionaryWithObject: otherfont forKey:NSFontAttributeName];
                NSMutableAttributedString *bAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Get %@ %@ %@",[str valueForKey:@"RewardQty"],RewardValue,staticstr] attributes: halDict];
                
                [aAttrString appendAttributedString:bAttrString];
                _product_price.attributedText = aAttrString;
                
          }
            else if([[str valueForKey:@"oFinalPrice"] floatValue]==0)
            {
                NSString*staticstr=@"Free*";
                UIFont *BuyFont = [UIFont fontWithName:@"Helvetica-Bold" size:20];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject: BuyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Buy %@\n",[str valueForKey:@"RequiredQty"]] attributes: arialDict];
                
                
                UIFont *otherfont = [UIFont fontWithName:@"Helvetica-Bold" size:20];
                NSDictionary *halDict = [NSDictionary dictionaryWithObject: otherfont forKey:NSFontAttributeName];
                NSMutableAttributedString *bAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Get %@ %@",[str valueForKey:@"RewardQty"],staticstr] attributes: halDict];
                
                [aAttrString appendAttributedString:bAttrString];
                _product_price.attributedText = aAttrString;
            }
            
        }
        
        else if ([[str valueForKey:@"RewardType"] integerValue]==1 && [[str valueForKey:@"oFinalPrice"] floatValue]>0)
        {
            NSString*staticstr=@"OFF*";
           UIFont *BuyFont = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            NSDictionary *arialDict = [NSDictionary dictionaryWithObject: BuyFont forKey:NSFontAttributeName];
            NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Buy %@\n",[str valueForKey:@"RequiredQty"]] attributes: arialDict];
            
            
            UIFont *otherfont = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            NSDictionary *halDict = [NSDictionary dictionaryWithObject: otherfont forKey:NSFontAttributeName];
            NSMutableAttributedString *bAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Get %@ $%@ %@",[str valueForKey:@"RewardQty"],RewardValue,staticstr] attributes: halDict];
            
            [aAttrString appendAttributedString:bAttrString];
            _product_price.attributedText = aAttrString;
        }
    }
    else
    {
        
        NSString*DisplayPrice=[Validation convertHtmlPlainText:str[@"oDisplayPrice"]];
        [self displaypriceFun:[NSString stringWithFormat:@"%@*",DisplayPrice]];
    }
    
}
-(IBAction)addproduct:(id)sender
{
    
       _addlab.backgroundColor=[UIColor lightGrayColor];
       [Validation zoomIn:_addlab];

    
    
//      _relateditemsbtn.hidden=YES;
//      _addtolistview.hidden=NO;
//      _additemsplus.hidden=YES;
    
          _relateditemsbtn.hidden=NO;
          _addtolistview.hidden=NO;
          _additemsplus.hidden=NO;
   
     [NSTimer scheduledTimerWithTimeInterval:0.001
                                     target:self
                                   selector:@selector(addTimer:)
                                   userInfo:nil
                                    repeats:NO];
    
}
-(void)addTimer:(NSTimer*)timer{
    
    [_participantingItemViewController addproduct:index];
    _addlab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    
}

-(IBAction)subproduct:(id)sender
{
      _sublab.backgroundColor=[UIColor lightGrayColor];
       [Validation zoomIn:_sublab];
    
//      _relateditemsbtn.hidden=YES;
//      _addtolistview.hidden=NO;
//     _additemsplus.hidden=YES;
    
    _relateditemsbtn.hidden=NO;
    _addtolistview.hidden=NO;
    _additemsplus.hidden=NO;
     [NSTimer scheduledTimerWithTimeInterval:0.001
                                     target:self
                                   selector:@selector(SubTimer:)
                                   userInfo:nil
                                    repeats:NO];
}
-(void)SubTimer:(NSTimer*)timer{
    
    [_participantingItemViewController subproduct:index];
    _sublab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
}
-(void)dispalyprice:(NSMutableDictionary*)str
{
    
    
    NSString*strr=[Validation convertHtmlPlainText:str[@"oDisplayPrice"]];
    NSArray *myArray = [strr componentsSeparatedByString:@"."];
  
    
    for (int i=0; i<myArray.count; i++)
    {
        
        NSString*indexfirststr=(NSString*)myArray[0];
        NSString *firstLetter = [indexfirststr substringFromIndex:1];
       
      UIFont *currentFontmax =[UIFont fontWithName:@"Helvetica" size:20];
        NSDictionary *arialDicts = [NSDictionary dictionaryWithObject: currentFontmax forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:indexfirststr attributes: arialDicts];
        
        // [self displaypriceFun:indexfirststr];
        
        
        UIFont *currentFont =[UIFont fontWithName:@"Helvetica" size:12];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: currentFont forKey:NSFontAttributeName];
        NSMutableAttributedString *bAttrString = [[NSMutableAttributedString alloc] initWithString:myArray[1] attributes: arialDict];
        
        [aAttrString appendAttributedString:bAttrString];
        [self displaypriceFun:[NSString stringWithFormat:@"%@",indexfirststr]];

        
        
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

-(IBAction)SeeDetails:(id)sender
{
      [_participantingItemViewController openDetails:index];
    
}
-(IBAction)addFun:(id)sender
{

      _removeview.hidden=YES;
      _product_titleactivelab.text=@"Activated";
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
    [_participantingItemViewController updatedata:index];
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

-(IBAction)removebtn:(id)sender
{
   //not used
    
    
    _removeview.hidden=YES;
    _addbtn.hidden=YES;
    _subbtn.hidden=YES;
    _countproductlab.hidden=YES;
    _product_titleactivelab.text=@"Add";
    _activbtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    _activeimg.image = [UIImage imageNamed:@"add.png" inBundle:bundle compatibleWithTraitCollection:nil];
    [_participantingItemViewController Removeprouct:index];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString*today=[dateFormatter stringFromDate:[NSDate date]];
    
    NSString*dateString=(NSString*)[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@".expires"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    NSDate *date = [format dateFromString:dateString];
    [format setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString* expare = [format stringFromDate:date];
    NSLog(@"Expaire:%@",expare);
    if (![expare isEqualToString:today])
    {
        ApiHendlerClass*cls=[ApiHendlerClass new];
        [cls getAccessToken:ACCESSTOKEN_URL];
    }

//    [NSTimer scheduledTimerWithTimeInterval:0.001
//                                     target:self
//                                   selector:@selector(removeActivatedTimer:)
//                                   userInfo:nil
//                                    repeats:NO];
    

}

@end
