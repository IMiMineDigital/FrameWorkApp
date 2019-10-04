//
//  Validation.m
//  Skill Grok
//
//  Created by experience on 5/21/14.
//  Copyright (c) 2014 Alcanzar Soft. All rights reserved.
//

#import "Validation.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+Toast.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CTStringAttributes.h>
#import <CoreText/CoreText.h>

#import "Reachability.h"
@implementation Validation

+(BOOL)isValidEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(BOOL)isMatchEmail:(NSString *)email confemail:(NSString*)confemail
{

    if ([email isEqualToString:confemail])
    {
        return YES;
    }
    else
    {
       return NO;
    }
    
    
    return YES;
    
    
    //return [emailTest evaluateWithObject:email];
}


+(BOOL)isValidImageId:(NSString*) imageName{
    if(imageName == NULL)
        return NO;
    if([imageName isEqualToString:@""])
        return NO;
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([imageName rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        if([imageName length] == 16)
        {
            return YES;
        }
    }
    return NO;
}
+(BOOL)isValidPreferredStore:(NSString *)store
{
    if (store.length==0)
    {
        return NO;
    }
    return YES;
}

+(BOOL)isValidText:(NSString *)text{
    
    NSString *trimmedString = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (trimmedString.length>0) {
        return YES;
    }
    return NO;
}
+(BOOL)isValidCardNumber:(NSString *)number
{
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:number
                                                        options:0
                                                          range:NSMakeRange(0, [number length])];
    if (numberOfMatches == 0 || number.length != 10)
        return NO;
    return YES;
}
+(BOOL)ismobilecheck:(NSString *)number
{
    if ([number length]==10)
    {
        return YES;
    }
    return NO;
}

+(void)setView:(UILabel*)lab
{
    [UIView animateWithDuration:1.0 delay:3.0 options:UIViewAnimationOptionCurveLinear  animations:^{
        lab.backgroundColor=[UIColor lightGrayColor];
           lab.backgroundColor=[UIColor lightGrayColor];
    } completion:^(BOOL finished) {
        //lab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
           lab.backgroundColor=[UIColor lightGrayColor];
    }];
  
    
}
+(void) animateTextView:(BOOL) up
{
    
//    const int movementDistance = 206;
//    const float movementDuration = 0.3f;
//    int movement= movement = (up ? -movementDistance : movementDistance);
//    [UIView beginAnimations: @"anim" context: nil];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    [UIView setAnimationDuration: movementDuration];
//    self.view.frame = CGRectOffset(self.inputView.frame, 0, movement);
//    [UIView commitAnimations];
    
    
    
}
+(BOOL)isValidConfirmCardNumber:(NSString *)pre current:(NSString*)current
{
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:pre
                                                        options:0
                                                          range:NSMakeRange(0, [pre length])];
    if (numberOfMatches == 0 || pre.length != 10)
         return NO;
    if ([pre isEqualToString:current])
    {
             return YES;
    }
     return YES;
}
+(BOOL)isPassMatch:(NSString *)pass conpass:(NSString *)conpass
{
    if ([pass isEqualToString:conpass])
    {
        return YES;
    }
    return NO;
}
+(BOOL)isMonth:(NSString *)month{
    NSLog(@"%d",[month intValue]);
    if ([month intValue]<=12&&[month intValue]>0) {
        return YES;
    }
    return NO;
}
+(BOOL)isDay:(NSString *)day{
    if ([day intValue]<=31 && [day intValue]>0) {
        return YES;
    }
    return NO;

}
+(BOOL)isYear:(NSString *)year{
    if (0<[year intValue] && year.length>=4)
    {
        return YES;
    }
    return NO;
}
+(BOOL)isPass:(NSString *)pass
{
    if (pass.length>5)
    {
        return YES;
    }
    return NO;
}
+(BOOL)isZipcode:(NSString *)pass
{
    if (pass.length!=5)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Zip code"
                                                        message:@"5 number"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
   }
    return YES;

}
+(void)showToastOnTop:(NSString *)msg ViewController:(UIViewController*)viewController Seconds:(float) sec
{
    
    [viewController.view makeToast:msg duration:sec position:CSToastPositionTop];

}

+(void)moveUp:(UIView *) controller upMargin:(float)upMargin{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:controller];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationBeginsFromCurrentState:YES];
    controller.frame=CGRectMake(controller.frame.origin.x, (controller.frame.origin.y-upMargin), controller.frame.size.width, controller.frame.size.height);
    [UIView commitAnimations];
    
}
+(void)moveBack:(UIView *) controller downMargin:(float)downMargin{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:controller];
    [UIView setAnimationDuration:0.32];
    [UIView setAnimationBeginsFromCurrentState:YES];
    controller.frame=CGRectMake(controller.frame.origin.x, (controller.frame.origin.y+downMargin), controller.frame.size.width, controller.frame.size.height);
    [UIView commitAnimations];
    
}

+(void)alerViewController:(UIViewController*)controller msz:(NSString*)msz
{
   UIAlertController*alertController = [UIAlertController alertControllerWithTitle:@"Fareway" message:msz preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* alert = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                   
                                }];
    [alertController addAction:alert];
    [controller presentViewController:alertController animated:YES completion:nil];

}
+(void)zoomIn:(UIView *)_slideshow{
    
    _slideshow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
     [UIView animateWithDuration:0.5
                     animations:^{
                         _slideshow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                     } completion:^(BOOL finished) {
                         
                         //[self zoomOut];
            }];
}
+(void)setRoundView:(UIView *)view borderWidth:(CGFloat) width  borderColor:(CGColorRef) color radius:(CGFloat)radius
{
    view.layer.cornerRadius = radius;
    view.layer.borderColor = color;
    view.layer.borderWidth = width;
    view.layer.masksToBounds = YES;
}
+(NSString*) getXibName:(NSString*)xibActualName
{
    if(isiPhone5s)
    {
       // NSLog(@"isiPhone5s");
       return [NSString stringWithFormat:@"%@",xibActualName];

    }
    else if(isiPhone6)
    {
          // NSLog(@"isiPhone6");
           return [NSString stringWithFormat:@"%@7",xibActualName];
    }
    else if(isiPhoneXsMax)
    {
             // NSLog(@"isiPhoneXsMax");
              return [NSString stringWithFormat:@"%@8",xibActualName];
        
    }
     else if(isiPhoneX)
     {
         // NSLog(@"isiPhoneX ");
        return [NSString stringWithFormat:@"%@7",xibActualName];
         
     }
    else if(isiPhone8Plus)
    {
           // NSLog(@"isiPhone8Plus");
             return [NSString stringWithFormat:@"%@8",xibActualName];
    }
    else if(isiPad ||isiPadSmall)
      {
          // NSLog(@"isiPad");
           return [NSString stringWithFormat:@"%@",xibActualName];
      }
    else
    {
          //NSLog(@"isiPhone5s");
         return [NSString stringWithFormat:@"%@",xibActualName];
    }
}

+(void) addShadowToView:(UIView*) view
{
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowOffset = CGSizeMake(0,0);
    view.layer.shadowOpacity = 0.2;
    view.layer.shadowRadius = 6;
    
}
+(void) addShadowToViewwhite:(UIView*) view
{
//    view.layer.masksToBounds = NO;
//    view.layer.shadowColor = [[UIColor whiteColor] CGColor];
//    view.layer.shadowOffset = CGSizeMake(0,0);
//    view.layer.shadowOpacity = 0.2;
//    view.layer.shadowRadius = 6;
    view.layer.masksToBounds = NO;
    view.layer.cornerRadius = 5.f;
    view.layer.shadowOffset = CGSizeMake(.0f,2.5f);
    view.layer.shadowRadius = 1.5f;
    view.layer.shadowOpacity = .9f;
  view.layer.shadowColor = [[UIColor whiteColor] CGColor];
}
+(void)animationView:(UIView*)view view_y:(CGFloat)view_y
{
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         view.frame = CGRectMake(view.layer.frame.origin.x, view_y, view.layer.frame.size.width, view.layer.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
}
+(void)getPostImageFromServer_v2:(NSString*)imagename showOnpostimage:(UIImageView*)showOnpostimage
{
    NSString *imageURL =imagename;
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    [showOnpostimage setImageWithURLRequest:imageRequest
                           placeholderImage:nil
                                    success:nil
                                    failure:nil];
}

+(NSString*)convertHtmlPlainText:(NSString*)HTMLString
{
    NSData *HTMLData = [HTMLString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:HTMLData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:NULL error:NULL];
    NSString *plainString = attrString.string;
   return plainString; 
    
}
+(NSMutableAttributedString *)plainStringToAttributedUnitsDeatilspage:(NSString *)string :(NSString *)type
{
    
   
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    UIFont *smallFontnumbers =[UIFont fontWithName:@"Helvetica-Bold" size:17];
    
    [attString beginEditing];
    if ([type  isEqual: @"$"])
    {
        
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:smallFontnumbers forKey:NSFontAttributeName];
        NSArray *myArray = [string componentsSeparatedByString:@"."];
        NSString * bttString=@"";
        NSString*str;
        
        if (myArray.count>1)
        {
            bttString= myArray[1];
            str=myArray[0];
            
            attString = [[NSMutableAttributedString alloc] initWithString:str];
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
            
            
            
            
            [attString beginEditing];
            
            NSMutableAttributedString*  buyString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",bttString]  attributes:verdanaDict];
            [buyString addAttribute:NSBaselineOffsetAttributeName
                              value:@(7.0)
                              range:NSMakeRange(0, buyString.length)];
            [attString appendAttributedString:buyString];
            
        }
        else if (myArray.count==1 && ![[string substringFromIndex: [string length] - 1] isEqualToString:@"F"])
        {
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
        }
        else if ([type  isEqual: @"$"] ||[[string substringFromIndex: [string length] - 1] isEqualToString:@"F"])
        {
            
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
            
            
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
        }
        else if ([type  isEqual: @"$"] || [[string substringFromIndex: [string length] - 1] isEqualToString:@"F"] || [[string substringFromIndex: [string length] - 5] isEqualToString:@"¢"])
        {
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
            
            
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
            
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 5, 5)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 5,5)];
            
        }
        else
        {
            bttString=@"";
            
            [attString beginEditing];
            
            NSMutableAttributedString*  buyString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",bttString]  attributes:verdanaDict];
            [buyString addAttribute:NSBaselineOffsetAttributeName
                              value:@(7.0)
                              range:NSMakeRange(0, buyString.length)];
            [attString appendAttributedString:buyString];
        }
        
        
        
        
        
    }
    else if ([type  isEqual: @"/"] || [[string substringFromIndex: string.length - 2] isEqualToString:type])
    {
        
        NSArray *myWords = [string componentsSeparatedByString:@"/"];
        NSString*firstlatter=myWords[1];
        NSString*second=[NSString stringWithFormat:@"%@%@",myWords[0],@"/"];
        NSMutableAttributedString *attStrings = [[NSMutableAttributedString alloc] initWithString:firstlatter];
        NSMutableAttributedString *attStringe = [[NSMutableAttributedString alloc] initWithString:second];
        [attStrings addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0,1)];
        [attStrings addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
        
        [attStringe appendAttributedString:attStrings];
        return attStringe;
        
    }
    else if([type  isEqual: @"¢"])
    {
        
        [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 1, 1)];
        [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 1, 1)];
        
    }
    else if([type  isEqual: @"F"])
    {
        //only cent or off top //only off top
        
        if ([[string substringFromIndex: [string length] - 1] isEqualToString:@"F"] || [[string substringFromIndex: [string length] - 5] isEqualToString:@"¢"])
        {
            
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
            
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 5, 5)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 5, 5)];
            
        }
        else
        {
            
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
            
        }
        
    }
    else
    {
        
        [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
        [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
        
    }
    [attString addAttribute:(NSString*)kCTForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, string.length - 1)];
    [attString endEditing];
    return attString;
}
+(NSMutableAttributedString *)plainStringToAttributedUnits:(NSString *)string :(NSString *)type
{
    
   
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
       UIFont *smallFontnumbers =[UIFont fontWithName:@"Helvetica-Bold" size:18];
 
        [attString beginEditing];
     if ([type  isEqual: @"$"])
     {
        
                NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:smallFontnumbers forKey:NSFontAttributeName];
                NSArray *myArray = [string componentsSeparatedByString:@"."];
                NSString * bttString=@"";
                NSString*str;
         
                if (myArray.count>1)
                {
                    bttString= myArray[1];
                    str=myArray[0];
                   
                     attString = [[NSMutableAttributedString alloc] initWithString:str];
                    [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
                    [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
                    
                    
                    
                    
                    [attString beginEditing];
                    
                    NSMutableAttributedString*  buyString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",bttString]  attributes:verdanaDict];
                    [buyString addAttribute:NSBaselineOffsetAttributeName
                                      value:@(8.0)
                                      range:NSMakeRange(0, buyString.length)];
                    [attString appendAttributedString:buyString];
                    
               }
                else if (myArray.count==1 && ![[string substringFromIndex: [string length] - 1] isEqualToString:@"F"])
                {
                    [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
                    [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
                }
                else if ([type  isEqual: @"$"] || [[string substringFromIndex: [string length] - 1] isEqualToString:@"F"])
                {
                  
                    [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
                    [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
                    
                    
                    [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
                    [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
                }
                 else if ([type  isEqual: @"$"] || [[string substringFromIndex: [string length] - 1] isEqualToString:@"F"] || [[string substringFromIndex: [string length] - 5] isEqualToString:@"¢"])
                 {
                     [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
                     [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
                     
                     
                     [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
                     [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
                     
                     [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 5, 5)];
                     [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 5,5)];
                     
                 }
                else
                {
                    bttString=@"";
                    
                    [attString beginEditing];
                    
                    NSMutableAttributedString*  buyString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",bttString]  attributes:verdanaDict];
                    [buyString addAttribute:NSBaselineOffsetAttributeName
                                      value:@(8.0)
                                      range:NSMakeRange(0, buyString.length)];
                    [attString appendAttributedString:buyString];
                }
         

         
        
        
    }
     else if ([type  isEqual: @"/"] || [[string substringFromIndex: string.length - 2] isEqualToString:type])
     {
         
         
         
         NSArray *myWords = [string componentsSeparatedByString:@"/"];
         NSString*firstlatter=myWords[1];
         NSString*second=[NSString stringWithFormat:@"%@%@",myWords[0],@"/"];
         NSMutableAttributedString *attStrings = [[NSMutableAttributedString alloc] initWithString:firstlatter];
         NSMutableAttributedString *attStringe = [[NSMutableAttributedString alloc] initWithString:second];
         [attStrings addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0,1)];
         [attStrings addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
         
         [attStringe appendAttributedString:attStrings];
         return attStringe;
         
     }
else if([type  isEqual: @"¢"])
{

           [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 1, 1)];
           [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 1, 1)];
    
}
else if([type  isEqual: @"F"])
    {
                //only cent or off top //only off top
        
                           if ([[string substringFromIndex: [string length] - 1] isEqualToString:@"F"] || [[string substringFromIndex: [string length] - 5] isEqualToString:@"¢"])
                               {
                                
                                   [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
                                   [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
                                   
                                   [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 5, 5)];
                                   [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 5, 5)];
                                   
                               }
                            else
                             {
                                
                                [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
                                [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
                                
                             }
        
   }
    else
    {
     
        [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
        [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
        
   }
    [attString addAttribute:(NSString*)kCTForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, string.length - 1)];
    [attString endEditing];
    return attString;
}

+(NSMutableAttributedString *)plainStringToAttributedUnitsDouble:(NSString *)string :(NSString *)type
{
    
   
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    UIFont *smallFontnumbers =[UIFont fontWithName:@"Helvetica-Bold" size:14];
    
    [attString beginEditing];
    if ([type  isEqual: @"$"])
    {
        
                            NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:smallFontnumbers forKey:NSFontAttributeName];
                            NSArray *myArray = [string componentsSeparatedByString:@"."];
                            NSString * bttString=@"";
                            NSString*str;
        
                            if (myArray.count>1)
                            {
                                bttString= myArray[1];
                                str=myArray[0];
                                
                                attString = [[NSMutableAttributedString alloc] initWithString:str];
                                [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
                                [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
                                
                                [attString beginEditing];
                                
                                NSMutableAttributedString*  buyString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",bttString]  attributes:verdanaDict];
                                [buyString addAttribute:NSBaselineOffsetAttributeName
                                                  value:@(6.0)
                                                  range:NSMakeRange(0, buyString.length)];
                                [attString appendAttributedString:buyString];
                                
                            }
                            else if (myArray.count==1 && ![[string substringFromIndex: [string length] - 1] isEqualToString:@"F"])
                            {
                                [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
                                [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
                            }
                            else if ([type  isEqual: @"$"] || [[string substringFromIndex: [string length] - 1] isEqualToString:@"F"])
                            {
                                
                                [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
                                [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
                                
                                
                                [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
                                [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
                            }
        
                            else if ([type  isEqual: @"$"] || [[string substringFromIndex: [string length] - 1] isEqualToString:@"F"] || [[string substringFromIndex: [string length] - 5] isEqualToString:@"¢"])
                            {
                                [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
                                [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
                                
                                
                                [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
                                [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
                                
                                [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 5, 5)];
                                [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 5,5)];
                                
                            }
                            else
                            {
                                bttString=@"";
                                
                                [attString beginEditing];
                                
                                NSMutableAttributedString*  buyString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",bttString]  attributes:verdanaDict];
                                [buyString addAttribute:NSBaselineOffsetAttributeName
                                                  value:@(6.0)
                                                  range:NSMakeRange(0, buyString.length)];
                                [attString appendAttributedString:buyString];
                            }
        
        
        
        
        
    }
    else if ([type  isEqual: @"/"] || [[string substringFromIndex: string.length - 2] isEqualToString:type])
    {
        
       
  
         NSArray *myWords = [string componentsSeparatedByString:@"/"];
         NSString*firstlatter=myWords[1];
           NSString*second=[NSString stringWithFormat:@"%@%@",myWords[0],@"/"];
         NSMutableAttributedString *attStrings = [[NSMutableAttributedString alloc] initWithString:firstlatter];
          NSMutableAttributedString *attStringe = [[NSMutableAttributedString alloc] initWithString:second];
         [attStrings addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0,1)];
         [attStrings addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
        
         [attStringe appendAttributedString:attStrings];
        return attStringe;
        
    }
    else if([type  isEqual: @"¢"])
    {
        
        [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 1, 1)];
        [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 1, 1)];
        
    }
    else if([type  isEqual: @"F"])
    {
        //only cent or off top //only off top
        
        if ([[string substringFromIndex: [string length] - 1] isEqualToString:@"F"] || [[string substringFromIndex: [string length] - 5] isEqualToString:@"¢"])
        {
            
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
            
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 5, 5)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 5, 5)];
            
        }
        else
        {
            
            [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(string.length - 3, 3)];
            [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 3, 3)];
            
        }
        
    }
    else
    {
        
        [attString addAttribute:NSFontAttributeName value:(smallFontnumbers) range:NSMakeRange(0, 1)];
        [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(0, 1)];
        
    }
    [attString addAttribute:(NSString*)kCTForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, string.length - 1)];
    [attString endEditing];
    return attString;
}
+(void)Togglebtn:(UIView*)view 
{
  
//    NSInteger index=0;
//    if (index==0)
//    {    CATransition *transition = [[CATransition alloc] init];
//        transition.duration = 0.5;
//        transition.type = kCATransitionPush;
//        transition.subtype = kCATransitionFromRight;
//        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [view.layer addAnimation:transition forKey:kCATransition];
//        index=1;
//        NSLog(@"index 0:%ld",index);
//    }
//    else
//    {  CATransition *transition = [[CATransition alloc] init];
//        transition.duration = 0.5;
//        transition.type = kCATransitionPush;
//        transition.subtype = kCATransitionFromLeft;
//        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [view.layer addAnimation:transition forKey:kCATransition];
//        index=0;
//             NSLog(@"index 1:%ld",index);
//    }
//    
    
    
}

@end
