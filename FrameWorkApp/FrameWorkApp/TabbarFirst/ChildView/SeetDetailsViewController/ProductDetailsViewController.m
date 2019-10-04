//
//  ProductDetailsViewController.m
//  Bashas
//
//  Created by kamlesh prajapati on 9/10/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "ParticipantingItemViewController.h"
#import "ApiHendlerClass.h"
#import "Validation.h"
#import "Reachability.h"
@interface ProductDetailsViewController ()<ParticipantingItemViewControllerDelegate,ProductDetailsViewControllerDelegate>
{
    NSString*ClickType;
     UIButton*Relateditemsbtn;
    NSBundle *bundle;
//    NSInteger count;
    
    
     NSInteger flg;
    
 NSMutableArray *checkCirArry;
}
@end

@implementation ProductDetailsViewController

-(void)Shoppinglistdetailsdate
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
    [self ShoppinglistApi];
}

-(void)ShoppinglistApi
{
    
    

    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Check your internet connection"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
    
        
          flg=1;
        for (int i=0; i<[_circheckedcouponseArry count]; i++)
        {
            
            if (_circheckedcouponseArry[i][@"CouponID"]==_shoppingListdata[@"Couponid"])
            {
                    _data=(NSMutableDictionary*)_circheckedcouponseArry[i];
                     flg=2;
            }


        }


        if (flg==1)
        {

                    [SVProgressHUD show];
                    NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                              };
            
                    NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
                    NSArray*stor=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"StoreId"];
                    NSURLComponents *components = [NSURLComponents componentsWithString:SHOPPINGLISTDETAILS_URL];
                    NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"MemberId" value:arra[0]];
                    NSURLQueryItem *storid = [NSURLQueryItem queryItemWithName:@"StoreId" value:stor[0]];
                    NSURLQueryItem *pltform = [NSURLQueryItem queryItemWithName:@"Plateform" value:@"2"];
                    NSURLQueryItem *OfferCode = [NSURLQueryItem queryItemWithName:@"UPC" value:[NSString stringWithFormat:@"%@",_shoppingListdata[@"UPC"]]];
                      NSURLQueryItem *PrimaryId =[NSURLQueryItem queryItemWithName:@"PrimaryOfferTypeId" value:[NSString stringWithFormat:@"%@",_shoppingListdata[@"PrimaryOfferTypeid"]]];
                     NSURLQueryItem *CouponID =  [NSURLQueryItem queryItemWithName:@"CouponID" value:[NSString stringWithFormat:@"%@",_shoppingListdata[@"Couponid"]]];
            
                    NSURLQueryItem *CircularType =  [NSURLQueryItem queryItemWithName:@"CircularType" value:@"0"];
                    components.queryItems = @[LoyaltyCardNumber,storid,OfferCode,pltform,PrimaryId,CouponID,CircularType];
                    NSURL *url = components.URL;
                    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
                    [request setHTTPMethod:@"GET"];
                    [request setAllHTTPHeaderFields:headers];
                    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
                    NSURLResponse*response=nil;
                    NSError*err=nil;
                    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
                    if (responseData!=nil)
                    {
                        NSMutableArray *jsonObject= [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
                         //NSLog(@"ShoppinglistApiDetails:%@",jsonObject);
                        [SVProgressHUD dismissWithDelay:1.0];
                        if (jsonObject.count!=0)
                        {
                            _data=(NSMutableDictionary*)jsonObject[0];
                        }
                        else
                        {
                            [SVProgressHUD show];
                        }
                    }
        }
        
        
      
    }
 
}
-(void)activatedbtn:(NSString*)clicktype
{
    
        _litleActlab.text=@"Activated";
        _btnimg.hidden=NO;
        _btnimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
        _activebtncolor.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
    
    
    
    NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                               @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                               };
    NSArray*memberid=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
    NSLog(@"MemberID:%@",memberid[0]);
    NSString *post=[NSString stringWithFormat:@"UPCCode=%@&CategoryID=%@&SalePrice=%@&PrimaryOfferTypeId=%@&OfferDetailId=%@&PersonalCircularID=%@&ExpirationDate=%@&ClientID=%@&PackagingSize=%@&DisplayPrice=%@&RelevantUPC=%@&Description=%@&SpecialInformation=%@&CouponID=%@&MemberID=%@&DeviceId=%@&OPMOfferID=%@&iPositionID=%@&PageID=%@&ClickType=%@&Savings=%@&AdPrice=%@&RegPrice=%@",_data[@"UPC"],_data[@"CategoryID"],_data[@"FinalPrice"],_data  [@"PrimaryOfferTypeId"],_data[@"OfferDetailId"],_data[@"PersonalCircularID"],_data[@"ValidityEndDate"],@"1",
                   _data[@"PackagingSize"],_data[@"DisplayPrice"],_data[@"RelevantUPC"],_data[@"Description"],
                   _data[@"SpecialInformation"],_data[@"CouponID"],memberid[0],@"1",_data[@"PricingMasterID"],
                   _data[@"TileNumber"],_data[@"PageID"],clicktype,_data[@"Savings"],_data[@"AdPrice"],_data[@"RegularPrice"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *jsonString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ACTIVATE_URL]];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSURLResponse*response=nil;
    NSError*err=nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
   if (responseData!=nil)
    {
        NSMutableDictionary *jsonresonse = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
      
        if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
        {
        
            NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:_data];
            [dict setObject:@"1" forKey:@"ClickCount"];
             _data=dict;
            
     
            
            if ([_comefrom isEqualToString:@"Cicular"])
            {
                               bundle = [NSBundle bundleForClass:[self class]];
                               if([_data[@"PrimaryOfferTypeId"] integerValue]==2)
                               {
                                     [self.delegate BackActivateFucDetails:_data];
                               }
                                else
                                {
                                 [self.delegate BackActivateFucDetails:_data];
                               }
           }
             else if ([_comefrom isEqualToString:@"ParticipantingDeatilsView"])
             {
                 
                      [self.delegate backActivateParticipanting:_data];
             }
             else if ([_comefrom isEqualToString:@"ParticipantingCircularView"])
             {
                     [self.delegate backActivateParticipanting:_data];
                 
             }
             else if ([_comefrom isEqualToString:@"SoppingDetailsView"])
             {
              
                 
             }
             else if ([_comefrom isEqualToString:@"Deatils"])
             {
                 
             }
              else if ([_comefrom isEqualToString:@"SoppingDeatils2"])
              {
                  
              }
            
         else
            {
               
              
                 [self.delegate backActivateParticipanting:_data];
            }

           
      }
    }
}
-(void)activatedbtn_One:(NSString*)clicktype
{
    
    _litleActlab.text=@"Activated";
    _btnimg.hidden=NO;
    _btnimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
    _activebtncolor.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
    
    
    
    NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                               @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                               };
    NSArray*memberid=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
    NSLog(@"MemberID:%@",memberid[0]);
    NSString *post=[NSString stringWithFormat:@"UPCCode=%@&CategoryID=%@&SalePrice=%@&PrimaryOfferTypeId=%@&OfferDetailId=%@&PersonalCircularID=%@&ExpirationDate=%@&ClientID=%@&PackagingSize=%@&DisplayPrice=%@&RelevantUPC=%@&Description=%@&SpecialInformation=%@&CouponID=%@&MemberID=%@&DeviceId=%@&OPMOfferID=%@&iPositionID=%@&PageID=%@&ClickType=%@&Savings=%@&AdPrice=%@&RegPrice=%@",_data[@"UPC"],_data[@"CategoryID"],_data[@"FinalPrice"],_data  [@"PrimaryOfferTypeId"],_data[@"OfferDetailId"],_data[@"PersonalCircularID"],_data[@"ValidityEndDate"],@"1",
                    _data[@"PackagingSize"],_data[@"DisplayPrice"],_data[@"RelevantUPC"],_data[@"Description"],
                    _data[@"SpecialInformation"],_data[@"CouponID"],memberid[0],@"1",_data[@"PricingMasterID"],
                    _data[@"TileNumber"],_data[@"PageID"],clicktype,_data[@"Savings"],_data[@"AdPrice"],_data[@"RegularPrice"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *jsonString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ACTIVATE_URL]];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSURLResponse*response=nil;
    NSError*err=nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (responseData!=nil)
    {
        NSMutableDictionary *jsonresonse = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        
        if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
        {
            
            NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:_data];
            [dict setObject:@"1" forKey:@"ClickCount"];
            _data=dict;
       }
    }
}
-(void)ShoppingViewListUpdateAdd:(NSMutableDictionary*)dicts
{
    
     [self.delegate UpdatedShoppingAddQtySubAqty:dicts];
     [self.delegate shoppinglist];
     [self.delegate CircularToshoppingToatlQtyadd:dicts];
    
    
}
-(void)ShoppingViewListUpdateSub:(NSMutableDictionary*)dicts
{
    [self.delegate UpdatedShoppingAddQtySubAqty:dicts];
    [self.delegate shoppinglist];
        [self.delegate CircularToshoppingToatlQtysub:dicts];

}
-(void)addproductfun
{
    
    

    
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                               };
    NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
    NSString *upc =_data[@"UPC"];
    NSInteger count=[_data[@"Quantity"] integerValue];
    NSString* quantity;
    if (count==0)
    {
        
           ClickType=@"1";
         [self activatedbtn_One:ClickType];
         if ([_comefrom isEqualToString:@"Cicular"])
        {
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self.delegate shoppinglistcount];
            });
        }
        else if ([_comefrom isEqualToString:@"ParticipantingDeatilsView"])
        {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               [self.delegate DeatilsShoppinglistcount];
           });
           
            
        }
      else if ([_comefrom isEqualToString:@"ParticipantingCircularView"])
      {
          
                  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                      [self.delegate DetailsRelatedDetailsShoppinglist];
                  });
          
          
      }
     else if ([_comefrom isEqualToString:@"SoppingDeatils2"])
     {
                [self.delegate shoppinglistviewpage];
      }
      else if ([_comefrom isEqualToString:@"SoppingDetailsView"])
      {
             [self.delegate shoppinglist];
       }
     
        else if ([_comefrom isEqualToString:@"Deatils"])
        {
            
        }
    
      
  }
    if (count>0 || count==0)
    {
       
        count++;
        NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:_data];
        [dict setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Quantity"];
        _data=dict;
         quantity=_data[@"Quantity"];
        
    }
    
    
    _countproductlab.text=[NSString stringWithFormat:@"%ld",(long)count];
     _additemsplus.text=@"+";
    //_additemsplus.text=[NSString stringWithFormat:@"%ld",(long)count];
    NSDictionary *profile = @{@"ShoppingListItems":@[@{@"UPC":upc,@"Quantity":quantity,@"DateAddedOn":@"12/7/2018 10:53:31 PM"}]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:profile options:0 error:NULL];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString*finaljson=[NSString stringWithFormat:@"'%@'",jsonString];
    NSURLComponents *components = [NSURLComponents componentsWithString:ADDPRODUCT_URL];
    NSURLQueryItem *memberid = [NSURLQueryItem queryItemWithName:@"memberid" value:arra[0]];
    components.queryItems = @[memberid];
    NSURL *url = components.URL;
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"PUT"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:[finaljson dataUsingEncoding:NSUTF8StringEncoding]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSURLResponse*response=nil;
    NSError*err=nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (responseData!=nil)
    {
        NSMutableDictionary *jsonresonse = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
           NSLog(@"jsonresonse:%@",jsonresonse);
        if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
        {
   
       
             if ([_comefrom isEqualToString:@"Cicular"])
             {
                  //[self.delegate BackActivateFuc:_data];
                 
                     [self.delegate BackActivateFucDetails:_data];
                     [self.delegate AddRelatedCountToatalQty:_data];
                
             }
            else if ([_comefrom isEqualToString:@"SoppingDetailsView"])
             {
                 
               
                     [self.delegate UpdatedShoppingAddQtySubAqty:_data];
                     [self.delegate shoppinglist];
                     [self.delegate CircularToshoppingToatlQtyadd:_data];
             }
            
           else if ([_comefrom isEqualToString:@"ParticipantingCircularView"])
            {
                
                   [self.delegate backActivateParticipanting:_data];
                    [self.delegate AddTotalqty:_data];
                
            }
          else if ([_comefrom isEqualToString:@"ParticipantingDeatilsView"])
          {
               [self.delegate backActivateParticipanting:_data];
               [self.delegate DetaileRelatedDetaileToUpdatedCircularAdd:_data];
             
           
          
          }
          else if ([_comefrom isEqualToString:@"SoppingDeatils2"])
          {
           
                  [self.delegate shoppinglistViewpageAdd:_data];
           }
           else if ([_comefrom isEqualToString:@"Deatils"])
           {
               
           }

            
       
        }
    }
    
}
- (void)viewDidLoad
{
      [super viewDidLoad];
    
    if ([_comefrom isEqualToString:@"SoppingDetailsView"])
    {
           [self ShoppinglistApi];
           [self isDetailsShowingFun];
    }
    else
    {
         [self isDetailsShowingFun];
    }
    [_addbtn addTarget:self action:@selector(addbtn:) forControlEvents:UIControlEventTouchUpInside];
      [Validation setRoundView:self.activebtncolor borderWidth:0 borderColor:nil radius:_activebtncolor.layer.frame.size.height/2];
      [Validation addShadowToView:_headerView];
      [Validation addShadowToViewwhite:self.Activateview];
     UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
     tapScroll.cancelsTouchesInView = YES;
     tapScroll.numberOfTapsRequired = 1;
     [self.shoadShow addGestureRecognizer:tapScroll];
    NSLog(@"comefrom:%@",_comefrom);
    
    [_productprice setTextAlignment:NSTextAlignmentLeft];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)handleImageTap:(UITapGestureRecognizer*)gestureRecognizer
{
      [self.view endEditing:YES];
//     _addtolistview.hidden=YES;
//     _AdditemsBtn.hidden=NO;
//     _additemsplus.hidden=NO;
    
//        _addtolistview.hidden=NO;
//        _AdditemsBtn.hidden=NO;
//        _additemsplus.hidden=NO;
}
-(void)isDetailsShowingFun
{
    
    
    _withfraewaytitle.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    bundle = [NSBundle bundleForClass:[self class]];
   
    if ([_data[@"PrimaryOfferTypeId"] integerValue]==1)
    {
        //My Sale Items
        
        _productlong_name.hidden=YES;
        _withfraewaytitle.hidden=YES;
        _Getproductprice.hidden=YES;
        _productprice.textAlignment = NSTextAlignmentCenter;
        _ActivateBtn.text=_data[@"OfferTypeTagName"];
        _ActivateBtn.backgroundColor=[UIColor colorWithRed:9/255.0 green:82/255.0 blue:149/255.0 alpha:1.0];
        [self singleViewFunction];
        _removeview.hidden=YES;
        _Activateview.hidden=YES;
        NSString* camelCaseString =[_data valueForKey:@"Description"];
        [self stringByReplacingSnakeCaseWithCamelCase:[NSString stringWithFormat:@"%@ \n %@",camelCaseString,[_data valueForKey:@"PackagingSize"]] lab:_product_name];
       [self setimgeFromProduct:_data];
         NSString*strr=[Validation convertHtmlPlainText:[NSString stringWithFormat:@"%@",_data[@"DisplayPrice"]]];
        [self displaypriceFun:strr];
        
        
    }
    else if([_data[@"PrimaryOfferTypeId"] integerValue]==2)
    {
         //My Personal Coupon
             _productlong_name.hidden=NO;
           _removeview.hidden=YES;
          _Getproductprice.hidden=NO;
     
//         [self stringByReplacingSnakeCaseWithCamelCase:[NSString stringWithFormat:@"%@ \n %@ \n        %@",camelCaseString,[_data valueForKey:@"PackagingSize"],[_data valueForKey:@"CouponShortDescription"]] lab:_product_name];
           _withfraewaytitle.text=@"With Coupon";
            NSString* camelCaseString =[_data valueForKey:@"Description"];
      [self stringByReplacingSnakeCaseWithCamelCase:[NSString stringWithFormat:@"%@ \n %@",camelCaseString,[_data valueForKey:@"PackagingSize"]] lab:_product_name];
        _ActivateBtn.text=_data[@"OfferTypeTagName"];
        [self CoustomdetailslayoutCoupons];
        _ActivateBtn.backgroundColor=[UIColor colorWithRed:156/255.0 green:186/255.0 blue:95/255.0 alpha:1.0];
        _countproductlab.text=[NSString stringWithFormat:@"%@",_data[@"Quantity"]];
        if ([_data[@"OfferDefinitionId"] integerValue]==8 || [_data[@"OfferDefinitionId"] integerValue]==5)
          {
              [Validation getPostImageFromServer_v2:_data[@"CouponImageURl"] showOnpostimage:self.img];
          }
         else
         {
             [self setimgeFromProduct:_data];
         }
       
        
        NSString* camelCaseStrings = [_data valueForKey:@"CouponShortDescription"];
        [self stringByReplacingSnakeCaseWithCamelCase:[NSString stringWithFormat:@"%@",camelCaseStrings] lab:_productlong_name];
        
        [self coupnsedisplayprice:_data];
        [self PrimaryOfferTypeId_TWO];
       
  }
   else if([_data[@"PrimaryOfferTypeId"] integerValue]==3)
   {
         _Getproductprice.hidden=YES;
         NSString* camelCaseString =[_data valueForKey:@"Description"];
         [self stringByReplacingSnakeCaseWithCamelCase:[NSString stringWithFormat:@"%@ \n %@",camelCaseString,[_data valueForKey:@"PackagingSize"]] lab:_product_name];
         _productprice.textAlignment = NSTextAlignmentCenter;
         _ActivateBtn.text=_data[@"OfferTypeTagName"];
         _ActivateBtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
          [self singleViewFunction];
         [self PrimaryOfferTypeId_TWO];
          _withfraewaytitle.text=@"With MyFareway";
         NSString*strr=[Validation convertHtmlPlainText:[NSString stringWithFormat:@"%@",_data[@"DisplayPrice"]]];
         [self displaypriceFun:strr];
        [self setimgeFromProduct:_data];
            _productlong_name.hidden=YES;
      
     }
    //_additemsplus.text=@"+";
     // _additemsplus.text=[NSString stringWithFormat:@"%@",_data[@"Quantity"]];
     _countproductlab.text=[NSString stringWithFormat:@"%@",_data[@"Quantity"]];
     _countproductlab.textColor=[UIColor blackColor];
     [Validation setRoundView:self.additemsplus borderWidth:0 borderColor:nil radius:_additemsplus.layer.frame.size.height/2];
     [Validation setRoundView:self.removeview borderWidth:0 borderColor:nil radius:10];
     [Validation setRoundView:self.addbtn borderWidth:0 borderColor:nil radius:_addbtn.layer.frame.size.height/2];
     [Validation setRoundView:self.subbtn borderWidth:0 borderColor:nil radius:_subbtn.layer.frame.size.height/2];
}
-(void)coupnsedisplayprice:(NSMutableDictionary*)str
{
    
    _productprice.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    _Getproductprice.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
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
        
         UIFont *BuyFont = [UIFont fontWithName:@"Helvetica-Bold" size:20];
         NSDictionary *arialDict = [NSDictionary dictionaryWithObject: BuyFont forKey:NSFontAttributeName];
         NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",Rewardvalue,staticstr] attributes: arialDict];
         _productprice.attributedText=aAttrString;
         _Getproductprice.hidden=YES;
      
     }
    else if ([[str valueForKey:@"OfferDefinitionId"] integerValue]==4)
    {
        if ([[str valueForKey:@"RewardType"] integerValue]==2)
        {
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
                UIFont *BuyFont = [UIFont fontWithName:@"Helvetica-Bold" size:20];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject: BuyFont forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Buy %@\n",[str valueForKey:@"RequiredQty"]] attributes: arialDict];
                _productprice.attributedText=aAttrString;
                
                UIFont *otherfont = [UIFont fontWithName:@"Helvetica-Bold" size:13];
                NSDictionary *halDict = [NSDictionary dictionaryWithObject: otherfont forKey:NSFontAttributeName];
                NSMutableAttributedString *bAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Get %@ %@%@",[str valueForKey:@"RewardQty"],Rewardvalue,staticstr] attributes: halDict];
                 _Getproductprice.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
                _Getproductprice.attributedText = bAttrString;
                
                
            }
        }
        else if([[str valueForKey:@"RewardType"] integerValue]==3 &&[[str valueForKey:@"FinalPrice"] floatValue]>0)
        {
            
            NSString*DisplayPrice=[Validation convertHtmlPlainText:str[@"oDisplayPrice"]];
            [self displaypriceFun:[NSString stringWithFormat:@"%@",DisplayPrice]];
            _Getproductprice.hidden=YES;
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
            UIFont *BuyFont = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            NSDictionary *arialDict = [NSDictionary dictionaryWithObject: BuyFont forKey:NSFontAttributeName];
            NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Buy %@\n",[str valueForKey:@"RequiredQty"]] attributes: arialDict];
           
             _productprice.attributedText=aAttrString;
            
            
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

-(void)displaypriceFun:(NSString*)str
{
    
    _productprice.textColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    NSString*isfloatzero;
    NSString*check=[str substringToIndex: 2];
    NSString*strs=[check substringFromIndex:1];
    if ([[str substringToIndex:1] isEqualToString:@"$"])
    {
    
        
       NSString *qlwUnitsPlainText = [NSString stringWithFormat:@"%@",str];
        NSArray *myArray = [qlwUnitsPlainText componentsSeparatedByString:@"."];
        if (myArray.count==2)
        {
            if ([myArray[1] isEqualToString:@"00"])
            {
                isfloatzero=[NSString stringWithFormat:@"%@",myArray[0]];
                _productprice.attributedText=[Validation plainStringToAttributedUnitsDeatilspage:isfloatzero:@"$"];
            }
            else
            {
                _productprice.attributedText=[Validation plainStringToAttributedUnitsDeatilspage:qlwUnitsPlainText:@"$"];
                
            }
        }
        else
        {
               _productprice.attributedText=[Validation plainStringToAttributedUnitsDeatilspage:qlwUnitsPlainText:@"$"];
        }
  
    }
    else if ([[str substringFromIndex: [str length] - 1] isEqualToString:@"¢"])
    {
        NSString *qlwUnitsPlainText = [NSString stringWithFormat:@"%@",str];
        _productprice.attributedText=[Validation plainStringToAttributedUnitsDeatilspage:qlwUnitsPlainText:@"¢"];
    }
    else if ([[str substringFromIndex: [str length] - 1] isEqualToString:@"F"])
    {
        
        
        NSString *qlwUnitsPlainText = [NSString stringWithFormat:@"%@",str];
        _productprice.attributedText=[Validation plainStringToAttributedUnitsDeatilspage:qlwUnitsPlainText:@"F"];
    }
    else if ([strs isEqualToString:@"/"])
    {
        NSLog(@"/strs");
        NSString *qlwUnitsPlainText = [NSString stringWithFormat:@"%@",str];
        _productprice.attributedText=[Validation plainStringToAttributedUnitsDeatilspage:qlwUnitsPlainText:@"/"];
    }
    
    else
    {
        _productprice.text=[NSString stringWithFormat:@"%@",str];
    }
}
-(void)PrimaryOfferTypeId_TWO
{
    
    
     _Activateview.hidden=NO;
      bundle = [NSBundle bundleForClass:[self class]];
     if ([[_data valueForKey:@"ClickCount"] integerValue]==1)
    {
         _litleActlab.text=@"Activated";
         _btnimg.hidden=NO;
          _btnimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
        _activebtncolor.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
          _removeview.hidden=YES;
    }
    else
    {
      
        _litleActlab.text=@"Activate";
        _btnimg.hidden=YES;
        _activebtncolor.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
         _removeview.hidden=YES;
        
    }
    
    
}

-(void)singleViewFunction
{
    
      _Regular_priceTitle.text=@"Every Day Price:";
     _Regular_price2.text=[NSString stringWithFormat:@"$%@",_data[@"RegularPrice"]];
    float myNumber = [_data[@"Savings"] floatValue];
    _labTitle2.text=@"Savings:";
    _lab2.text=[NSString stringWithFormat:@"$%.02f",myNumber];
    _labTitle3.text=@"UPC:";
    _lab3.text=_data[@"UPC"];
    _labTitle4.text=@"Valid Through:";
     [self showValidthrough:_lab4];
            _labTitle5.hidden=YES;
            _lab5.hidden=YES;
            
            
            _view8.hidden=YES;
            _labTitle6.hidden=YES;
            _lab6.hidden=YES;
            _view6.hidden=YES;
            
            
            _labTitle7.hidden=YES;
            _lab7.hidden=YES;
            _view7.hidden=YES;
            
            _labTitle7.hidden=YES;
            _lab7.hidden=YES;
            _view7.hidden=YES;
           
          [self RelateditemsShowing:_view4 hideview:_view5];
 
 
 }

-(void)RelateditemsShowing:(UIView*)view hideview:(UIView*)hidevie
{
    
    
    
//      if ([_comefrom isEqualToString:@"SoppingDetailsView"])
//       {
//           _Relateditems.hidden=YES;
//       }
//    else
//    {
        if([_data[@"PrimaryOfferTypeId"] integerValue]==1)
        {
            if ([_data[@"HasRelatedItems"] integerValue]==0)
            {
                _Relateditems.hidden=YES;
            }
            else
            {
                   if ([_data[@"RelatedItemCount"] integerValue]>0)
                   {
                       _Relateditems.hidden=NO;
                       NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ Varieties",_data[@"RelatedItemCount"]]];
                       [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [commentString length])];
                       [_Relateditems setAttributedTitle:commentString forState:UIControlStateNormal];
                    }
                    else
                    {
                         _Relateditems.hidden=YES;
                    }
                
               
                
            }
            _Activateview.hidden=NO;
        }
      else  if([_data[@"PrimaryOfferTypeId"] integerValue]==3)
       {
           if ([_data[@"HasRelatedItems"] integerValue]==0)
           {
               _Relateditems.hidden=YES;
           }
           else
           {
               if ([_data[@"RelatedItemCount"] integerValue]>1)
               {
                   _Relateditems.hidden=NO;
                   NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ Varieties",_data[@"RelatedItemCount"]]];
                   [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [commentString length])];
                   [_Relateditems setAttributedTitle:commentString forState:UIControlStateNormal];
               }
               else
               {
                   _Relateditems.hidden=YES;
               }
        }
            _Activateview.hidden=NO;
           
       }
        else  if([_data[@"PrimaryOfferTypeId"] integerValue]==2)
        {
            if ([_data[@"HasRelatedItems"] integerValue]==0)
            {
                _Relateditems.hidden=YES;
            }
            else
            {
//                      if ([_data[@"RelatedItemCount"] integerValue]>1)
//                      {
                          _Relateditems.hidden=NO;
                          NSString *string=@"Participating Items";
                          NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",string]];
                          [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [commentString length])];
                          [_Relateditems setAttributedTitle:commentString forState:UIControlStateNormal];
//                      }
//                    else
//                    {
//                        _Relateditems.hidden=YES;
//
//                    }
             
              
            }
            _Activateview.hidden=YES;
        }
      
 //  }
    
    _Relateditems.titleLabel.textColor=[UIColor blackColor];
    NSInteger relatedlineview=view.frame.origin.y+view.frame.size.height;
    _RelateditemsVies.frame=CGRectMake(_RelateditemsVies.frame.origin.x,relatedlineview+1, _RelateditemsVies.frame.size.width, _RelateditemsVies.frame.size.height);
    [_AdditemsBtn setImage:[UIImage imageNamed:@"addRelated.jpg" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    // [_AdditemsBtn setTitle:[NSString stringWithFormat:@" %@",@""] forState:UIControlStateNormal];
    _additemsplus.frame=CGRectMake(_additemsplus.frame.origin.x,_AdditemsBtn.frame.origin.y, _additemsplus.frame.size.width,_additemsplus.frame.size.height);
    _additemsplus.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    _countproductlab.text=[NSString stringWithFormat:@"%@",_data[@"Quantity"]];
    // _additemsplus.text=[NSString stringWithFormat:@"%@",_data[@"Quantity"]];
       _additemsplus.text=@"+";
    _addlab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    _sublab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    [Validation setRoundView:self.addlab borderWidth:0 borderColor:nil radius:_addlab.layer.frame.size.height/2];
    [Validation setRoundView:self.sublab borderWidth:0 borderColor:nil radius:_sublab.layer.frame.size.height/2];

}


-(void)showValidthrough:(UILabel*)lab
{
    
    NSString*dateString=[NSString stringWithFormat:@"%@",_data[@"ValidityEndDate"]];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yy"];
    NSDate *date = [format dateFromString:dateString];
    [format setDateFormat:@"MM/dd"];
    NSString* Expdate = [format stringFromDate:date];
    lab.text=[NSString stringWithFormat:@"%@",Expdate];
    
    
}
-(void)CoustomdetailslayoutCoupons
{
    
      float myNumber = [_data[@"AdPrice"] floatValue];
      NSString*AdPrice=[NSString stringWithFormat:@"%.02f",myNumber];
      NSString*RegularPric=[NSString stringWithFormat:@"%@",_data[@"RegularPrice"]];
     if([AdPrice isEqual:RegularPric] && [RegularPric isEqual:AdPrice])
     {
        
        _Regular_priceTitle.text=@"Every Day Price:";
        _Regular_price2.text=[NSString stringWithFormat:@"$%@",_data[@"RegularPrice"]];
         float CouponDiscount = [_data[@"CouponDiscount"] floatValue];
         _labTitle2.text=@"Coupon Value:";
        _lab2.text=[NSString stringWithFormat:@"$%.02f",CouponDiscount];
        float myNumber = [_data[@"Savings"] floatValue];
       _labTitle3.text=@"Savings:";
        _lab3.text=[NSString stringWithFormat:@"$%.02f",myNumber];
        _labTitle4.text=@"UPC:";
        _lab4.text=_data[@"UPC"];
        
        if ([_data[@"LimitPerTransection"] integerValue]==0)
        {
            _labTitle5.text=@"Limit:";
            _lab5.text=@"Unlimited";
        }
        else
        {
            _labTitle5.text=@"Limit:";
            _lab5.text=[NSString stringWithFormat:@"%@",_data[@"LimitPerTransection"]];
        }
        _labTitle6.text=@"Valid Through:";
         [self showValidthrough:_lab6];
        _labTitle7.hidden=YES;
        _lab7.hidden=YES;
         [self RelateditemsShowing:_view6 hideview:_view7];
        _view8.hidden=YES;
       
    }
    else if([AdPrice floatValue]!=0.0000  && [_data[@"RewardType"] integerValue]==1)
    {
        
          [self alldetailshowing];
    }
    else if ([_data[@"RewardType"] integerValue]!=3 && [AdPrice floatValue]==0.0000)
    {
                _Regular_priceTitle.text=@"UPC:";
                _Regular_price2.text=[NSString stringWithFormat:@"%@",_data[@"UPC"]];
                _labTitle2.text=@"Limit";
                _lab2.text=[NSString stringWithFormat:@"%@",_data[@"LimitPerTransection"]];
                _labTitle3.text=@"Valid Through:";
                [self showValidthrough:_lab3];
               [self RelateditemsShowing:_view3 hideview:_view4];
        
        
//        _Regular_priceTitle.text=@"UPC:";
//        _Regular_price2.text=[NSString stringWithFormat:@"%@",_data[@"UPC"]];
      
//        _Regular_priceTitle.text=@"Limit:";
//        _Regular_price2.text=[NSString stringWithFormat:@"%@",_data[@"LimitPerTransection"]];
//        _labTitle2.text=@"Valid Through:";
//        [self showValidthrough:_lab2];
       // [self RelateditemsShowing:_view2 hideview:_view3];
//                     _labTitle3.hidden=YES;
//                       _lab3.hidden=YES;
        
        
        
                   _labTitle4.hidden=YES;
                    _lab4.hidden=YES;
        
        
        
                    _labTitle5.hidden=YES;
                    _lab5.hidden=YES;
                    _view5.hidden=YES;
        
                    _labTitle6.hidden=YES;
                    _lab6.hidden=YES;
                    _view6.hidden=YES;
        
        
                    _labTitle7.hidden=YES;
                    _lab7.hidden=YES;
                    _view7.hidden=YES;
        
                 _view8.hidden=YES;
        
    }
    else
    {
        [self alldetailshowing];
    }
   
    
}
-(void)alldetailshowing
{
    
//    _Regular_priceTitle.text=@"Regular price:";
//    _Regular_price2.text=[NSString stringWithFormat:@"$%@",_data[@"RegularPrice"]];
//
//    _labTitle2.text=@"Ad Price:";
//    _lab2.text=[NSString stringWithFormat:@"$%@",_data[@"AdPrice"]];
  
     float AdPrice = [_data[@"AdPrice"] floatValue];
 
     _Regular_priceTitle.text=@"Every Day Price:";
     _Regular_price2.text=[NSString stringWithFormat:@"$%@",_data[@"RegularPrice"]];
    
     _labTitle2.text=@"Promo Price:";
     _lab2.text=[NSString stringWithFormat:@"$%.02f",AdPrice];
    
    
    
      float CouponDiscount = [_data[@"CouponDiscount"] floatValue];
    
       _labTitle3.text=@"Coupon Value:";
       _lab3.text=[NSString stringWithFormat:@"$%.02f",CouponDiscount];
    
    
    float myNumber = [_data[@"Savings"] floatValue];
    _labTitle4.text=@"Savings:";
    _lab4.text=[NSString stringWithFormat:@"$%.02f",myNumber];
    
    _labTitle5.text=@"UPC:";
    _lab5.text=_data[@"UPC"];
    
    if ([_data[@"LimitPerTransection"] integerValue]==0)
    {
        _labTitle6.text=@"Limit:";
        _lab6.text=@"Unlimited";
    }
    else
    {
        _labTitle6.text=@"Limit:";
        _lab6.text=[NSString stringWithFormat:@"%@",_data[@"LimitPerTransection"]];
    }
    
        _labTitle7.text=@"Valid Through:";
         [self showValidthrough:_lab7];

          [self RelateditemsShowing:_view7 hideview:_view8];
         _view8.hidden=YES;
 
    
}

-(IBAction)addfun:(UIButton*)sender
{
    self->_litleActlab.text=@"Activated";
    self->_btnimg.hidden=NO;
    self->_btnimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:self->bundle compatibleWithTraitCollection:nil];
    self->_activebtncolor.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
//    _addlab.backgroundColor=[UIColor lightGrayColor];
//    [Validation zoomIn:_addlab];
    

//    [NSTimer scheduledTimerWithTimeInterval:0.001
//                                     target:self
//                                   selector:@selector(addTimer:)
//                                   userInfo:nil
//                                    repeats:NO];
    
   
    
          dispatch_async(dispatch_get_main_queue(), ^{
            [self addproductfun];
            });
  
}
-(void)shoppingViewListApi
{
    [self.delegate shoppinglist];
}
-(void)addTimer:(NSTimer*)timer{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
        [self addproductfun];
   // });
    _addlab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    
}
-(IBAction)subfun:(UIButton*)sender
{

    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                               };
    NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
    NSString *upc =_data[@"UPC"];
    NSInteger count=[_data[@"Quantity"] integerValue];
    NSString* quantity;
    if (count==1)
    {
      
         if ([_comefrom isEqualToString:@"Cicular"])
         {
             
             
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self.delegate shoppinglistcount];
             });
                  [self removefuncheckedate];
                  [self.delegate BackRemoveQuantity:_data];
         }
         else if ([_comefrom isEqualToString:@"ParticipantingDeatilsView"])
         {
             
               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [self.delegate DeatilsShoppinglistcount];
             });
            // detailsToRelatedTodetails
             [self removefuncheckedate];
             [self.delegate removeQuantityRelatedFromDetailspage:_data];
             
         }
         else if ([_comefrom isEqualToString:@"ParticipantingCircularView"])
         {
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 [self.delegate DetailsRelatedDetailsShoppinglist];
             });
              [self removefuncheckedate];
         }
        
         else if ([_comefrom isEqualToString:@"SoppingDetailsView"])
         {
               [self.delegate RemoveShoppinglist:_data];
                [self removefuncheckedate];
         }
         else if ([_comefrom isEqualToString:@"SoppingDeatils2"])
         {
                [self removefuncheckedate];
         }
         else if ([_comefrom isEqualToString:@"Deatils"])
         {
             
         }
        else
        {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////                [self.delegate  DetailsRelatedDetailsShoppinglist];
//                  [self.delegate  shoppinglistcount];
//            });
         
        }
    }
    if (count>0)
    {
        
        count--;
        NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:_data];
        [dict setObject:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"Quantity"];
        _data=dict;
        quantity=_data[@"Quantity"];

        _countproductlab.text=[NSString stringWithFormat:@"%ld",(long)count];
        _additemsplus.text=@"+";
        //_additemsplus.text=[NSString stringWithFormat:@"%ld",(long)count];
        NSDictionary *profile = @{@"ShoppingListItems":@[@{@"UPC":upc,@"Quantity":quantity,@"DateAddedOn":@"12/7/2018 10:53:31 PM"}]};
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:profile options:0 error:NULL];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString*finaljson=[NSString stringWithFormat:@"'%@'",jsonString];
        NSURLComponents *components = [NSURLComponents componentsWithString:ADDPRODUCT_URL];
        NSURLQueryItem *memberid = [NSURLQueryItem queryItemWithName:@"memberid" value:arra[0]];
        components.queryItems = @[memberid];
        NSURL *url = components.URL;
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"PUT"];
        [request setAllHTTPHeaderFields:headers];
        [request setHTTPBody:[finaljson dataUsingEncoding:NSUTF8StringEncoding]];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        NSURLResponse*response=nil;
        NSError*err=nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        if (responseData!=nil)
        {
            NSMutableDictionary *jsonresonse = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
          //  NSLog(@"jsonresonse:%@",jsonresonse);
            if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
            {
                

                if ([_comefrom isEqualToString:@"Cicular"])
                {
                    [self.delegate BackActivateFucDetails:_data];
                    [self.delegate SubRelatedCountToatalQty:_data];
                }
                else if ([_comefrom isEqualToString:@"SoppingDetailsView"])
                {
                      [self.delegate UpdatedShoppingAddQtySubAqty:_data];
                      [self.delegate shoppinglist];
                      [self.delegate CircularToshoppingToatlQtysub:_data];
                }
                else if ([_comefrom isEqualToString:@"ParticipantingCircularView"])
                {
                    [self.delegate backActivateParticipanting:_data];
                    [self.delegate SubTotalqty:_data];
                    
                }
                else if ([_comefrom isEqualToString:@"SoppingDeatils2"])
                {
                     [self.delegate shoppinglistViewpageSub:_data];
                }
                 else if ([_comefrom isEqualToString:@"ParticipantingDeatilsView"])
                  {
                       // [self.delegate DetailsToParticipantingAddQtyAndSubQty:_data];
                        [self.delegate backActivateParticipanting:_data];
                        [self.delegate DetaileRelatedDetaileToUpdatedCircularSub:_data];
                  }
                
               
               else
                {
                    [self.delegate backActivateParticipanting:_data];
                    [self.delegate SubTotalqty:_data];
                }
             
            }
        }
    }

}
-(void)getshopinglistcounts
{
    
    
    NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                              };
    NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
    NSURLComponents *components = [NSURLComponents componentsWithString:SHOPPINGLIST_URL];
    NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"memberid" value:arra[0]];
    NSURLQueryItem *device = [NSURLQueryItem queryItemWithName:@"CategoryID" value:@"123"];
    components.queryItems = @[LoyaltyCardNumber,device];
    NSURL *url = components.URL;
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSURLResponse*response=nil;
    NSError*err=nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (responseData!=nil)
    {
        NSMutableDictionary *jsonObject= [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        if ([[jsonObject valueForKey:@"errorcode"] integerValue]==0)
        {
            NSArray* array=jsonObject[@"message"][@"ShoppingListItems"];
          if ([array  isKindOfClass:[NSNull class]])
            {
                
            }

            
        }
        
    }
    
}
-(void)removefuncheckedate
{
    
    
    NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                               @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                               };
    NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
    NSURLComponents *components = [NSURLComponents componentsWithString:REMOVE_URL];
    NSURLQueryItem *memberid = [NSURLQueryItem queryItemWithName:@"MemberId" value:arra[0]];
    NSURLQueryItem *upc = [NSURLQueryItem queryItemWithName:@"upccode" value:_data[@"UPC"]];
    components.queryItems = @[upc,memberid];
    NSURL *url = components.URL;
  
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"DELETE"];
    [request setAllHTTPHeaderFields:headers];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSURLResponse*response=nil;
    NSError*err=nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (responseData!=nil)
    {
        NSMutableDictionary *jsonresonse = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
       bundle = [NSBundle bundleForClass:[self class]];
        if ([[jsonresonse valueForKey:@"responsecode"] integerValue]==1)
        {
            
            NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:_data];
            [dict setObject:@"0" forKey:@"Quantity"];
            _data=dict;
        }
    }
}
-(IBAction)removefun:(UIButton*)sender
{
    _removeview.hidden=YES;
    _litleActlab.text=@"Add";
    _activebtncolor.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    _btnimg.image = [UIImage imageNamed:@"add.png" inBundle:bundle compatibleWithTraitCollection:nil];

    
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
    [self  removefuncheckedate];
    
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

-(IBAction)activated:(id)sender
{
    
    
    _litleActlab.text=@"Activated";
    _activebtncolor.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
    _btnimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
    _btnimg.hidden=NO;
    if ([[_data valueForKey:@"ListCount"] integerValue]==0)
    {
         ClickType=@"2";
        [self activatedbtn:ClickType];
     }
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

-(void)setimgeFromProduct:(NSMutableDictionary*)dict
{
   // NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString*defaultimg=@"http://pty.bashas.com/webapiaccessclient/images/noimage-large.png";
    if ([dict[@"LargeImagePath"] isEqualToString:defaultimg] || [dict[@"LargeImagePath"] isEqualToString:@""])
    {
       //  _img.image = [UIImage imageNamed:@"GEnoimage.jpg" inBundle:bundle compatibleWithTraitCollection:nil];
           [Validation getPostImageFromServer_v2:DEFAULTIMG_URL showOnpostimage:self.img];
      }
    else
    {
           [Validation getPostImageFromServer_v2:dict[@"LargeImagePath"] showOnpostimage:self.img];
    }
    
}
-(void)DetailToRelatedsRemoveBack:(NSMutableDictionary*)dict
{
   //remove
    [self.delegate BackRemoveQuantity:dict];
    
}

-(void)DetailToRelatedsBack:(NSMutableDictionary*)dict
{
     // activated
      // [self.delegate BackActivateFucDetails:_data];
    [self.delegate BackActivateFucDetails:dict];
}
-(void)DetailToRelatedsshoppinglistcount
{
    
     [self.delegate shoppinglistcount];
   
}
-(void)DetailsToRelatedTotalqtyRep:(NSMutableDictionary*)dict
{
       NSLog(@"dict:%@",dict);
       NSLog(@"_comefrom:%@",_comefrom);
//    if ([_comefrom isEqualToString:@"ParticipantingotherView"])
//    {
//            [self.delegate backActivateParticipanting:dict];
//        // [self.delegate AddRelatedCountToatalQty:dict];
//    }
   
}

-(void)DetailToRelatedsAddqty:(NSMutableDictionary*)dict
{
   [self.delegate BackActivateFuc:dict backdatadict:_data];
}
//Circular-Related-deatips to updated circular
-(void)DetailsToRelatedTotalQtyAdd:(NSMutableDictionary*)Redata
{
  [self.delegate AddRelatedCountToatalQty:Redata];
}
-(void)detailsToRelatedTodetails:(NSMutableDictionary*)dict
{
    [self removefuncheckedate];
    [self.delegate BackRemoveQuantity:dict];
    //[self.delegate BackRemoveQuantity:_data];
}
-(void)DetailsToRelatedTotalQtySub:(NSMutableDictionary*)Redata
{
     [self.delegate SubRelatedCountToatalQty:Redata];
}
-(IBAction)backbtn:(id)sender
{
        if ([_comefrom isEqualToString:@"Cicular"])
        {
             [self.navigationController popViewControllerAnimated:YES];
        }
      else if ([_comefrom isEqualToString:@"ParticipantingDeatilsView"])
      {
             [self.navigationController popViewControllerAnimated:YES];
      }
      else if ([_comefrom isEqualToString:@"SoppingDeatils2"])
      {
             [self.navigationController popViewControllerAnimated:YES];
      }
        else if ([_comefrom isEqualToString:@"ParticipantingCircularView"])
       {
             [self.navigationController popToRootViewControllerAnimated:YES];
       }
        else
        {
             [self.navigationController popToRootViewControllerAnimated:YES];
        }
}

-(IBAction)RelatedBtn:(UIButton*)sender
{
    
    
if ([_comefrom isEqualToString:@"ParticipantingDeatilsView"])
{
 
    [self.navigationController popViewControllerAnimated:NO];
}
  else if ([_comefrom isEqualToString:@"SoppingDeatils2"])
  {
       [self.navigationController popViewControllerAnimated:NO];
  }
  else if ([_comefrom isEqualToString:@"ParticipantingCircularView"])
  {
      [self.navigationController popViewControllerAnimated:NO];
  }
 else
 {
   [self performSegueWithIdentifier:@"DeatilsRelatedView" sender:self];
 }
  
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
     NSLog(@"_comefrom:%@",_comefrom);
    
       if ([segue.identifier isEqualToString:@"DeatilsRelatedView"])
       {
        ParticipantingItemViewController *destViewController = segue.destinationViewController;
       
        if ([_comefrom isEqualToString:@"Cicular"])
        {
            destViewController.comefrom=@"Deatils";
            
        }
       else if ([_comefrom isEqualToString:@"SoppingDetailsView"])
       {
              destViewController.comefrom=@"SoppingDeatils";
           
       }
 
        destViewController.Delegate=self;
        destViewController.dataDict =_data;
     }
}
-(IBAction)additems:(UIButton*)sender
{
//    _AdditemsBtn.hidden=YES;
//    _addtolistview.hidden=NO;
//    _additemsplus.hidden=YES;
    _AdditemsBtn.hidden=NO;
    _addtolistview.hidden=NO;
    _additemsplus.hidden=NO;
}

@end
