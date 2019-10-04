//
//  PurchaseHistoryDetailsViewController.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 10/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "PurchaseHistoryDetailsViewController.h"
#import "PurchasesHistoryDetailsCell.h"
#import "Validation.h"
#import "ObjectType.h"
#import <SVProgressHUD.h>
#import "Reachability.h"
#import "ApiHendlerClass.h"
@interface PurchaseHistoryDetailsViewController ()
{
    NSMutableArray*detailsarry;
}
@end

@implementation PurchaseHistoryDetailsViewController
-(void)GetPurchaseListDetails
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

    if ([expare isEqualToString:today])
    {
        [self purchaesehistorycheckdate];
    }
    else
    {
        ApiHendlerClass*cls=[ApiHendlerClass new];
        [cls getAccessToken:ACCESSTOKEN_URL];
        [self purchaesehistorycheckdate];
    }
}
-(void)purchaesehistorycheckdate
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
        NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                  };
        NSURLComponents *components = [NSURLComponents componentsWithString:PURCHASEHITORYDETAILS_URL];
        NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"PurchaseId" value:_purchaseid[@"purchaseid"]];
        components.queryItems = @[LoyaltyCardNumber];
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
      
            detailsarry=[[[NSMutableArray alloc] init] mutableCopy];
            if ([[jsonObject valueForKey:@"errorcode"] integerValue]==0)
            {
                [SVProgressHUD dismiss];
                NSMutableArray*arra=[[NSMutableArray alloc] init];
                [arra addObjectsFromArray:jsonObject[@"purchasemessage"]];
                for (int i=0; i<[arra count]; i++)
                {
                    [detailsarry addObject:arra[i]];
                    
                }
            }
            else
            {
                  [SVProgressHUD dismiss];
            
            }
            
            
            
            
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
       [Validation addShadowToView:self.headerView];
       [Validation addShadowToView:self.shadowView];
       [self.historyDetailstable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _datelab.text=_purchaseid[@"purchasedate"];
        _locationlab.text=_purchaseid[@"storelocation"];
        _totalpricepaidlab.text=[NSString stringWithFormat:@"$%.02f",[_purchaseid[@"totalamount"] floatValue]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       [self GetPurchaseListDetails];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_historyDetailstable reloadData];
        });
        
    });
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.historyDetailstable.backgroundColor = [UIColor whiteColor];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return detailsarry.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString*Cellidentifier=@"PurchasesHistoryDetailsCell";
    PurchasesHistoryDetailsCell*cell=(PurchasesHistoryDetailsCell*)[tableView dequeueReusableCellWithIdentifier:Cellidentifier];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"PurchasesHistoryDetailsCell" bundle:[NSBundle bundleForClass:PurchasesHistoryDetailsCell.class]] forCellReuseIdentifier:Cellidentifier];
        cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier];
    }
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
     NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:detailsarry[indexPath.row]];
    _totalitemslab.text=detailsarry[0][@"totalquantity"];
    _totalsavingslab.text=[NSString stringWithFormat:@"$%@",detailsarry[0][@"remainamount"]];
    _Totalpricebuttomlab.text=[NSString stringWithFormat:@"$%@",detailsarry[0][@"totalamount"]];
    [cell cellondata:dict];
    return cell;
    
    
}
-(IBAction)back:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}
@end
