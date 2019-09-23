
//  MyPersonalPriceViewController.m
//  FrameWorkApp

//  Created by kamlesh prajapati on 20/12/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.


#import "MyPersonalPriceViewController.h"
#import "Validation.h"
#import "SingleTanGlobalClass.h"
#import "ParticipantingItemViewController.h"
#import "ProductDetailsViewController.h"
#import "ATSpeechRecognizer.h"
#import "ObjectType.h"
#import <SVProgressHUD.h>
#import "UIImage+animatedGIF.h"
#import "Reachability.h"
#import <Speech/Speech.h>
#import "ApiHendlerClass.h"
#import "SelectStoreNameViewController.h"
#import "SingleViewCollectionCell.h"
#import "PurchaseHistoryViewController.h"
#import "BarCodeViewConrtoller.h"
#import "DoubleViewCollectionCell.h"
#import "AdditionalOffers.h"
#import "FooterCell.h"
#import "SelectSecreteCell.h"
@interface MyPersonalPriceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,ProductDetailsViewControllerDelegate,ParticipantingItemViewControllerDelegate,SFSpeechRecognizerDelegate,UIGestureRecognizerDelegate,ATSpeechDelegate,SelectStoreNameViewControllerDelegate>
{
        
    
       NSMutableArray*searcharray;//temp
       NSInteger refeshdata;
       NSMutableArray*selectCatidArray;
       NSString*ClickType;
       NSString *post;
       NSArray*memberid;
       NSString*ischeckearraystr;
       NSInteger SelectedProductIndex;
       NSMutableArray*StoreSearchingarray;
   
       NSMutableArray*ischeckedarray;
       UIStoryboard *storyboard;
       int number;
       BOOL isRecAllowed;
    
       NSMutableArray*savingarray;
     NSInteger iapidsIndex;
     NSTimer  *  imageTimer;
     NSArray*  stickersArray;
     NSInteger ischeckvoice;
     NSMutableArray*getBackuparray;
    
     SFSpeechRecognizer *speechRecognizer;
     SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
     SFSpeechRecognitionTask *recognitionTask;
     AVAudioEngine *audioEngine;
     NSInteger count;
     NSInteger addi;

      NSString*footerstr;
    
     NSMutableArray*Morecouponsearray;
     NSMutableArray*getShoppinglistarray;
     NSInteger isMoreCouponsefirst;
     NSMutableArray*cattypedata;
    
    
     NSInteger applesView_y;
     NSInteger applesView_Height;
     NSInteger pheight;
       NSInteger iscategoriesaddfirst;
    
      NSMutableArray*additonalofrray;
      NSMutableArray*arraydata;
    
    
    
    
      NSMutableArray*morecoupnsaddarray;
      NSMutableArray*categoriesaddarray;
    
      NSString*ischeckclear;
    
   
      NSMutableArray*SearchglobalArray;
      NSMutableArray*MoreCoupnseIdChangearray;
    
      NSMutableArray*Globalarraycircularwithadd;
    
    
    //SingleTanGlobalClass*SingleTanGlobalClassobj;
    
    
         NSMutableArray*offerFilterarrayObj;
         NSMutableArray*FilterByCatArray;
         NSMutableArray*Cir_originalarry;
    
        int sortedindex;
    
    
        NSMutableArray*Cir_data;
        NSMutableArray*productList;
        NSMutableArray*searchingarraydata;
    
    
    
         NSInteger primaryoffertypeid;
         NSMutableArray*checkCirArrycouponsid;
    
     NSInteger sortbyid;
    
     NSInteger offersbyid;
      NSInteger selectallindex;
     NSInteger selectallindexx;
     NSMutableArray* SortByarrayObj;
         NSMutableArray*PersonalAddarry;
         NSInteger PersonalAddFirst;
         NSInteger PersonalAddcancel;
    
    
    
         NSInteger catbyid;
}
@end




@implementation MyPersonalPriceViewController
-(void)getshopinglistcount
{
    
    
    NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                              };
    NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
    NSURLComponents *components = [NSURLComponents componentsWithString:SHOPPINGLIST_URL];
    NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"memberid" value:arra[0]];
    NSURLQueryItem *device = [NSURLQueryItem queryItemWithName:@"CategoryID" value:@"2"];
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
             getShoppinglistarray=[[NSMutableArray alloc] init];
           
              if ([array  isKindOfClass:[NSNull class]])
              {
                
             }
            else if ([getShoppinglistarray isKindOfClass:[NSMutableArray class]])
            {
                [getShoppinglistarray addObjectsFromArray:array];
              
            }
            
        }
        
    }
    
}
-(void)GetMoreCouponse
{
     [SVProgressHUD show];
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
        
        NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                  };

        NSArray*arra=[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
        NSURLComponents *components = [NSURLComponents componentsWithString:MORECOUPONS_URL];
        NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"memberid" value:arra[0]];
        NSURLQueryItem *device = [NSURLQueryItem queryItemWithName:@"Plateform" value:@"2"];
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
             Morecouponsearray=[[NSMutableArray alloc] init];
            
             morecoupnsaddarray=[[NSMutableArray alloc] init];
            if ([[jsonObject valueForKey:@"errorcode"] integerValue]==0)
            {
                [SVProgressHUD dismiss];
                for (int i=0; i<[jsonObject[@"message"] count]; i++)
                {
                    if (i==0)
                    {
                        [additonalofrray addObject:jsonObject[@"message"][i]];
                        
                         NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:jsonObject[@"message"][0]];
                         [dict setObject:@"1" forKey:@"CouponID"];
                         [additonalofrray replaceObjectAtIndex:0 withObject:dict];
                         [Morecouponsearray addObjectsFromArray:additonalofrray];
                        
                    }
                    [Morecouponsearray addObject:jsonObject[@"message"][i]];
                    [morecoupnsaddarray addObject:jsonObject[@"message"][i]];
                }
                
           }
            else
            {
                [SVProgressHUD show];
            }
      }
        else
        {
            [SVProgressHUD show];
        }
    }
    
  
}

-(void)Circularlistcheckdate
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
        
        [self GetMoreCouponse];
        [SVProgressHUD show];
        NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                  };
     
       NSArray*arra=[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
        //NSString* arra=[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"]];
        NSURLComponents *components = [NSURLComponents componentsWithString:CIRCULAR_URL];
        NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"memberid" value:arra[0]];
        NSURLQueryItem *device = [NSURLQueryItem queryItemWithName:@"Plateform" value:@"2"];
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
            productList=[[[NSMutableArray alloc] init] mutableCopy];
        PersonalAddarry=[[NSMutableArray alloc] init];
            Cir_data=[[NSMutableArray alloc] init];
           if ([[jsonObject valueForKey:@"errorcode"] integerValue]==0)
            {
                [SVProgressHUD dismissWithDelay:1.0];
                
                for (int i=0; i<[jsonObject[@"message"] count]; i++)
                {
                    if (i==0)
                    {
                         NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:jsonObject[@"message"][i]];
                         [dict setObject:@"1" forKey:@"CouponID"];
                         [PersonalAddarry addObject:dict];
                      
                    }
                     [ischeckedarray addObject:jsonObject[@"message"][i]];
                }
                    [productList addObjectsFromArray:PersonalAddarry];//personal add strip only
                    [productList addObjectsFromArray:ischeckedarray];//only circulr
                    [ischeckedarray addObjectsFromArray:morecoupnsaddarray];//original_data cir and morecouponse
                    [self.delegate function:ischeckedarray];
                    [Cir_data addObjectsFromArray:ischeckedarray];
                
                
                    [productList addObjectsFromArray:Morecouponsearray];//filter by offers add strip
                
          }
            else
            {
                      [SVProgressHUD show];
            }
        }
        else
         {
              [SVProgressHUD show];
         }
    }

}

-(void)GetCircularofferlist
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
     [self Circularlistcheckdate];
}

-(IBAction)PersonalAdfunSea:(id)sender
{

        self->_searchtxt.text=@"";
        [self cancelSearching];
 
       self->_collectionSingletable.hidden=YES;
       self->_collectionDoubletable.hidden=NO;
      _Deafultpopupview.hidden=YES;
      _Deafultpopupviewcolor.hidden=YES;
      [self.delegate hidebolerview];
}
-(IBAction)ReturnPersonalAdfunSea:(id)sender
{
             self->_searchtxt.text=@"";
               [self cancelSearching];
   
      self->_collectionSingletable.hidden=YES;
      self->_collectionDoubletable.hidden=NO;
     _Deafultpopupview.hidden=YES;
     _Deafultpopupviewcolor.hidden=YES;
     [self.delegate hidebolerview];
}



-(void)cancelSearchingcheckdate
{
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSearching"] isEqualToString:@"isSearching"])
    {
        [arraydata removeAllObjects];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"footerstr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"isSearching"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
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
            
             NSInteger addints=0;
                productList=[[NSMutableArray alloc] init];
             [productList removeAllObjects];
          
            PersonalAddcancel=0;
            
             for (int i=0; i<[Cir_originalarry count]; i++)
             {
                 for (int j=0; j<[Cir_data count]; j++)
                  {
                        if ([Cir_originalarry[i][@"PrimaryOfferTypeId"] integerValue]==1)
                        {
                            if ([Cir_originalarry[i][@"UPC"] integerValue]==[Cir_data[j][@"UPC"] integerValue])
                            {
                                
                                NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:j]];
                                [Cir_originalarry replaceObjectAtIndex:i withObject:Cir_Dicts];
                            }
                        }
                      else
                      {
                          if ([Cir_originalarry[i][@"CouponID"] integerValue]==[Cir_data[j][@"CouponID"] integerValue])
                          {
                              NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:j]];
                              [Cir_originalarry replaceObjectAtIndex:i withObject:Cir_Dicts];
                          }
                      }
                      
                   }
            }
         
            
            
            Cir_data=[[NSMutableArray alloc] init];
            [Cir_data removeAllObjects];
              [Cir_data addObjectsFromArray:Cir_originalarry];
              [self.delegate function:Cir_data];
            
            for (int j=0; j<[Cir_data count]; j++)
            {
               
//                    if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]!=2)
                   if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]==1)
                    {
                            [productList  addObject:Cir_data[j]];
                        
                    }
                      else if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]==3)
                     {
                         
                         
                                if (PersonalAddcancel==0)
                                {
                                    PersonalAddcancel=1;
                                    PersonalAddFirst=0;
                                    [productList addObjectsFromArray:PersonalAddarry];
                                    [productList  addObject:Cir_data[j]];
                                }
                                else
                                {
                                   [productList  addObject:Cir_data[j]];
                                }
                        
                        
                        
                    }
                    else
                    {
                        if ([Cir_data[j][@"TileNumber"]integerValue]==999)
                        {
                            if (addints==0)
                             {
                                addints=1;
                                [productList  addObjectsFromArray:additonalofrray];
                                [productList  addObject:Cir_data[j]];
                             }
                             else
                              {
                                [productList  addObject:Cir_data[j]];
                              }
                            
                        }
                        else
                        {
                            [productList  addObject:Cir_data[j]];
                        }
                    }
                
                
            }
            [Cir_originalarry removeAllObjects];
            [self GetCatList];
            
            
    }
         [_collectionSingletable reloadData];
         [_collectionDoubletable reloadData];
         [_Filtercattable reloadData];
         [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"ischeckclear"];
         [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
  

    
}
-(void)cancelSearching
{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Filtersdata"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
    [self cancelSearchingcheckdate];
    ischeckclear=@"NO";
}

-(void)getsearchingdatacheckeddate:(NSString*)searchtexting
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Filtersdata"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
  
    [[NSUserDefaults standardUserDefaults] setObject:@""  forKey:@"Filtersdataarry"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    [SVProgressHUD show];
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
       
       
        [SVProgressHUD show];
       NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                  };
        NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
        NSArray*StoreId=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"StoreId"];
        NSURLComponents *components = [NSURLComponents componentsWithString:SEARCHING_URL];
        NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"memberid" value:arra[0]];
        NSURLQueryItem *device = [NSURLQueryItem queryItemWithName:@"Plateform" value:@"2"];
        NSURLQueryItem *Storeid =[NSURLQueryItem queryItemWithName:@"StoreId" value:StoreId[0]];
        NSURLQueryItem *txtsearching =[NSURLQueryItem queryItemWithName:@"SearchText" value:searchtexting];
        components.queryItems = @[LoyaltyCardNumber,device,Storeid,txtsearching];
        NSURL *url = components.URL;
        NSLog(@"url:%@",url);
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];
        [request setAllHTTPHeaderFields:headers];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        NSURLResponse*response=nil;
        NSError*err=nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        if (responseData!=nil)
        {
            
                NSMutableArray *jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
            NSMutableDictionary*ditc=(NSMutableDictionary*)jsonObject;
          Cir_originalarry=[[NSMutableArray alloc] init];
             searchingarraydata=[[NSMutableArray alloc] init];
            if (ischeckvoice==1)
            { if (![_searchtxt.text isEqualToString:@""])
            { if(audioEngine.isRunning)
            { [self stopfun];
            }
                
            }
            }
            
           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               
               if ([jsonObject count]!=0)
               {
                   self->productList=[[NSMutableArray alloc] init];
                   self->Cir_originalarry=[[NSMutableArray alloc] init];
                      [self->productList removeAllObjects];
                     [self->Cir_originalarry removeAllObjects];
                   
                   [self->Cir_originalarry addObjectsFromArray:self->Cir_data];
                   
                   self->Cir_data=[[NSMutableArray alloc] init];
                      [self->Cir_data removeAllObjects];
                      NSLog(@"jsonObject:%d",jsonObject.count);
                      for (int i=0; i<[jsonObject count]; i++)
                       {
                            if (i==0)
                            {
                                NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:jsonObject[i]];
                                [dict setObject:@"10" forKey:@"CouponID"];
                                [self->arraydata addObject:dict];
                                
                            }
                            NSMutableDictionary*dicts=[[NSMutableDictionary alloc] initWithDictionary:jsonObject[i]];
                            [self->productList addObject:dicts];
                         
                           
                        }
              
                   self->primaryoffertypeid=0;
                   [self->Cir_data addObjectsFromArray:self->productList];
                   [self.delegate function:self->Cir_data];
                      [self GetCatList];
                   NSLog(@"Cir_originalarry:%d",self->Cir_data.count);
                  
                  
                   
               [[NSUserDefaults standardUserDefaults] setObject:@"isSearching" forKey:@"isSearching"];
               [[NSUserDefaults standardUserDefaults] synchronize];
                   
           }
               
               
             if (self->productList.count<6)
                {
                      self->footerstr=@"footerstr";
                      [self->productList addObjectsFromArray:self->arraydata];
                  
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"footerstr" forKey:@"footerstr"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
             
               
               
                 dispatch_async(dispatch_get_main_queue(), ^{
                 [SVProgressHUD dismissWithDelay:1.0];
                     [self->_collectionSingletable reloadData];
                     [self->_collectionDoubletable reloadData];
                      [self->_Filtercattable reloadData];
                     if (jsonObject.count==0)
                     {
                         self->_collectionSingletable.hidden=YES;
                         self->_collectionDoubletable.hidden=YES;
                         self->_Deafultpopupview.hidden=NO;
                         self->_Deafultpopupviewcolor.hidden=NO;
                         self->_nothingtextlab.text=[NSString stringWithFormat:@"Sorry, your search for '[ %@ ]' did not return any result in your personal Ad.Currently we don't have any deals, coupons, sales price items matching your search. Our stores still might carry it and if we do its at the right price. \nYou may also:Check for typos. \nBe more general(e.g. 'potatoes' instead of bag of 'potatoes')",searchtexting];
                         [Validation zoomIn:self->_Deafultpopupview];
                         [self.delegate showbolerview];
                     }
                  
                 });
               
           });
      
            
    }
  
    }
    
    
}

-(void)GetSearchingList:(UITextField*)searchtexting
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
    [self getsearchingdatacheckeddate:searchtexting.text];
    
   
}

- (void)viewDidLoad
{
      [super viewDidLoad];
    

    
      refeshdata=0;
     [self tableHideShow];
     _searchtxt.delegate=self;
      [Validation  setRoundView:self.searchView borderWidth:0 borderColor:nil radius:13];
//     _searchView.backgroundColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
     _searchView.backgroundColor=[UIColor lightTextColor];
      [Validation addShadowToView:_searchView];
      [Validation addShadowToView:_headerView];
  //refresh 1
      UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
      [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
      [_collectionSingletable addSubview:refreshControl];
      UIRefreshControl *refreshControle = [[UIRefreshControl alloc] init];
      [refreshControle addTarget:self action:@selector(handleRefreshe:) forControlEvents:UIControlEventValueChanged];
      [_collectionDoubletable addSubview:refreshControle];
    
    
      _Filtertable.tintColor =  [UIColor redColor];
      _Filtercattable.tintColor =  [UIColor redColor];
    
       pheight=_collectionSingletable.layer.frame.size.height;
      _BorderLab.text=@"My Personal Ad";
      _BorderLab.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
      _cancelView.hidden=YES;
      [self.Filtertable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
      [self.sortbyTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
       [self.Filtercattable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
     [Validation setRoundView:self.cancelView borderWidth:0 borderColor:nil radius:_cancelView.layer.frame.size.height/2];
     [Validation addShadowToView:self.Deafultpopupview];
     //tapGautures
      [self Circularlist];
      UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapped)];
      tapScroll.cancelsTouchesInView = NO;
      [self.collectionSingletable addGestureRecognizer:tapScroll];
       memberid=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
      selectCatidArray=[[NSMutableArray alloc] init];
    MoreCoupnseIdChangearray=[[NSMutableArray alloc] init];
      _audioRecorView.hidden=YES;
      [Validation addShadowToView:_audioRecorView];
     [Validation addShadowToView:_PersonalAddView];
    _PersonalAddView.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    _Applesview.hidden=YES;
    _Deafultpopupview.hidden=YES;
    _Deafultpopupviewcolor.hidden=YES;
    [_btn1 setTitle:@"Return to Personal Ad" forState:UIControlStateNormal];
    [_btn2 setTitle:@"Try Another search" forState:UIControlStateNormal];
    
    _sortbyTable.tintColor =  [UIColor redColor];
    _btn1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _btn1.titleLabel.numberOfLines = 2;
    _btn2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _btn2.titleLabel.numberOfLines = 2;
  
    [self sortBy];
    
     [Validation setRoundView:self.Deafultpopupview borderWidth:0 borderColor:nil radius:5];
     [Validation setRoundView:self.btn1 borderWidth:0 borderColor:nil radius:5];
    [Validation setRoundView:self.btn2 borderWidth:0 borderColor:nil radius:5];
    _btn1.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    _btn2.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
      cattypedata=[[NSMutableArray alloc] init];
     isMoreCouponsefirst=0;
    [self.collectionSingletable registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"SingleViewCollectionCell"];
    UINib *cellNib = [UINib nibWithNibName:@"SingleViewCollectionCell" bundle:[NSBundle bundleForClass:SingleViewCollectionCell.class]];
    [self.collectionSingletable registerNib:cellNib forCellWithReuseIdentifier:@"SingleViewCollectionCell"];
    
    [self.collectionSingletable registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FooterCell"];
    UINib *fotter = [UINib nibWithNibName:@"FooterCell" bundle:[NSBundle bundleForClass:FooterCell.class]];
    [self.collectionSingletable registerNib:fotter forCellWithReuseIdentifier:@"FooterCell"];
    
    [self.collectionSingletable registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AdditionalOffers"];
    UINib *additionaloffers = [UINib nibWithNibName:@"AdditionalOffers" bundle:[NSBundle bundleForClass:AdditionalOffers.class]];
    [self.collectionSingletable registerNib:additionaloffers forCellWithReuseIdentifier:@"AdditionalOffers"];
    
    [self.collectionDoubletable registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"DoubleViewCollectionCell"];
    UINib *cellNibdouble = [UINib nibWithNibName:@"DoubleViewCollectionCell" bundle:[NSBundle bundleForClass:DoubleViewCollectionCell.class]];
    [self.collectionDoubletable registerNib:cellNibdouble forCellWithReuseIdentifier:@"DoubleViewCollectionCell"];
   // [self.collectionDoubletable registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"DoubleViewCollectionCell"];
   // [self.collectionDoubletable registerNib:[UINib nibWithNibName:@"DoubleViewCollectionCell" bundle:[NSBundle bundleForClass:DoubleViewCollectionCell.class]] forCellWithReuseIdentifier:@"DoubleViewCollectionCell"];
    
    [self.collectionDoubletable registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FooterCell"];
    UINib *fotterr = [UINib nibWithNibName:@"FooterCell" bundle:[NSBundle bundleForClass:FooterCell.class]];
    [self.collectionDoubletable registerNib:fotterr forCellWithReuseIdentifier:@"FooterCell"];
    
    [self.collectionDoubletable registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AdditionalOffers"];
    UINib *additionalOfferss = [UINib nibWithNibName:@"AdditionalOffers" bundle:[NSBundle bundleForClass:AdditionalOffers.class]];
    [self.collectionDoubletable registerNib:additionalOfferss forCellWithReuseIdentifier:@"AdditionalOffers"];
    
    _searchbtn.hidden=YES;
    getBackuparray=[[[NSMutableArray alloc] init] mutableCopy];
    additonalofrray=[[[NSMutableArray alloc] init] mutableCopy];
    
     categoriesaddarray=[[NSMutableArray alloc] init];
     ischeckedarray=[[NSMutableArray alloc] init];
     arraydata=[[NSMutableArray alloc] init];
   
    [self sortbyviewhide];
    _HeaderTitleFilterCatclass.text=@"Filter By Catogories";
    _HeaderTitleFilterclass.text=@"Filter By Offers";
    
    
    
    [Validation addShadowToView:self.filterclassheaderView];
    [Validation addShadowToView:self.filterCatclassheaderView];
    [Validation addShadowToView:self.sortbyclassheaderView];
    [self shoppinglistcount];
    

      [self Filterviewclasshide];
     _filtercatclassview.hidden=YES;
      [self GetfilterByOffers];

}
-(void)GetfilterByOffers
{
        _HeaderTitleFilterclass.text=@"Filter By Offers";
        offerFilterarrayObj=[[NSMutableArray alloc] init];
        {
            NSMutableDictionary*CatDict=[[NSMutableDictionary alloc] init];
            [CatDict setObject:@"All My Offers" forKey:@"Filers"];
            [offerFilterarrayObj addObject:CatDict];
            
        }
        {
            NSMutableDictionary*CatDict=[[NSMutableDictionary alloc] init];
            [CatDict setObject:@"My Personal Deals" forKey:@"Filers"];
            [offerFilterarrayObj addObject:CatDict];
            
        }
        {
            NSMutableDictionary*CatDict=[[NSMutableDictionary alloc] init];
            [CatDict setObject:@"Digital Coupons" forKey:@"Filers"];
            [offerFilterarrayObj addObject:CatDict];
            
        }
        {
            NSMutableDictionary*CatDict=[[NSMutableDictionary alloc] init];
            [CatDict setObject:@"Sale Items" forKey:@"Filers"];
            [offerFilterarrayObj addObject:CatDict];
            
        }
   
   
    
    
}
-(void)sortBy
{
    _HeaderTitleSortbyclass.text=@"Sort by";
    
    SortByarrayObj=[[NSMutableArray alloc] init];
    {
        NSMutableDictionary*CatDict=[[NSMutableDictionary alloc] init];
        [CatDict setObject:@"Recommended" forKey:@"sort"];
        [SortByarrayObj addObject:CatDict];
        
    }
    {
        NSMutableDictionary*CatDict=[[NSMutableDictionary alloc] init];
        [CatDict setObject:@"Savings" forKey:@"sort"];
        [SortByarrayObj addObject:CatDict];
        
    }
    {
        NSMutableDictionary*CatDict=[[NSMutableDictionary alloc] init];
        [CatDict setObject:@"Offers Type" forKey:@"sort"];
        [SortByarrayObj addObject:CatDict];
        
    }
   
    
    
}
-(void)shoppinglistcount
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getshopinglistcount];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate getShoppingListCountcircular:self->getShoppinglistarray];
        });
    });
}
-(IBAction)cancelsearch:(id)sender
{
     _audioRecorView.hidden=YES;
     _cancelView.hidden=YES;
     if(audioEngine.isRunning) {
        [self stopfun];
    }
}
-(IBAction)Menubtn:(id)sender
{
    //issoppingadd=false;
    ApiHendlerClass*dissmisswindow=[ApiHendlerClass new];
    [dissmisswindow dissmisscontroller];
}
-(void)speackRe
{
    
     NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:@"AudioRecog" withExtension:@"gif"];
     self.timeimg.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
     self.timeimg.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    
     speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
     speechRecognizer.delegate = self;
     [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status)
     {
         switch (status)
         {
             case SFSpeechRecognizerAuthorizationStatusAuthorized:
                // NSLog(@"Authorized");
                 break;
             case SFSpeechRecognizerAuthorizationStatusDenied:
                // NSLog(@"Denied");
                 break;
             case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                // NSLog(@"Not Determined");
                 break;
             case SFSpeechRecognizerAuthorizationStatusRestricted:
                // NSLog(@"Restricted");
                 break;
             default:
                 break;
         }
     }];
}
-(void)tableHideShow
{
    if (number==1)
    {
        _collectionSingletable.hidden=NO;
        _collectionDoubletable.hidden=YES;
    }
    else
    {
        _collectionSingletable.hidden=YES;
        _collectionDoubletable.hidden=NO;
        
       
    }
}
-(void)Circularlist
{
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
         [self GetCircularofferlist];
         [self GetCatList];
         dispatch_async(dispatch_get_main_queue(), ^{
            [self->_collectionSingletable reloadData];
            [self->_collectionDoubletable reloadData];
             [self->_Filtercattable reloadData];
            [self speackRe];
            [self.delegate getShoppingListCountcircular:self->getShoppinglistarray];
      });
   });
}
-(void)stopfun
{  _audioRecorView.hidden=YES;
    [audioEngine stop];
    [recognitionRequest endAudio];
    recognitionTask=nil;
    recognitionRequest = nil;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
     if (collectionView==_collectionSingletable)
     {
                 if ([footerstr isEqualToString:@"footerstr"])
                 {
                     
                     if (productList.count<7)
                     {
                         if (indexPath.row+2==productList.count+1)
                         {
                             return CGSizeMake(CGRectGetWidth(collectionView.frame),110);
                         }
                         
                     }
                     
                 }
         
         
                     if ([productList[indexPath.row][@"PrimaryOfferTypeId"]integerValue]==2)
                     {
                         if ([productList[indexPath.row][@"TileNumber"]integerValue]==999)
                         {
                             if (isMoreCouponsefirst==0)
                             {
                                 isMoreCouponsefirst=[productList[indexPath.row][@"CouponID"] integerValue];
                                 return CGSizeMake(CGRectGetWidth(collectionView.frame),40);
                             }
                             else if (isMoreCouponsefirst==[productList[indexPath.row][@"CouponID"] integerValue])
                             {
                                 isMoreCouponsefirst=[productList[indexPath.row][@"CouponID"] integerValue];
                                 return CGSizeMake(CGRectGetWidth(collectionView.frame),40);
                             }
                             else
                             {
                                 return CGSizeMake(CGRectGetWidth(collectionView.frame),500);
                             }
                             
                         }
                     }
                     else if ([productList[indexPath.row][@"PrimaryOfferTypeId"]integerValue]==3)
                     {
                         if (PersonalAddFirst==0)
                         {
                             if ([productList[indexPath.row][@"CouponID"] integerValue]==1)
                             {
                                 PersonalAddFirst=[productList[indexPath.row][@"CouponID"] integerValue];
                                 return CGSizeMake(CGRectGetWidth(collectionView.frame),40);
                             }
                        }
                         else if (PersonalAddFirst==[productList[indexPath.row][@"CouponID"] integerValue])
                         {
                             PersonalAddFirst=[productList[indexPath.row][@"CouponID"] integerValue];
                             return CGSizeMake(CGRectGetWidth(collectionView.frame),40);
                         }
                         else{
                            return CGSizeMake(CGRectGetWidth(collectionView.frame),500);
                         }
                     }
         
         
         
         
         
         
         
           return CGSizeMake(CGRectGetWidth(collectionView.frame),500);
         
         
     }
    else
    {
        
        
        //double row
                                        if ([footerstr isEqualToString:@"footerstr"])
                                        {
                                            
                                            if (productList.count<7)
                                            {
                                                if (indexPath.row+2==productList.count+1)
                                                {
                                                    return CGSizeMake(CGRectGetWidth(collectionView.frame),110);
                                                }
                                            }
                                            
                                        }
        
        
        
        
                                        if ([productList[indexPath.row][@"PrimaryOfferTypeId"]integerValue]==2)
                                        {
                                            if ([productList[indexPath.row][@"TileNumber"]integerValue]==999)
                                            {
                                                if (isMoreCouponsefirst==0)
                                                { isMoreCouponsefirst=[productList[indexPath.row][@"CouponID"] integerValue];
                                                    return CGSizeMake(CGRectGetWidth(collectionView.frame),40);
                                                }
                                                else if (isMoreCouponsefirst==[productList[indexPath.row][@"CouponID"] integerValue])// && addi==0)
                                                { isMoreCouponsefirst=[productList[indexPath.row][@"CouponID"] integerValue];
                                                    return CGSizeMake(CGRectGetWidth(collectionView.frame),40);
                                                }
                                                else
                                                { return [self sizecollection:collectionView];
                                                }
                                                
                                            }
                                        }
        else if ([productList[indexPath.row][@"PrimaryOfferTypeId"]integerValue]==3)
        {
            
            
            if (PersonalAddFirst==0)
            {
                            if ([productList[indexPath.row][@"CouponID"] integerValue]==1)
                            {
                                 PersonalAddFirst=[productList[indexPath.row][@"CouponID"] integerValue];
                                 return CGSizeMake(CGRectGetWidth(collectionView.frame),40);
                            }
            }
            else if (PersonalAddFirst==[productList[indexPath.row][@"CouponID"] integerValue])
            {
                PersonalAddFirst=[productList[indexPath.row][@"CouponID"] integerValue];
                return CGSizeMake(CGRectGetWidth(collectionView.frame),40);
            }
            else{
                return [self sizecollection:collectionView];
            }
      }
        
     return [self sizecollection:collectionView];
        
        
    }
      return CGSizeMake(0,0);
  
}
-(CGSize)sizecollection:(UICollectionView*)collectionView
{
    if(isiPhone5s)
    {
        return CGSizeMake(155,375);
    }
    else if(isiPhone6 ||isiPhoneX)
    {
        return CGSizeMake(182,375);
    }
    else if(isiPhone8Plus)
    {
        return CGSizeMake(200,375);
    }
    else if(isiPhoneXsMax)
    {
       return CGSizeMake((CGRectGetWidth(collectionView.frame)/2)-5,375);
    }
    else if(isiPad ||isiPadSmall)
    {
        return CGSizeMake(185,375);
    }
    else{
        return CGSizeMake(155,375);
    }
    
}
- (void) tapped
{
   [self.view endEditing:YES];
   [self stopfun];
    [self.delegate hidentabbar];
}

- (void)handleRefresh:(UIRefreshControl *)sender
{
       [sender endRefreshing];
    [_collectionDoubletable reloadData];
    [_collectionSingletable reloadData];
      // [self Circular];
    
}
- (void)handleRefreshe:(UIRefreshControl *)sender
{
      [sender endRefreshing];
    [_collectionDoubletable reloadData];
    [_collectionSingletable reloadData];
      // [self Circular];
    
}
-(IBAction)AudioRecording:(id)sender
{
      _searchtxt.text=@"";
       audioEngine=[[AVAudioEngine alloc ] init];
      if(audioEngine.isRunning) {
         [self stopfun];
      }
     else{
         
        _cancelView.hidden=NO;
          ischeckvoice=1;
         _audioRecorView.hidden=NO;
          [Validation zoomIn:_audioRecorView];
          [self startListening:_searchtxt];
    }

}

- (void)startListening:(UITextField*)tiltletext
{
   
    audioEngine = [[AVAudioEngine alloc] init];
    if (recognitionTask != nil)
    {
        [recognitionTask cancel];
         recognitionTask = nil;
    }else
    {
         NSError *error;
         AVAudioSession *audioSession = [AVAudioSession sharedInstance];
         [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
         [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
         recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
         AVAudioInputNode *inputNode = audioEngine.inputNode;
        recognitionRequest.shouldReportPartialResults = YES;
         recognitionTask = [speechRecognizer recognitionTaskWithRequest:recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error)
                   {BOOL isFinal = NO;
                      if (result)
                       {isFinal = !result.isFinal;
                           self->_titlelab.text=result.bestTranscription.formattedString;
                       tiltletext.text=result.bestTranscription.formattedString;
                           NSString*str=result.bestTranscription.formattedString;
                       NSString *trimmed = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                              self->_searchtxt.text=trimmed;
       }
                      if (error)
                       { [self->audioEngine stop];
                             [inputNode removeTapOnBus:0];
                             self->recognitionRequest = nil;
                             self->recognitionTask = nil;
                       }

                  }];
  // Sets the recording format
        AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
        [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [self->recognitionRequest appendAudioPCMBuffer:buffer];
        }];
    // Starts the audio engine, i.e. it starts listening.
            [audioEngine prepare];
            [audioEngine startAndReturnError:&error];
            _titlelab.text = @"Say something, I'm listening!";
    }
    
}
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available {
    
       _searchtxt.text=@"";
        [self startListening:_searchtxt];
 
}
-(IBAction)donebtn:(id)sender
{
    NSString*str=_searchtxt.text;
    if (![str isEqualToString:@""])
    {
            [self stopfun];
            _cancelView.hidden=YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               [SVProgressHUD show];
             [self GetSearchingList:self->_searchtxt];
        });
   }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    if (textField == self.searchtxt)
    {
         [textField resignFirstResponder];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [SVProgressHUD show];
            [self GetSearchingList:self->_searchtxt];
        });
     
    }
   return YES;
}
-(IBAction)searchbtn:(UIButton*)sender
{
    
   if (!([_searchtxt.text length]==0))
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [SVProgressHUD show];
            [self GetSearchingList:self->_searchtxt];
        });
    }
   
}
-(IBAction)doubletable:(id)sender
{
    if (number==1) {
           _collectionSingletable.hidden=YES;
           _collectionDoubletable.hidden=NO;
           number=2;
    }
    else {
         _collectionSingletable.hidden=NO;
         _collectionDoubletable.hidden=YES;
         number=1;

    }
 
}
-(IBAction)Filterbtn:(id)sender
{
//    _Filterview.hidden=NO;
    
}
-(IBAction)cleartxtbtn:(id)sender
{
    
    _searchtxt.text=@"";
    ischeckearraystr=@"";
    [self cancelSearching];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_collectionSingletable)
    {
     
          return [productList count];
      
    }
    else  if (collectionView==_collectionDoubletable)
    {
     
          return [productList count];
      
    }
    
    
    return 0;
}
NSInteger check2;
AdditionalOffers*cell1;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    if (collectionView==_collectionDoubletable)
    {
     DoubleViewCollectionCell *cell=(DoubleViewCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"DoubleViewCollectionCell" forIndexPath:indexPath];
     
                                if ([productList[indexPath.row][@"PrimaryOfferTypeId"]integerValue]==2)
                                {
                                    if ([productList[indexPath.row][@"TileNumber"]integerValue]==999)
                                                    {
                                                        
                                                                    if (isMoreCouponsefirst==0)
                                                                    {
                                                                        
                                                                        cell1=(AdditionalOffers*)[collectionView dequeueReusableCellWithReuseIdentifier:@"AdditionalOffers" forIndexPath:indexPath];
                                                                        isMoreCouponsefirst=[productList[indexPath.row][@"CouponID"] integerValue];
                                                                        cell1.title.hidden=NO;
                                                                        cell1.storeviews.hidden=YES;
                                                                         cell1.PAtitle.hidden=YES;
                                                                        return cell1;
                                                                    }
                                                                    else if (isMoreCouponsefirst==[productList[indexPath.row][@"CouponID"] integerValue])// && addi==1 && check2==2)
                                                                    {
                                                                        
                                                                        cell1=(AdditionalOffers*)[collectionView dequeueReusableCellWithReuseIdentifier:@"AdditionalOffers" forIndexPath:indexPath];
                                                                        isMoreCouponsefirst=[productList[indexPath.row][@"CouponID"] integerValue];
                                                                        cell1.title.hidden=NO;
                                                                        cell1.storeviews.hidden=YES;
                                                                        cell1.PAtitle.hidden=YES;
                                                                        return cell1;
                                                                    }
                                                        
                                                    }
                                    
                                }
                                else if ([productList[indexPath.row][@"PrimaryOfferTypeId"]integerValue]==3)
                                {
                                                 AdditionalOffers*cell1;
                                                if (PersonalAddFirst==0)
                                                {
                                                    if ([productList[indexPath.row][@"CouponID"] integerValue]==1)
                                                    {
                                                        cell1=(AdditionalOffers*)[collectionView dequeueReusableCellWithReuseIdentifier:@"AdditionalOffers" forIndexPath:indexPath];
                                                        PersonalAddFirst=[productList[indexPath.row][@"CouponID"] integerValue];
                                                        cell1.title.hidden=YES;
                                                             cell1.storeviews.hidden=NO;
                                                        cell1.PAtitle.hidden=NO;
                                                        return cell1;
                                                    }
                                              }
                                                else if (PersonalAddFirst==[productList[indexPath.row][@"CouponID"] integerValue])
                                                {
                                                    cell1=(AdditionalOffers*)[collectionView dequeueReusableCellWithReuseIdentifier:@"AdditionalOffers" forIndexPath:indexPath];
                                                    PersonalAddFirst=[productList[indexPath.row][@"CouponID"] integerValue];
                                                    cell1.title.hidden=YES;
                                                       cell1.storeviews.hidden=NO;
                                                    cell1.PAtitle.hidden=NO;
                                                    return cell1;
                                                }
                                    
                                }
        
        
       
        
        
         NSMutableDictionary *celldata =(NSMutableDictionary*)[productList objectAtIndex:indexPath.row];
//          NSLog(@"productList:%@",[productList objectAtIndex:indexPath.row]);
//          NSLog(@"celldata:%@",celldata);
         [self addProductlistArraydoublerow:celldata cell:cell index:indexPath.row];
         if ([footerstr isEqualToString:@"footerstr"])
         {
            
                    if (productList.count<7)
                    {
                        if (indexPath.row+2==productList.count+1)
                        {
                            FooterCell*cell=(FooterCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"FooterCell" forIndexPath:indexPath];
                            cell.titlelab.text=[NSString stringWithFormat:@"We are only showing '[%@]' with a Deal, Coupon or Sale Price. Our stores still might carry it and if we do its at the right price. ",_searchtxt.text];
                            [cell celldata:self index:indexPath.row];
                            return cell;
                        }
                        
                    }
        }
        return cell;
        
    }
    else  if(collectionView==_collectionSingletable)
    {
     
        SingleViewCollectionCell *cell=(SingleViewCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"SingleViewCollectionCell" forIndexPath:indexPath];
        if ([productList[indexPath.row][@"PrimaryOfferTypeId"]integerValue]==2)
        {
            if ([productList[indexPath.row][@"TileNumber"]integerValue]==999)
            {
                
                        AdditionalOffers*cell1=(AdditionalOffers*)[collectionView dequeueReusableCellWithReuseIdentifier:@"AdditionalOffers" forIndexPath:indexPath];
                        if (isMoreCouponsefirst==0)
                        {
                            cell1=(AdditionalOffers*)[collectionView dequeueReusableCellWithReuseIdentifier:@"AdditionalOffers" forIndexPath:indexPath];
                            isMoreCouponsefirst=[productList[indexPath.row][@"CouponID"] integerValue];
                            cell1.title.hidden=NO;
                                  cell1.storeviews.hidden=YES;
                            cell1.PAtitle.hidden=YES;
                            return cell1;
                        }
                        else if (isMoreCouponsefirst==[productList[indexPath.row][@"CouponID"] integerValue])
                        {
                            cell1=(AdditionalOffers*)[collectionView dequeueReusableCellWithReuseIdentifier:@"AdditionalOffers" forIndexPath:indexPath];
                            isMoreCouponsefirst=[productList[indexPath.row][@"CouponID"] integerValue];
                            cell1.title.hidden=NO;
                                       cell1.storeviews.hidden=YES;
                            cell1.PAtitle.hidden=YES;
                            return cell1;
                        }
                
            }
        }
        else if ([productList[indexPath.row][@"PrimaryOfferTypeId"]integerValue]==3)
        {
             AdditionalOffers*cell1;
             if (PersonalAddFirst==0)
             {
                if ([productList[indexPath.row][@"CouponID"] integerValue]==1)
                {
                    cell1=(AdditionalOffers*)[collectionView dequeueReusableCellWithReuseIdentifier:@"AdditionalOffers" forIndexPath:indexPath];
                    PersonalAddFirst=[productList[indexPath.row][@"CouponID"] integerValue];
                    cell1.title.hidden=YES;
                               cell1.storeviews.hidden=NO;
                    cell1.PAtitle.hidden=NO;
                    return cell1;
                }
            }
            else if (PersonalAddFirst==[productList[indexPath.row][@"CouponID"] integerValue])
            {
                cell1=(AdditionalOffers*)[collectionView dequeueReusableCellWithReuseIdentifier:@"AdditionalOffers" forIndexPath:indexPath];
                PersonalAddFirst=[productList[indexPath.row][@"CouponID"] integerValue];
                cell1.title.hidden=YES;
                cell1.storeviews.hidden=NO;
                cell1.PAtitle.hidden=NO;
                return cell1;
            }
            
        }
        
        
        
        
        
        NSMutableDictionary *celldata = [productList objectAtIndex:indexPath.row];
        [self addProductlistArray:celldata cell:cell index:indexPath.row];
        if ([footerstr isEqualToString:@"footerstr"])
        {
            
            if (productList.count<7)
            {
                
                if (indexPath.row+2==productList.count+1)
                {
                    FooterCell*cell=(FooterCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"FooterCell" forIndexPath:indexPath];
                    cell.titlelab.text=[NSString stringWithFormat:@"We are only showing '[%@]' with a Deal, Coupon or Sale Price. Our stores still might carry it and if we do its at the right price. ",_searchtxt.text];
                    [cell celldata:self index:indexPath.row];
                    return cell;
                }
                
            }
        }
        selectallindexx=indexPath.row;
       return cell;
        
    }
        
    return nil;
 
}

-(void)updatedata:(NSInteger)index
{
    
     selectallindex=index;
    
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
        ClickType=@"2";
        post=[NSString stringWithFormat:@"UPCCode=%@&CategoryID=%@&SalePrice=%@&PrimaryOfferTypeId=%@&OfferDetailId=%@&PersonalCircularID=%@&ExpirationDate=%@&ClientID=%@&PackagingSize=%@&DisplayPrice=%@&RelevantUPC=%@&Description=%@&SpecialInformation=%@&CouponID=%@&MemberID=%@&DeviceId=%@&OPMOfferID=%@&iPositionID=%@&PageID=%@&ClickType=%@&Savings=%@&AdPrice=%@&RegPrice=%@",productList[index][@"UPC"],productList[index][@"CategoryID"],productList[index][@"FinalPrice"],productList[index][@"PrimaryOfferTypeId"],productList[index][@"OfferDetailId"],productList[index][@"PersonalCircularID"],productList[index][@"ValidityEndDate"],@"1",productList[index][@"PackagingSize"],productList[index][@"DisplayPrice"],productList[index][@"RelevantUPC"],productList[index][@"Description"],productList[index][@"SpecialInformation"],productList[index][@"CouponID"],memberid[0],@"1",productList[index][@"PricingMasterID"],productList[index][@"TileNumber"],productList[index][@"PageID"],ClickType,productList[index][@"Savings"],productList[index][@"AdPrice"],productList[index][@"RegularPrice"]];
        NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                                   @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                   };
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *jsonString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ACTIVATE_URL]];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [request setAllHTTPHeaderFields:headers];
        NSURLResponse*response=nil;
        NSError*err=nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        if (responseData!=nil)
        {NSMutableDictionary *jsonresonse = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
           
            if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
            {
                   NSLog(@"jsonresonse:%@",jsonresonse);
             
                   NSMutableDictionary *strDict = [[NSMutableDictionary alloc] initWithDictionary:[[productList objectAtIndex:index] mutableCopy]];
                  // NSMutableDictionary *strDicts = [[NSMutableDictionary alloc] init];
                if ([strDict[@"PrimaryOfferTypeId"] integerValue]==3 ||[strDict[@"PrimaryOfferTypeId"] integerValue]==2)
                {
                    
                    for (int i=0; i<[Cir_data count]; i++)
                    {
                        if ([strDict[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue] ||[strDict[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                        {
                             if ([strDict[@"CouponID"] integerValue]==[Cir_data[i][@"CouponID"] integerValue])
                             {
                           
                                 
                                     NSLog(@"CouponID:%d",[strDict[@"CouponID"] integerValue]);
                                     NSLog(@"Cir_data:%d",[Cir_data[i][@"CouponID"] integerValue]);
                                 
                                     NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                                     [Cir_Dicts setObject:@"1" forKey:@"ClickCount"];
                                     [Cir_Dicts setObject:@"1" forKey:@"ListCount"];
                                     [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                              }
                        }
                    }
                 
                    [strDict setObject:@"1" forKey:@"ClickCount"];
                    [strDict setObject:@"1" forKey:@"ListCount"];
                    // strDicts=strDict;
                    [productList replaceObjectAtIndex:index withObject:strDict];
                  
                  
                }
                else
                {
                    
                    for (int i=0; i<[Cir_data count]; i++)
                    {
                        if ([strDict[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                        {
                            if ([strDict[@"UPC"] integerValue]==[Cir_data[i][@"UPC"] integerValue])
                            {
                                NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                                [Cir_Dicts setObject:@"1" forKey:@"ListCount"];
                                [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                            }
                        }
                    }
                
                    [strDict setObject:@"1" forKey:@"ListCount"];
                    [productList replaceObjectAtIndex:index withObject:strDict];
                   
                }
             
                [self.delegate function:Cir_data];
              
            }
            
            
        }
        
    }
    
  

}


//+
-(void)addproduct:(NSInteger)index
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
        NSDictionary *headers = @{ @"Content-Type": @"application/json"
                                };
          NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
        NSString *upc;
        NSInteger count;
        NSString* quantity;
           NSMutableDictionary *strDict = [[NSMutableDictionary alloc] initWithDictionary:[productList objectAtIndex:index]];
           NSMutableDictionary *cir_dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:index]];
             upc =productList[index][@"UPC"];
             count=[productList[index][@"Quantity"] integerValue];
            if (count>0 || count==0)
             {
                   count++;
                   NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:strDict];
                   NSMutableDictionary*Cirdata=[[NSMutableDictionary alloc] initWithDictionary:cir_dicts];
                   [dict setObject:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"Quantity"];
                   [Cirdata setObject:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"Quantity"];
                   cir_dicts=Cirdata;
                   strDict=dict;
                     [productList replaceObjectAtIndex:index withObject:strDict];
                      [Cir_data replaceObjectAtIndex:index withObject:cir_dicts];
                      quantity=productList[index][@"Quantity"];
            }
            
       
         NSDictionary *profile = @{@"ShoppingListItems":@[@{@"UPC":upc,@"Quantity":quantity,@"DateAddedOn":@"12/7/2018 10:53:31 PM"}]};
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:profile options:0 error:NULL];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString*finaljson=[NSString stringWithFormat:@"'%@'",jsonString];
        //NSLog(@"finaljson %@",finaljson);
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
           // NSLog(@"jsonresonse:%@",jsonresonse);
            if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
            {
                  [_collectionSingletable reloadData];
                  [_collectionDoubletable reloadData];
            }
        }
    }
}
-(void)subproduct:(NSInteger)index
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
    
        NSString *upc;
        NSInteger count;
        NSString* quantity;
        NSMutableDictionary *strDict;
        if ([_filtertype isEqualToString:@"Catogories"] || [_filtertype isEqualToString:@"Filters"])
        {
            strDict = [[NSMutableDictionary alloc] initWithDictionary:[selectCatidArray objectAtIndex:index]];
            upc =selectCatidArray[index][@"UPC"];
            count=[selectCatidArray[index][@"Quantity"] integerValue];
             if (count>1)
            {
                count--;
                NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:strDict];
                [dict setObject:[NSString stringWithFormat:@"%ld",count] forKey:@"Quantity"];
                strDict=dict;
                [selectCatidArray replaceObjectAtIndex:index withObject:strDict];
                quantity=selectCatidArray[index][@"Quantity"];
                [self subproducts:upc quantity:quantity];
            }
        }
        else
        {
            strDict = [[NSMutableDictionary alloc] initWithDictionary:[productList objectAtIndex:index]];
            upc =productList[index][@"UPC"];
            count=[productList[index][@"Quantity"] integerValue];
             if (count>1)
            {
                count--;
                NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:strDict];
                [dict setObject:[NSString stringWithFormat:@"%ld",count] forKey:@"Quantity"];
                strDict=dict;
                [productList replaceObjectAtIndex:index withObject:strDict];
                quantity=productList[index][@"Quantity"];
                [self subproducts:upc quantity:quantity];
              }
      }
  }
    
}
-(void)SubRelatedCountToatalQty:(NSMutableDictionary*)ReData
{
    
    
         NSInteger count;
         NSInteger Quantitycount;
         NSString*UPCRelated=[NSString stringWithFormat:@"%@",ReData[@"UPC"]];
         NSString*UPCRelatedOfferCode=[NSString stringWithFormat:@"%@",ReData[@"OfferCode"]];
        // NSMutableDictionary*strDict = [[NSMutableDictionary alloc] initWithDictionary:[productList objectAtIndex:SelectedProductIndex]];
if([ReData[@"PrimaryOfferTypeId"] integerValue]==3 || [ReData[@"PrimaryOfferTypeId"] integerValue]==2)
     {
       for (int i=0; i<[Cir_data count]; i++)
       {
           if ([ReData[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue] ||[ReData[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
           {
               
               if ([ReData[@"CouponID"] integerValue]==[Cir_data[i][@"CouponID"] integerValue])
               {
                   count=[Cir_data[i][@"TotalQuantity"] integerValue];
                   if (count>0)
                   {
                       count--;
                   NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                   [Cir_Dicts setObject:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"TotalQuantity"];
                   [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                       
                   }
               }
           }
       }
                           
      
           for (int k=0;  k<[productList count];  k++)
           {
               if ([ReData[@"PrimaryOfferTypeId"] integerValue]==[productList[k][@"PrimaryOfferTypeId"] integerValue] ||[ReData[@"PrimaryOfferTypeId"] integerValue]==[productList[k][@"PrimaryOfferTypeId"] integerValue])
               {
                   
                   if ([ReData[@"CouponID"] integerValue]==[productList[k][@"CouponID"] integerValue])
                   {
                       count=[productList[k][@"TotalQuantity"] integerValue];
                       if (count>0)
                       {
                        count--;
                       NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[productList objectAtIndex:k]];
                       [Cir_Dicts setObject:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"TotalQuantity"];
                       [productList replaceObjectAtIndex:k withObject:Cir_Dicts];
                       
                           
                       NSIndexPath *indexPath = [NSIndexPath indexPathForRow:k inSection:0];
                       [_collectionSingletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                       [_collectionDoubletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                       }
                   }
               }
           }

        }
        else if([ReData[@"PrimaryOfferTypeId"] integerValue]==1)
        {
            
            
                      
                      
                      
                      
                      for (int i=0; i<[Cir_data count]; i++)
                      {
                          if ([ReData[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                          {
                              
                              if ([ReData[@"OfferCode"] integerValue]==[Cir_data[i][@"UPC"] integerValue] || [ReData[@"UPC"] integerValue]==[Cir_data[i][@"UPC"] integerValue])
                              {
                                  NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                                  [Cir_Dicts setObject:[NSString stringWithFormat:@"%ld",(long)Quantitycount] forKey:@"Quantity"];
                                  [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                              }
                          }
                      }
                      
                     
                      for (int k=0; k<[productList count]; k++)
                      {
                          if ([ReData[@"PrimaryOfferTypeId"] integerValue]==[productList[k][@"PrimaryOfferTypeId"] integerValue])
                          {
                              
                              if ([ReData[@"OfferCode"] integerValue]==[productList[k][@"UPC"] integerValue] || [ReData[@"UPC"] integerValue]==[productList[k][@"UPC"] integerValue])
                              {
                                 Quantitycount=[productList[k][@"Quantity"] integerValue];
                                  if (Quantitycount>0)
                                  {
                                    Quantitycount--;
                                    NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[productList objectAtIndex:k]];
                                    [Cir_Dicts setObject:[NSString stringWithFormat:@"%ld",(long)Quantitycount] forKey:@"Quantity"];
                                    [productList replaceObjectAtIndex:k withObject:Cir_Dicts];
                                      
                                      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:k inSection:0];
                                      [_collectionSingletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                                      [_collectionDoubletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                                  }
                              }
                          }
                      }
                      
                      
                      
                      
                      
                      
                      
                      
                  }
    
      
     [self.delegate function:Cir_data];
     [_collectionSingletable reloadData];
    [_collectionDoubletable reloadData];
 
}
-(void)AddRelatedCountToatalQty:(NSMutableDictionary*)ReData
{
    
    
             NSInteger count;
          //   NSInteger qtycount;
             NSInteger Quantitycount;
            // NSString*UPCRelated=[NSString stringWithFormat:@"%@",ReData[@"UPC"]];
            // NSString*UPCRelatedOfferCode=[NSString stringWithFormat:@"%@",ReData[@"OfferCode"]];
 
    
        if([ReData[@"PrimaryOfferTypeId"] integerValue]==3 || [ReData[@"PrimaryOfferTypeId"] integerValue]==2)
          {
         
                for (int i=0; i<[Cir_data count]; i++)
                  {
                      if ([ReData[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue] ||[ReData[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                      {
                          
                          if ([ReData[@"CouponID"] integerValue]==[Cir_data[i][@"CouponID"] integerValue])
                          {
                              count=[Cir_data[i][@"TotalQuantity"] integerValue];
                              if (count>0 || count==0)
                              {
                                  
                                  count++;
                                 NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                                 [Cir_Dicts setObject:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"TotalQuantity"];
                                 [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                              }
                          }
                      }
                  }
                  for (int k=0; k<[productList count]; k++)
                  {
                      if ([ReData[@"PrimaryOfferTypeId"] integerValue]==[productList[k][@"PrimaryOfferTypeId"] integerValue] ||[ReData[@"PrimaryOfferTypeId"] integerValue]==[productList[k][@"PrimaryOfferTypeId"] integerValue])
                      {
                          
                          if ([ReData[@"CouponID"] integerValue]==[productList[k][@"CouponID"] integerValue])
                          {
                                count=[productList[k][@"TotalQuantity"] integerValue];
                              
                              if (count>0 || count==0)
                              {
                                 count++;
                                NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[productList objectAtIndex:k]];
                               [Cir_Dicts setObject:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"TotalQuantity"];
                               [productList replaceObjectAtIndex:k withObject:Cir_Dicts];
                              }
                          }
                      }
                  }
               
          }
        else  if([ReData[@"PrimaryOfferTypeId"] integerValue]==1)
        {

                   for (int i=0; i<[Cir_data count]; i++)
                    {
                        if ([ReData[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                        {
                              if ([ReData[@"OfferCode"] integerValue]==[Cir_data[i][@"UPC"] integerValue] || [ReData[@"UPC"] integerValue]==[Cir_data[i][@"UPC"] integerValue])
                            {
                                Quantitycount=[Cir_data[i][@"Quantity"] integerValue];
                                if (Quantitycount>0 || Quantitycount==0)
                                {
                                Quantitycount++;
                                NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                                [Cir_Dicts setObject:[NSString stringWithFormat:@"%ld",(long)Quantitycount] forKey:@"Quantity"];
                                [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                                }
                            }
                        }
                    }


                    for (int k=0; k<[productList count]; k++)
                    {
                        if ([ReData[@"PrimaryOfferTypeId"] integerValue]==[productList[k][@"PrimaryOfferTypeId"] integerValue])
                        {
                          if ([ReData[@"OfferCode"] integerValue]==[productList[k][@"UPC"] integerValue] || [ReData[@"UPC"] integerValue]==[productList[k][@"UPC"] integerValue])
                            {

                                Quantitycount=[productList[k][@"Quantity"] integerValue];
                                if (Quantitycount>0 || Quantitycount==0)
                                {
                                    Quantitycount++;
                                    NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[productList objectAtIndex:k]];
                                    [Cir_Dicts setObject:[NSString stringWithFormat:@"%ld",(long)Quantitycount] forKey:@"Quantity"];
                                    [productList replaceObjectAtIndex:k withObject:Cir_Dicts];
                                }
                            }
                        }
                    }


        }
    
     
    [self.delegate function:Cir_data];
    [_collectionSingletable reloadData];
    [_collectionDoubletable reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectallindexx inSection:0];
    [_collectionSingletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    [_collectionDoubletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

-(void)subproducts:(NSString*)upc quantity:(NSString*)quantity
{
    NSDictionary *headers = @{ @"Content-Type": @"application/json"
                               };
    NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
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
     
        if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
        {
            [_collectionSingletable reloadData];
            [_collectionDoubletable reloadData];
        }
    }
    
}


-(void)Removeprouct:(NSInteger)index
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
        NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
        NSURLQueryItem *upc;
        if ([_filtertype isEqualToString:@"Catogories"] || [_filtertype isEqualToString:@"Filters"])
        {
            upc = [NSURLQueryItem queryItemWithName:@"upccode" value:selectCatidArray[index][@"UPC"]];
            
        }
        else
        {
            upc = [NSURLQueryItem queryItemWithName:@"upccode" value:productList[index][@"UPC"]];
        }
       NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                                   @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                   };
        NSURLComponents *components = [NSURLComponents componentsWithString:REMOVE_URL];
        NSURLQueryItem *memberid = [NSURLQueryItem queryItemWithName:@"MemberId" value:arra[0]];
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
            NSLog(@"jsonresonse:%@",jsonresonse);
            //[self  shoppinglistcount];
            if ([[jsonresonse valueForKey:@"responsecode"] integerValue]==1)
            {
                NSMutableDictionary*dict;
                if ([_filtertype isEqualToString:@"Catogories"] || [_filtertype isEqualToString:@"Filters"])
                {
                    dict=[[NSMutableDictionary alloc] initWithDictionary:selectCatidArray[index]];
                    [dict setObject:@"0" forKey:@"ListCount"];
                    [selectCatidArray replaceObjectAtIndex:index withObject:dict];
                    
                    // [getBackuparray addObjectsFromArray:selectCatidArray];
                    
//                     [[SingleTanGlobalClass instance] MoreCouponseIdChangeStoreAll:selectCatidArray];
                }
                else
                {
                    dict=[[NSMutableDictionary alloc] initWithDictionary:productList[index]];
                    [dict setObject:@"0" forKey:@"ListCount"];
                     [productList replaceObjectAtIndex:index withObject:dict];
               
                }
             }
        }
    }
}
-(void)UpdateGroupName:(NSMutableDictionary*)dict
{
  
           [productList replaceObjectAtIndex:SelectedProductIndex withObject:dict];
          // [Cir_data replaceObjectAtIndex:SelectedProductIndex withObject:dict];
           [_collectionSingletable reloadData];
           [_collectionDoubletable reloadData];
           NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
           [_collectionSingletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
     
   
    
}

-(void)addProductlistArraydoublerow:(NSMutableDictionary *)celldata cell:(DoubleViewCollectionCell*)cell index:(NSInteger)index
{
    
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    if ([[celldata valueForKey:@"PrimaryOfferTypeId"] integerValue]==3 || [[celldata valueForKey:@"PrimaryOfferTypeId"] integerValue]==2)
    {
        if ([[celldata valueForKey:@"ClickCount"] integerValue]==1)
        {
            cell.product_titleactivelab.text=@"Activated";
            cell.activeimg.hidden=NO;
            cell.activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
            cell.activbtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
            cell.removeview.hidden=YES;
        }
        else
        {
            cell.product_titleactivelab.text=@"Activate";
            cell.activbtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
            cell.removeview.hidden=YES;
             cell.activeimg.hidden=YES;
        }
    }
    
    else if([[celldata valueForKey:@"PrimaryOfferTypeId"] integerValue]==1)
    {
        
        cell.removeview.hidden=YES;
        cell.Activateview.hidden=YES;
        cell.limitShowlab.hidden=YES;
    }
    [cell cellOnData:celldata myPersonalPriceViewController:self index1:index];
}
-(void)addProductlistArray:(NSMutableDictionary *)celldata cell:(SingleViewCollectionCell*)cell index:(NSInteger)index
{
  
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    if ([[celldata valueForKey:@"PrimaryOfferTypeId"] integerValue]==3 || [[celldata valueForKey:@"PrimaryOfferTypeId"] integerValue]==2)
    {
        if ([[celldata valueForKey:@"ClickCount"] integerValue]==1)
        {
            cell.product_titleactivelab.text=@"Activated";
              cell.activeimg.hidden=NO;
            cell.activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
             cell.activbtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
             cell.removeview.hidden=YES;
        }
        else
        {
            cell.product_titleactivelab.text=@"Activate";
             cell.activbtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
            cell.removeview.hidden=YES;
             cell.activeimg.hidden=YES;
    
         }
    }
 
    else if([[celldata valueForKey:@"PrimaryOfferTypeId"] integerValue]==1)
    {

        cell.removeview.hidden=YES;
        cell.Activateview.hidden=YES;
        cell.limitShowlab.hidden=YES;
        cell.activeimg.hidden=YES;
    }
    [cell cellOnData:celldata myPersonalPriceViewController:self index1:index];
}
-(void)backShoppinglistDeleted:(NSMutableDictionary*)dict
{
    
    
         NSString*UPCRelated=[NSString stringWithFormat:@"%@",dict[@"UPC"]];
         NSMutableDictionary*dicts=[[NSMutableDictionary alloc] initWithDictionary:productList[SelectedProductIndex]];
    
        if ([UPCRelated isEqualToString:dicts[@"UPC"]] ||[UPCRelated isEqualToString:dicts[@"CouponID"]])
        {
               [dicts setObject:@"0" forKey:@"ListCount"];
            
            
            
            
            
            for (int i=0; i<[Cir_data count]; i++)
            {
                if ([dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue] ||[dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                {
                    
                    if ([dicts[@"CouponID"] integerValue]==[Cir_data[i][@"CouponID"] integerValue])
                    {
                          NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                          [Cir_Dicts setObject:@"0" forKey:@"ListCount"];
                          [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                    }
                }
            }
            
            
            
      }
        else
        {
              [dicts setObject:@"0" forKey:@"ListCount"];
            
            
            
            
            
            for (int i=0; i<[Cir_data count]; i++)
            {
                if ([dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                {
                    
                    if ([dicts[@"UPC"] integerValue]==[Cir_data[i][@"UPC"] integerValue])
                    {
                        NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                        [Cir_Dicts setObject:@"0" forKey:@"ListCount"];
                        [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                    }
                }
            }
            
            
            
            
        }
        [productList replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
        [self.delegate function:Cir_data];
        [_collectionSingletable reloadData];
        [_collectionDoubletable reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
        [_collectionSingletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        [_collectionDoubletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
   
  
   
}
-(void)RelatedHeaderActivateToCircular:(NSMutableDictionary*)dict
{
    
    
    NSMutableDictionary*dicts=[[NSMutableDictionary alloc] initWithDictionary:productList[SelectedProductIndex]];
    if ([dicts[@"PrimaryOfferTypeId"]integerValue]==3 || [dicts[@"PrimaryOfferTypeId"]integerValue]==2)
    {
    
          [dicts setObject:@"1" forKey:@"ClickCount"];
        for (int i=0; i<[Cir_data count]; i++)
        {
            if ([dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue] ||[dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
            {
                
                if ([dicts[@"CouponID"] integerValue]==[Cir_data[i][@"CouponID"] integerValue])
                {
                    NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                     [Cir_Dicts setObject:@"1" forKey:@"ClickCount"];
                    [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                }
            }
        }
      
        
        
    }
    else
    {
        
          [dicts setObject:@"1" forKey:@"ClickCount"];
        
        
        for (int i=0; i<[Cir_data count]; i++)
        {
            if ([dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
            {
                
                if ([dicts[@"UPC"] integerValue]==[Cir_data[i][@"UPC"] integerValue])
                {
                    NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                    [Cir_Dicts setObject:@"1" forKey:@"ClickCount"];
                    [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                }
            }
        }
       
        
        
        
        
        
    }
    
    [productList replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
     [self.delegate function:Cir_data];
    [_collectionSingletable reloadData];
    [_collectionDoubletable reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
    [_collectionSingletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    [_collectionDoubletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
 
//        NSMutableDictionary*dicts=[[NSMutableDictionary alloc] initWithDictionary:productList[SelectedProductIndex]];
//        NSMutableDictionary*cirdicts=[[NSMutableDictionary alloc] initWithDictionary:Cir_data[SelectedProductIndex]];
//        [dicts setObject:@"1" forKey:@"ClickCount"];
//        [cirdicts setObject:@"1" forKey:@"ClickCount"];
//        [productList replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
//        [Cir_data replaceObjectAtIndex:SelectedProductIndex withObject:cirdicts];
//        [_collectionSingletable reloadData];
//        [_collectionDoubletable reloadData];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
//        [_collectionSingletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
//        [_collectionDoubletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
  
   //[self.delegate getshopinglist];
}
-(void)shoppinglisttocircularQuantityUpdate:(NSMutableDictionary*)dict
{
    
    
        NSString*UPCShopping=dict[@"OfferCode"];
        NSString*Quantity=dict[@"Quantity"];


            for (int i=0; i<[Cir_data count]; i++)
            {

                if ([dict[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                {
                    if ([dict[@"OfferCode"] integerValue]==[Cir_data[i][@"UPC"] integerValue])
                    {
                         NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                        [Cir_Dicts setObject:Quantity forKey:@"Quantity"];
                        [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                    }
                }
            }

            
            for (int k=0; k<[productList count]; k++)
            {
               if ([dict[@"PrimaryOfferTypeId"] integerValue]==[productList[k][@"PrimaryOfferTypeId"] integerValue])
                {
                   if ([dict[@"OfferCode"] integerValue]==[productList[k][@"UPC"] integerValue])
                    {
                       NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[productList objectAtIndex:k]];
                        [Cir_Dicts setObject:Quantity forKey:@"Quantity"];
                        [productList replaceObjectAtIndex:k withObject:Cir_Dicts];
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:k inSection:0];
                        [_collectionSingletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                        [_collectionDoubletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                    }
                }
            }
         [self.delegate function:Cir_data];
         [_collectionSingletable reloadData];
         [_collectionDoubletable reloadData];
   
    
   
   
 
}

//  related items remove  quantity and Details page remove  quantity
-(void)BackRemoveQuantity:(NSMutableDictionary*)dict
{
    
         NSString*UPCRelated=[NSString stringWithFormat:@"%@",dict[@"UPC"]];
    
         NSMutableDictionary*dicts=[[NSMutableDictionary alloc] initWithDictionary:productList[SelectedProductIndex]];
         if ([UPCRelated isEqualToString:dicts[@"UPC"]])
         {
            [dicts setObject:@"0" forKey:@"ListCount"];
            [dicts setObject:@"0" forKey:@"Quantity"];
             
             
             for (int i=0; i<[Cir_data count]; i++)
             {
                 if ([dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue] ||[dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                 {
                     
                     if ([dicts[@"CouponID"] integerValue]==[Cir_data[i][@"CouponID"] integerValue])
                     {
                         NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                         [Cir_Dicts setObject:@"0" forKey:@"ListCount"];
                         [Cir_Dicts setObject:@"0" forKey:@"Quantity"];
                         [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                     }
                 }
             }
             
             
        }
        else
        {
            [dicts setObject:@"0" forKey:@"ListCount"];
            [dicts setObject:@"0" forKey:@"Quantity"];
            
            
            for (int i=0; i<[Cir_data count]; i++)
            {
                if ([dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                {
                    
                    if ([dicts[@"UPC"] integerValue]==[Cir_data[i][@"UPC"] integerValue])
                    {
                        NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                        [Cir_Dicts setObject:@"0" forKey:@"ListCount"];
                        [Cir_Dicts setObject:@"0" forKey:@"Quantity"];
                        [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                    }
                }
            }
            
            
        }
        [productList replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
        [self.delegate function:Cir_data];
        [_collectionSingletable reloadData];
        [_collectionDoubletable reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
        [_collectionSingletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        [_collectionDoubletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
       
   
  
    
}


// back Related items  Activation and details Activation
-(void)BackActivateFucDetails:(NSMutableDictionary*)dict
{

         NSString*UPCRelated=[NSString stringWithFormat:@"%@",dict[@"UPC"]];
         NSString*UPCRelatedOfferscode=[NSString stringWithFormat:@"%@",dict[@"UPC"]];
         NSString*str=[NSString stringWithFormat:@"%@",dict[@"Quantity"]];
 
             NSMutableDictionary*dicts=[[NSMutableDictionary alloc] initWithDictionary:productList[SelectedProductIndex]];
             NSString*UPCCircular=[NSString stringWithFormat:@"%@",dicts[@"UPC"]];
            if([dict[@"PrimaryOfferTypeId"] integerValue]==3 || [dict[@"PrimaryOfferTypeId"] integerValue]==2)
            {
                if ([UPCRelated isEqualToString:UPCCircular] || [UPCRelatedOfferscode isEqualToString:dicts[@"OfferCode"]])
                {
                    [dicts setObject:@"1" forKey:@"ClickCount"];
                    [dicts setObject:@"1" forKey:@"ListCount"];
                    [dicts setObject:str forKey:@"Quantity"];
                    
                    
                    for (int i=0; i<[Cir_data count]; i++)
                    {
                        if ([dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue] ||[dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                        {
                            
                            if ([dicts[@"CouponID"] integerValue]==[Cir_data[i][@"CouponID"] integerValue])
                            {
                                NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                                [Cir_Dicts setObject:@"1" forKey:@"ClickCount"];
                                [Cir_Dicts setObject:@"1" forKey:@"ListCount"];
                                [Cir_Dicts setObject:str forKey:@"Quantity"];
                                [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                            }
                        }
                    }
                  
                 
                    
                    
                    
                    
                }
                else
                {
                    //confused but updated
                    
                   // [dict setObject:@"1" forKey:@"ClickCount"];
                    [dicts setObject:@"1" forKey:@"ClickCount"];
                  
                    
                    
                    for (int i=0; i<[Cir_data count]; i++)
                    {
                        if ([dicts[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                        {
                            
                            if ([dicts[@"UPC"] integerValue]==[Cir_data[i][@"UPC"] integerValue])
                            {
                                  NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                                  [Cir_Dicts setObject:@"1" forKey:@"ClickCount"];
                                  [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                            }
                        }
                    }
                   
                    
                    
                   
                    
                    
                    
                    
                }
            }
    
        [productList replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
        [self.delegate function:Cir_data];
        [_collectionSingletable reloadData];
        [_collectionDoubletable reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
        [_collectionSingletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        [_collectionDoubletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}
//actiavted
-(void)BackActivateFuc:(NSMutableDictionary*)dict backdatadict:(NSMutableDictionary*)backdatadict
{
    
    
             NSString*UPCRelated=[NSString stringWithFormat:@"%@",dict[@"UPC"]];
             NSString*UPCRelatedoffercode=[NSString stringWithFormat:@"%@",dict[@"OfferCode"]];
             NSString*str=[NSString stringWithFormat:@"%@",dict[@"Quantity"]];
 
    
    
          backdatadict=[[NSMutableDictionary alloc] initWithDictionary:productList[SelectedProductIndex]];
          NSString*UPCCircular=[NSString stringWithFormat:@"%@",backdatadict[@"UPC"]];
          if([dict[@"PrimaryOfferTypeId"] integerValue]==3 || [dict[@"PrimaryOfferTypeId"] integerValue]==2)
          {
             if ([UPCRelated isEqualToString:UPCCircular] || [UPCRelatedoffercode isEqualToString:backdatadict[@"UPC"]])
              {
                  [backdatadict setObject:@"1" forKey:@"ClickCount"];
                  [backdatadict setObject:@"1" forKey:@"ListCount"];
                  [backdatadict setObject:str forKey:@"Quantity"];
                  
                  
                  
                  
                  for (int i=0; i<[Cir_data count]; i++)
                  {
                      if ([backdatadict[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue] ||[backdatadict[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                      {
                          
                          if ([backdatadict[@"CouponID"] integerValue]==[Cir_data[i][@"CouponID"] integerValue])
                          {
                              NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                              [Cir_Dicts setObject:@"1" forKey:@"ClickCount"];
                              [Cir_Dicts setObject:@"1" forKey:@"ListCount"];
                              [Cir_Dicts setObject:str forKey:@"Quantity"];
                              [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                          }
                      }
                  }
            }
              else
              {
                     [backdatadict setObject:@"1" forKey:@"ClickCount"];
                  
                 
                  
                  
                  for (int i=0; i<[Cir_data count]; i++)
                  {
                      if ([backdatadict[@"PrimaryOfferTypeId"] integerValue]==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                      {
                          
                          if ([backdatadict[@"UPC"] integerValue]==[Cir_data[i][@"UPC"] integerValue])
                          {
                                 NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[Cir_data objectAtIndex:i]];
                                [Cir_Dicts setObject:@"1" forKey:@"ClickCount"];
                                [Cir_data replaceObjectAtIndex:i withObject:Cir_Dicts];
                          }
                      }
                  }
                  
             }
              
          }
      
        [productList replaceObjectAtIndex:SelectedProductIndex withObject:backdatadict];
        [self.delegate function:Cir_data];
        [_collectionSingletable reloadData];
       [_collectionDoubletable reloadData];
       NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
       [_collectionSingletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
       [_collectionDoubletable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

-(void)openDetails:(NSInteger)index
{
    
    selectallindex=index;
        SelectedProductIndex=index;
     [self performSegueWithIdentifier:@"details" sender:self];
}
-(void)RelatedItems:(NSInteger)index
{
      selectallindex=index;
       SelectedProductIndex=index;
       [self performSegueWithIdentifier:@"ParticipantingItemViewController" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"details"])
    {
      
          ProductDetailsViewController *destViewController = segue.destinationViewController;
          destViewController.delegate=self;
          destViewController.comefrom=@"Cicular";
           destViewController.data = [productList objectAtIndex:SelectedProductIndex];
 
   }
    else if ([segue.identifier isEqualToString:@"ParticipantingItemViewController"])
    {
          ParticipantingItemViewController *destViewController = segue.destinationViewController;
          destViewController.comefrom=@"Cicular";
          destViewController.iscontrollercheckback=@"iscircularcontroller";
          destViewController.Delegate=self;
          destViewController.dataDict = [productList objectAtIndex:SelectedProductIndex];
        
  }
    
}

-(IBAction)threelinebtn:(id)sender
{
    
  // [self.delegate customSetup];
    
}

-(void)storybord
{
    
   if(isiPhone5s)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:MyPersonalPriceViewController.class]];
    }
    else if(isiPhone6)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main7" bundle:[NSBundle bundleForClass:MyPersonalPriceViewController.class]];
    }
    else if(isiPhone8Plus)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main8" bundle:[NSBundle bundleForClass:MyPersonalPriceViewController.class]];
    }
    else if(isiPhoneX || isiPhoneXsMax)
    {
        storyboard = [UIStoryboard storyboardWithName:@"MainX" bundle:[NSBundle bundleForClass:MyPersonalPriceViewController.class]];
    }
    else if(isiPad ||isiPadSmall)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Mainipad" bundle:[NSBundle bundleForClass:MyPersonalPriceViewController.class]];
     }
    else{
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:MyPersonalPriceViewController.class]];
    }
}

-(void)apple1:(NSInteger)index
{
    [self cancelSearching];
}
-(void)apple2:(NSInteger)index
{
   [self cancelSearching];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    footerstr=@"";
 
    _filtercatclassview.hidden=YES;
     [self Filterviewclasshide];
     [self.delegate showtabbarview];
  
     NSInteger addint;
    
     if (tableView==_Filtertable)
     {
            // [_Filtertable cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
         
        
         
        if(indexPath.row==0)
        {
              catbyid=0;
               addint=0;
                productList=[[NSMutableArray alloc] init];
              [productList removeAllObjects];
//  primaryoffertypeid=0;
            for (int j=0; j<[Cir_data count]; j++)
            {
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSearching"] isEqualToString:@"isSearching"])
                {
                    
                      [productList  addObject:Cir_data[j]];
                }
                else
                {
                    if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]==primaryoffertypeid)
                    {
                         [productList  addObject:Cir_data[j]];
                    }
                    else //if(ptid==0 && primaryoffertypeid!=0)
                     {
                                 primaryoffertypeid=0;
                                 if (j==0)
                                 {
                                     [productList  addObjectsFromArray:PersonalAddarry];
                                 }
                                 if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]!=2)
                                 {
                                     [productList  addObject:Cir_data[j]];
                                 }
                                 else
                                 {
                                     if ([Cir_data[j][@"TileNumber"]integerValue]==999)
                                     { if (addint==0)
                                     { addint=1;
                                         [productList  addObjectsFromArray:additonalofrray];
                                         [productList  addObject:Cir_data[j]];
                                     }
                                     else
                                     {
                                         [productList  addObject:Cir_data[j]];
                                     }
                                     }
                                     else
                                     {
                                         [productList  addObject:Cir_data[j]];
                                     }
                                 }
                     }
                    
                    
                    
                    
                    
            }
            }
            [self GetCatList];
             [_Filtercattable reloadData];
        }
        else
            {
                                productList=[[NSMutableArray alloc] init];
                                [productList removeAllObjects];
                               addint=0;
                
                           savingarray=[[NSMutableArray alloc] init];
                            [savingarray removeAllObjects];
                
                          for (int j=0; j<[Cir_data count]; j++)
                            {
                                  if(indexPath.row==1)
                                   {
                                        primaryoffertypeid=3;
                                         catbyid=0;
                                         if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]==3)
                                         {
                                             [productList  addObject:Cir_data[j]];
                                         }
                                    }
                                    else if(indexPath.row==2)
                                    {
                                                    primaryoffertypeid=2;
                                                    catbyid=0;
                                                    if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]==2)
                                                    {
                                                         if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSearching"] isEqualToString:@"isSearching"])
                                                           {
                                                                [productList  addObject:Cir_data[j]];
                                                           }
                                                           else
                                                           {
                                                               if ([Cir_data[j][@"TileNumber"]integerValue]==999)
                                                                {
//                                                                    if (addint==0)
//                                                                    {
//                                                                        addint=1;
//                                                                        [productList  addObjectsFromArray:additonalofrray];
//                                                                        [productList  addObject:Cir_data[j]];
//                                                                     }
//                                                                    else
//                                                                    {
                                                                            [productList  addObject:Cir_data[j]];
                                                                     // }
                                                              }
                                                               else
                                                               {[productList  addObject:Cir_data[j]];
                                                               }
                                                           }
                                                   }
                                        
                                     }
                                    else if(indexPath.row==3)
                                    {
                                                primaryoffertypeid=1;
                                                   catbyid=0;
                                                if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]==1)
                                                {
                                                    [productList  addObject:Cir_data[j]];
                                                }
                                    }
                                
                               }
            if (productList.count==0)//nul data popup
            {
                self->_Deafultpopupview.hidden=NO;
                self->_Deafultpopupviewcolor.hidden=NO;
                self->_nothingtextlab.text=[NSString stringWithFormat:@"Sorry, your search for '[ %@ ]' did not return any result in your personal Ad.Currently we don't have any deals, coupons, sales price items matching your search. Our stores still might carry it and if we do its at the right price. \nYou may also:Check for typos. \nBe more general(e.g. 'potatoes' instead of bag of 'potatoes')",_searchtxt.text];
                [Validation zoomIn:self->_Deafultpopupview];
                [self.delegate showbolerview];
                
            }
         
             [self GetCatList];
             [_Filtercattable reloadData];
                
                 offersbyid=1;
                
                if (sortedindex==1)
                {
                    [self RecommendedSort];
                }
                else  if (sortedindex==2)
                {  [self sortingBysavings];
                }
                else  if (sortedindex==3)
                {
                    [self Offertypes];
                }
        }
      
    }
    else  if (tableView==_Filtercattable)
    {
        offersbyid=0;
               // [_Filtercattable cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        
                                         _filtercatclassview.hidden=YES;
                                         _filterclassview.hidden=YES;
                              if(indexPath.row==0)
                                 {
                                     
                                          catbyid=0;
                                          addint=0;
                                          productList=[[NSMutableArray alloc] init];
                                          [productList removeAllObjects];
                                     
                                     for (int j=0; j<[Cir_data count]; j++)
                                     {
                                         if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSearching"] isEqualToString:@"isSearching"])
                                         {
                                             [productList  addObject:Cir_data[j]];
                                         }
                                         else
                                         {
                                             
                                             if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]==primaryoffertypeid && primaryoffertypeid==1)
                                             {
                                                 [productList  addObject:Cir_data[j]];
                                             }
                                             else  if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]==primaryoffertypeid && primaryoffertypeid==2)
                                             {
                                                 [productList  addObject:Cir_data[j]];
                                             }
                                             else  if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]==primaryoffertypeid && primaryoffertypeid==3)
                                             {
                                                 [productList  addObject:Cir_data[j]];
                                             }
                                             else
                                             {
                                                 
                                                             if (j==0)
                                                             {
                                                                 [productList  addObjectsFromArray:PersonalAddarry];
                                                             }
                                                             if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]!=2)
                                                             {
                                                                 [productList  addObject:Cir_data[j]];
                                                             }
                                                             else
                                                             {
                                                                 if ([Cir_data[j][@"TileNumber"]integerValue]==999)
                                                                 { if (addint==0)
                                                                 { addint=1;
                                                                     [productList  addObjectsFromArray:additonalofrray];
                                                                     [productList  addObject:Cir_data[j]];
                                                                     
                                                                 }
                                                                 else
                                                                 { [productList  addObject:Cir_data[j]];
                                                                 }
                                                                 }
                                                                 else
                                                                 { [productList  addObject:Cir_data[j]];
                                                                 }
                                                             }
                                             }
                                             
                                             
                                       }
                                    }
                                    // [productList addObjectsFromArray:Cir_originalarry];
                               }
                                        else
                                        {
                                            
                                            
                                           productList=[[NSMutableArray alloc] init];
                                             [productList removeAllObjects];
                                          for ( int i=0; i<[Cir_data count]; i++)
                                            {
                                                if(primaryoffertypeid==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                                                {
                                                    if ([Cir_data[i][@"CategoryID"] integerValue]==[FilterByCatArray[indexPath.row][@"CategoryID"] integerValue])
                                                          {NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:Cir_data[i]];
                                                              [productList addObject:dict];
                                                          
                                                         }
                                                    
                                                
                                                    
                                                    
                                                }
                                               else
                                               {
                                                   
                                                   
                                                   if(primaryoffertypeid==0)
                                                   {
                                                           if ([Cir_data[i][@"CategoryID"] integerValue]==[FilterByCatArray[indexPath.row][@"CategoryID"] integerValue])
                                                           {
                                                               
                                                                   NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:Cir_data[i]];
                                                                   [productList addObject:dict];
                                                               
                                                           }
                                                   }
                                                   
                                               }
                                                
                                                
                                             
                                                    catbyid=[FilterByCatArray[indexPath.row][@"CategoryID"] integerValue];
                                                   // NSLog(@"catby:%d",catbyid);
                                            }
            
                  //[self sortingBysavings];
                                            
                                            if (sortedindex==1)
                                            {
                                                [self RecommendedSort];
                                            }
                                            else  if (sortedindex==2)
                                            {  [self sortingBysavings];
                                            }
                                            else  if (sortedindex==3)
                                            {
                                                [self Offertypes];
                                            }
        }
        
      
 }
    else if (tableView==_sortbyTable)
    {
        //[_sortbyTable cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
           [self sortbyviewhide];
        if (indexPath.row==0)
        {
               if (primaryoffertypeid!=0)
               {
                   sortedindex=1;
               }
            
               _HeaderTitleSortbyclass.text=@"Sort by Recommended";
                [self RecommendedSort];
       }
        else if (indexPath.row==1)
        {
            
                       sortedindex=2;
                      _HeaderTitleSortbyclass.text=@"Sort by Savings";
                       [self sortingBysavings];
       
       }
         else if (indexPath.row==2)
        {
               if (primaryoffertypeid!=0)
               {
                    sortedindex=3;
               }
                 _HeaderTitleSortbyclass.text=@"Sort by Offers Type";
                 [self Offertypes];
        }
        
    }
    
    
    
  
    
    [_collectionDoubletable reloadData];
    [_collectionSingletable reloadData];
   
   // [_Filtertable reloadData];
  
}
-(void)sortingBysavings
{
    NSLog(@"sortedindex:%d",sortedindex);
    NSLog(@"catbyid:%d",catbyid);
    NSLog(@"primaryoffertypeid:%d",primaryoffertypeid);
    
    if (sortedindex==2)
    {
        NSMutableArray*arr=[[NSMutableArray alloc] init];
        [arr addObjectsFromArray:productList];
        
        sortedindex=2;
        _HeaderTitleSortbyclass.text=@"Sort by Savings";
        savingarray=[[NSMutableArray alloc] init];
        [savingarray removeAllObjects];
        for (int i=0; i<arr.count; i++){
            
            if ([arr[i][@"CouponID"] integerValue]==1 || [arr[i][@"CouponID"] integerValue]==10)
            {
                    NSLog(@"CouponID:%d",[arr[i][@"CouponID"] integerValue]);
            }
            else
            {
                    float sav=[arr[i][@"Savings"] floatValue];
                    NSMutableDictionary*dicts=[[NSMutableDictionary alloc] initWithDictionary:arr[i]];
                    [dicts setValue:[NSNumber numberWithFloat:sav] forKey:@"Savings"];
                    [savingarray addObject:dicts];
            }
            
            
            
        }
         productList=[[[NSMutableArray alloc] init] mutableCopy];
         [productList removeAllObjects];
         NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"Savings" ascending:NO];
         NSMutableArray*pListcopy=(NSMutableArray*)[savingarray sortedArrayUsingDescriptors:@[sort]];
         [productList addObjectsFromArray:pListcopy];
    }
    
  
    
}
-(void)RecommendedSort
{
    NSLog(@"sortedindex:%d",sortedindex);
    NSLog(@"catbyid:%d",catbyid);
    NSLog(@"primaryoffertypeid:%d",primaryoffertypeid);
    
     NSInteger addintsortR;
     savingarray=[[NSMutableArray alloc] init];
     [savingarray removeAllObjects];
    
     productList=[[NSMutableArray alloc] init];
     [productList removeAllObjects];
   
    

    if (sortedindex==1)
    {
                   NSMutableArray*array=[[NSMutableArray alloc] initWithArray:productList];
                     if(catbyid!=0)
                      {
                          for (int i=0; i<Cir_data.count; i++)
                          {
                              
                                     if ([Cir_data[i][@"CategoryID"] integerValue]==catbyid)
                                     {
                                         [savingarray addObject:Cir_data[i]];
                                     }
                      }

                      }
                     else if(offersbyid==1)
                     {
                         for (int i=0; i<Cir_data.count; i++)
                         {
                             if ([Cir_data[i][@"PrimaryOfferTypeId"] integerValue]==primaryoffertypeid)
                             {
                                 [savingarray addObject:Cir_data[i]];
                             }
                             else if ([Cir_data[i][@"PrimaryOfferTypeId"] integerValue]==0)
                             {
                                 [savingarray addObject:Cir_data[i]];
                             }
                         }
                     }

                        else
                        {
                                    for (int k=0; k<array.count; k++)
                                    {
                                        if ([array[k][@"CouponID"] integerValue]==1 || [array[k][@"CouponID"] integerValue]==10)
                                        {
                                           
                                        }
                                        else
                                        {
                                              [savingarray addObject:array[k]];
                                        }
                                    }
                            
                       }
         NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"PrimaryOfferTypeId" ascending:NO];
         NSMutableArray*pListcopy=(NSMutableArray*)[savingarray sortedArrayUsingDescriptors:@[sort]];
         [productList addObjectsFromArray:pListcopy];
    }
   else if (catbyid!=0)
   {
       for (int i=0; i<Cir_data.count; i++)
       { if ([Cir_data[i][@"CategoryID"] integerValue]==catbyid)
       {
           [savingarray addObject:Cir_data[i]];
       }
       }
       NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"PrimaryOfferTypeId" ascending:NO];
        NSMutableArray*pListcopy=(NSMutableArray*)[savingarray sortedArrayUsingDescriptors:@[sort]];
        [productList addObjectsFromArray:pListcopy];
   }
    else if (primaryoffertypeid==0)
    {
            addintsortR=0;
         for (int j=0; j<[Cir_data count]; j++)
         {
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSearching"] isEqualToString:@"isSearching"])
                {
                    [productList  addObject:Cir_data[j]];
                }
                else
                {
                    
                 if (j==0)
                 {
                     [productList  addObjectsFromArray:PersonalAddarry];
                 }
                 if ([Cir_data[j][@"PrimaryOfferTypeId"] integerValue]!=2)
                 {
                     [productList  addObject:Cir_data[j]];
                 }
                 else
                 {
                     if ([Cir_data[j][@"TileNumber"]integerValue]==999)
                     { if (addintsortR==0)
                     { addintsortR=1;
                         [productList  addObjectsFromArray:additonalofrray];
                         [productList  addObject:Cir_data[j]];
                     }
                     else
                     {
                         [productList  addObject:Cir_data[j]];
                     }
                     }
                     else
                     {
                         [productList  addObject:Cir_data[j]];
                     }
                 }
             }
           
        }
         NSMutableArray*aray=[[NSMutableArray alloc] initWithArray:productList];
        
          productList=[[NSMutableArray alloc] init];
          [productList removeAllObjects];
        
         NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"PrimaryOfferTypeId" ascending:NO];
          NSMutableArray*pListcopy=(NSMutableArray*)[aray sortedArrayUsingDescriptors:@[sort]];
         [productList addObjectsFromArray:pListcopy];
    }
    else //if(catbyid!=0)
    {
        
        
           for (int i=0; i<Cir_data.count; i++){
            
            if ([Cir_data[i][@"PrimaryOfferTypeId"] integerValue]==primaryoffertypeid)
            {
                [savingarray addObject:Cir_data[i]];
            }
            else if (primaryoffertypeid==0)
            {
                [savingarray addObject:Cir_data[i]];
            }
        }
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"PrimaryOfferTypeId" ascending:NO];
        NSMutableArray*pListcopy=(NSMutableArray*)[savingarray sortedArrayUsingDescriptors:@[sort]];
        [productList addObjectsFromArray:pListcopy];
    }
    

    
    
}
-(void)Offertypes
{
    
    
    NSLog(@"sortedindex:%d",sortedindex);
    NSLog(@"catbyid:%d",catbyid);
    NSLog(@"primaryoffertypeid:%d",primaryoffertypeid);
    
 
    
    productList=[[NSMutableArray alloc] init];
    [productList removeAllObjects];
    savingarray=[[NSMutableArray alloc] init];
    [savingarray removeAllObjects];
    if (sortedindex==3)
    {
        NSMutableArray*arr=[[NSMutableArray alloc] initWithArray:productList];
        if(catbyid!=0)
        {
                for (int i=0; i<Cir_data.count; i++)
                {
            
                    if ([Cir_data[i][@"CategoryID"] integerValue]==catbyid)
                    {
                        [savingarray addObject:Cir_data[i]];
                    }
                
                }
          
        }
        else if(offersbyid==1)
        {
                    for (int i=0; i<Cir_data.count; i++)
                    {
                        if ([Cir_data[i][@"PrimaryOfferTypeId"] integerValue]==primaryoffertypeid)
                        {
                            [savingarray addObject:Cir_data[i]];
                        }
                        else if ([Cir_data[i][@"PrimaryOfferTypeId"] integerValue]==0)
                        {
                            [savingarray addObject:Cir_data[i]];
                        }
                    }
        }
        else
        {
            
            
            for (int k=0; k<arr.count; k++)
            {
                if ([arr[k][@"CouponID"] integerValue]==1 || [arr[k][@"CouponID"] integerValue]==10)
                {
                    
                }
                else
                {
                    [savingarray addObject:arr[k]];
                }
            }
            
        }
     

   
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"PrimaryOfferTypeId" ascending:NO];
        NSMutableArray*pListcopy=(NSMutableArray*)[savingarray sortedArrayUsingDescriptors:@[sort]];
        [productList addObjectsFromArray:pListcopy];
    }
  else  if(catbyid!=0)
    {
          for (int i=0; i<Cir_data.count; i++)
                { if ([Cir_data[i][@"CategoryID"] integerValue]==catbyid)
                              {
                                 [savingarray addObject:Cir_data[i]];
                              }
                }
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"PrimaryOfferTypeId" ascending:NO];
         NSMutableArray*pListcopy=(NSMutableArray*)[savingarray sortedArrayUsingDescriptors:@[sort]];
          [productList addObjectsFromArray:pListcopy];
    }
    else
    {
        for (int i=0; i<Cir_data.count; i++)
        {
            if ([Cir_data[i][@"PrimaryOfferTypeId"] integerValue]==primaryoffertypeid)
            {
                [savingarray addObject:Cir_data[i]];
            }
            else if(primaryoffertypeid==0)
            {
                [savingarray addObject:Cir_data[i]];
            }
            
        }
         NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"PrimaryOfferTypeId" ascending:NO];
         NSMutableArray*pListcopy=(NSMutableArray*)[savingarray sortedArrayUsingDescriptors:@[sort]];
         [productList addObjectsFromArray:pListcopy];
    }
    
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:( NSIndexPath *)indexPath
{
     if (tableView==_Filtertable)
     {
         return 45;
     }
     else if (tableView==_sortbyTable)
    {
          return 45;
    }
    else
    {
          return 45;
    }
    return 0;

}
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
      if (tableView==_Filtertable)
      {
          return [offerFilterarrayObj count];
      }
     else if (tableView==_sortbyTable)
    {
        return [SortByarrayObj count];
    }
    
    else
    {
          return [FilterByCatArray count];
    }
   return 0;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath
{
    if (tableView==_Filtertable)
    {
        static NSString*CellIdentifier=@"SelectSecreteCell";
        SelectSecreteCell* celll=(SelectSecreteCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (celll==nil)
        {
            [tableView registerNib:[UINib nibWithNibName:@"SelectSecreteCell" bundle:[NSBundle bundleForClass:SelectSecreteCell.class]] forCellReuseIdentifier:CellIdentifier];
            celll=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        celll.selectionStyle=UITableViewCellSelectionStyleNone;
         NSMutableDictionary*FilSelectRowData=offerFilterarrayObj[indexPath.row][@"Filers"];
        [celll celldata:FilSelectRowData];
           return celll;
    }
    else  if (tableView==_Filtercattable)
    {
        static NSString*CellIdentifier=@"SelectSecreteCell";
        SelectSecreteCell* celll=(SelectSecreteCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (celll==nil)
        {
            [tableView registerNib:[UINib nibWithNibName:@"SelectSecreteCell" bundle:[NSBundle bundleForClass:SelectSecreteCell.class]] forCellReuseIdentifier:CellIdentifier];
            celll=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        celll.selectionStyle=UITableViewCellSelectionStyleNone;
        celll.city_name.text=[NSString stringWithFormat:@"%@",[FilterByCatArray[indexPath.row] valueForKey:@"CategoryName"]];
        
           return celll;
    }
    else  if (tableView==_sortbyTable)
    {
        static NSString*CellIdentifier=@"SelectSecreteCell";
        SelectSecreteCell* celll=(SelectSecreteCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (celll==nil)
        {
            [tableView registerNib:[UINib nibWithNibName:@"SelectSecreteCell" bundle:[NSBundle bundleForClass:SelectSecreteCell.class]] forCellReuseIdentifier:CellIdentifier];
            celll=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        celll.selectionStyle=UITableViewCellSelectionStyleNone;
        celll.city_name.text=[NSString stringWithFormat:@"%@",[SortByarrayObj[indexPath.row] valueForKey:@"sort"]];
        
        return celll;
    }
    
   
   return nil;
 
}
-(IBAction)filterback:(id)sender
{
         [self Filterviewclasshide];
        _filtercatclassview.hidden=YES;
        _sortbyclassview.hidden=YES;
         [self.delegate  showtabbarview];
    
}

-(IBAction)filtercatback:(id)sender
{
      [self Filterviewclasshide];
      _filtercatclassview.hidden=YES;
      _sortbyclassview.hidden=YES;
      [self.delegate  showtabbarview];
}
    -(IBAction)sortbyback:(id)sender
    {
        _filterclassview.hidden=YES;
        _filtercatclassview.hidden=YES;
        _sortbyclassview.hidden=YES;
         [self.delegate  showtabbarview];
    }
-(void)filterclasscatviewshow
{
   _filtercatclassview.hidden=NO;
}
-(void)filterclasscatviewhide
{
 _filtercatclassview.hidden=YES;
}
-(void)Filterviewclasshide
{
    _filterclassview.hidden=YES;
}
-(void)Filterviewclassshow
{
   _filterclassview.hidden=NO;
    
}
-(void)sortbyviewhide
    {
        _sortbyclassview.hidden=YES;
    }

-(void)sortbyviewshow
    {
       _sortbyclassview.hidden=NO;
    }


-(void)GetCatList
{

    NSMutableArray*sortedarray=[[NSMutableArray alloc] init];
    FilterByCatArray=[[NSMutableArray alloc] init];

    NSString*CateGoryID=@"";
    NSString*hasstrID=@"";
    NSString*CateGoryIDes=@"";
    
    NSString*str=[NSString stringWithFormat:@"%d",[Cir_data objectAtIndex:0]];
    NSInteger countAll=0;
    NSInteger checkcount=0;
    countAll=[Cir_data count];
  
    [FilterByCatArray removeAllObjects];
    for (int i=0; i<[Cir_data count]; i++)
    {
        
        if (primaryoffertypeid==0)
        {
                                    if(CateGoryID!=Cir_data[i][@"CategoryID"])
                                    {
                                                                    hasstrID=[NSString stringWithFormat:@"%@%@%@",@"#",Cir_data[i][@"CategoryID"],@"#"];
                                                                    if(![CateGoryIDes containsString:hasstrID])
                                                                    {
                                                                        CateGoryIDes = [NSString stringWithFormat:@"%@%@%@%@%@",CateGoryIDes,@"#",Cir_data[i][@"CategoryID"],@"#",@","];
                                                                        CateGoryID=Cir_data[i][@"CategoryID"];
                                                                        
                                                                                                  NSInteger contcar=0;
                                                                                                    for (int j=0; j<[Cir_data count]; j++)
                                                                                                    {
                                                                                                        if(CateGoryID==Cir_data[j][@"CategoryID"])
                                                                                                        {
                                                                                                            contcar=contcar+1;
                                                                                                        }
                                                                                                    }
                                                                                                if (i==0)
                                                                                                {
                                                                                                     NSMutableDictionary*Temp=[[NSMutableDictionary alloc] init];
                                                                                                       [Temp setObject:@"0" forKey:@"CategoryID"];
                                                                                      //                       [Temp setObject:[NSString stringWithFormat:@"%@(%ld)",@"All Category",(long)countAll] forKey:@"CategoryName"];
                                                                                                          [Temp setObject:[NSString stringWithFormat:@"All Categories"] forKey:@"CategoryName"];
                                                                                                         [sortedarray addObject:Temp];
                                                                                                }
                                                                                                NSMutableDictionary*Temp=[[NSMutableDictionary alloc] init];
                                                                                                [Temp setObject:Cir_data[i][@"CategoryID"] forKey:@"CategoryID"];
                                                                                                [Temp setObject:[NSString stringWithFormat:@"%@(%ld)",Cir_data[i][@"CategoryName"],(long)contcar] forKey:@"CategoryName"];
                                                                                                [sortedarray addObject:Temp];
                                                                        
                                                                        
                                                                    }
                                    }
        }
            else
            {
                
                
                
                if (primaryoffertypeid==[Cir_data[i][@"PrimaryOfferTypeId"] integerValue])
                {
                if(CateGoryID!=Cir_data[i][@"CategoryID"])
                 {
                    hasstrID=[NSString stringWithFormat:@"%@%@%@",@"#",Cir_data[i][@"CategoryID"],@"#"];
                    if(![CateGoryIDes containsString:hasstrID])
                    {
                        CateGoryIDes = [NSString stringWithFormat:@"%@%@%@%@%@",CateGoryIDes,@"#",Cir_data[i][@"CategoryID"],@"#",@","];
                        CateGoryID=Cir_data[i][@"CategoryID"];
                        
                        NSInteger contcar=0;
                       
                          NSInteger total=0;
                        for (int j=0; j<[Cir_data count]; j++)
                        {
                            if (primaryoffertypeid==[Cir_data[j][@"PrimaryOfferTypeId"] integerValue])
                            {
                                total=total+1;
                            if(CateGoryID==Cir_data[j][@"CategoryID"])
                            {
                                contcar=contcar+1;
                            }
                            }
                        }
                        if (checkcount==0)
                        {
                            checkcount=checkcount+1;
                            NSMutableDictionary*Temp=[[NSMutableDictionary alloc] init];
                            [Temp setObject:@"0" forKey:@"CategoryID"];
                            [Temp setObject:[NSString stringWithFormat:@"All Categories"] forKey:@"CategoryName"];
                            [sortedarray addObject:Temp];
                        }
                        NSMutableDictionary*Temp=[[NSMutableDictionary alloc] init];
                        [Temp setObject:Cir_data[i][@"CategoryID"] forKey:@"CategoryID"];
                        [Temp setObject:[NSString stringWithFormat:@"%@(%ld)",Cir_data[i][@"CategoryName"],(long)contcar] forKey:@"CategoryName"];
                        [sortedarray addObject:Temp];
                     
                        
                    }
                }
            }
            
        }
  
        
    }
    
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"CategoryName" ascending:YES];
    FilterByCatArray=(NSMutableArray*)[sortedarray sortedArrayUsingDescriptors:@[sort]];
    
}


//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//          if (tableView==_sortbyTable)
//          {
//            [_sortbyTable cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//
//          }
//            else  if (tableView==_Filtertable)
//            {
//                   [_Filtertable cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//            }
//           else  if (tableView==_Filtercattable)
//           {
//              [_Filtercattable cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//           }
//
//}
@end
