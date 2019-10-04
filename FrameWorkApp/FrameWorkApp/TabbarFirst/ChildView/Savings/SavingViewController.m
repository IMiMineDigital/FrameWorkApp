//
//  SavingViewController.m
//  Bashas
//
//  Created by kamlesh prajapati on 5/10/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import "SavingViewController.h"
#import "Reachability.h"
#import "ApiHendlerClass.h"
@interface SavingViewController ()
{
    NSMutableArray*arrayObj;
    NSArray*mypersonalDeals;
    NSArray*MyPersonalCoupons;
    NSArray*MysaleItems;
    NSArray*TotalSaving;
}
@end

@implementation SavingViewController
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
    NSLog(@"Expaire:%@",expare);
    if (![expare isEqualToString:today])
    {
        ApiHendlerClass*cls=[ApiHendlerClass new];
        [cls getAccessToken:ACCESSTOKEN_URL];
    }
 
     [self savingcheakdate];
    
}
-(void)savingcheakdate
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
        [SVProgressHUD show];
        NSDictionary *headers = @{ @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                   };
        
        
        
        NSLog(@"TYCCard:%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"]);
        NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
        
        
        NSURLComponents *components = [NSURLComponents componentsWithString:SAVING_URL];
        NSURLQueryItem *memberid = [NSURLQueryItem queryItemWithName:@"MemberId" value:arra[0]];
        components.queryItems = @[memberid];
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
            [SVProgressHUD dismiss];
            NSMutableDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
           // NSLog(@"jsonObject:%@",jsonObject);
            arrayObj=[[NSMutableArray alloc]init];
            NSLog(@"jsonObject:%d",jsonObject.count);
            if ([[jsonObject valueForKey:@"errorcode"] integerValue]==0)
            {
                 [arrayObj addObject:jsonObject[@"message"]];
                
               mypersonalDeals=(NSArray*)[arrayObj[0] valueForKey:@"PersonalDealSaving"];
              MyPersonalCoupons=(NSArray*)[arrayObj[0] valueForKey:@"CouponSaving"];
                MysaleItems=(NSArray*)[arrayObj[0] valueForKey:@"TPRSaving"];
               TotalSaving=(NSArray*)[arrayObj[0] valueForKey:@"TotalSaving"];
             }
            else
            {
                [SVProgressHUD dismiss];
             
               
            }
        }
        
    }
    
    
}
-(void)savingdata
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self GetCircularofferlist];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self->arrayObj.count==1)
            {
                self->_mypersonalDeals.text=[NSString stringWithFormat:@"$%@",self->mypersonalDeals[0]];
                self->_MyPersonalCoupons.text=[NSString stringWithFormat:@"$%@",self->MyPersonalCoupons[0]];
                self->_MysaleItems.text=[NSString stringWithFormat:@"$%@",self->MysaleItems[0]];
                self->_totoalsaving.text=[NSString stringWithFormat:@"$%@",self->TotalSaving[0]];
            }
            else
            {
                self->_mypersonalDeals.text=@"$0.00";
                self->_MyPersonalCoupons.text=@"$0.00";
                self->_MysaleItems.text=@"$0.00";
                self->_totoalsaving.text=@"$0.00";
            }
        });
    });
}
- (void)viewDidLoad
{
       [super viewDidLoad];
    
   mypersonalDeals=[[NSArray alloc] init];
   MyPersonalCoupons=[[NSArray alloc] init];
   MysaleItems=[[NSArray alloc] init];
   TotalSaving=[[NSArray alloc] init];
      _BackBtn.hidden=YES;
     [self savingdata];
      [Validation addShadowToView:_headerView];
    
}
- (void)didReceiveMemoryWarning
 {
    [super didReceiveMemoryWarning];
 }
- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
 }

- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
