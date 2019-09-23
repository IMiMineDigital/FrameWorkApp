//
//  PurchaseHistoryViewController.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 8/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "PurchaseHistoryViewController.h"
#import "Validation.h"
#import "PurchaseHistoryCell.h"
#import "ObjectType.h"
#import <SVProgressHUD.h>
#import "Reachability.h"
#import "PurchaseHistoryDetailsViewController.h"
#import "ApiHendlerClass.h"
@interface PurchaseHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray*historyarray;
}
@end

@implementation PurchaseHistoryViewController
-(void)GetPurchaseList
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
    [self getpurchesehistorycheckdate];
}
-(void)getpurchesehistorycheckdate
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
        NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
        NSURLComponents *components = [NSURLComponents componentsWithString:PURCHASEHISTORY_URL];
        NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"MemberId" value:arra[0]];
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
             
            historyarray=[[[NSMutableArray alloc] init] mutableCopy];
            if ([[jsonObject valueForKey:@"errorcode"] integerValue]==0)
            {
                [SVProgressHUD dismiss];
                NSMutableArray*arra=[[NSMutableArray alloc] init];
                [arra addObjectsFromArray:jsonObject[@"purchasemessage"]];
                for (int i=0; i<[arra count]; i++)
                {
                    [historyarray addObject:arra[i]];
                    
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
         [self.historytable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       [self GetPurchaseList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_historytable reloadData];
        });
        
    });

}
-(void)didReceiveMemoryWarning{
    
//    [historyarray removeAllObjects];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return historyarray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*Cellidentifier=@"PurchaseHistoryCell";
    PurchaseHistoryCell*cell=(PurchaseHistoryCell*)[tableView dequeueReusableCellWithIdentifier:Cellidentifier];
    if (cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"PurchaseHistoryCell" bundle:[NSBundle bundleForClass:PurchaseHistoryCell.class]] forCellReuseIdentifier:Cellidentifier];
        cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:historyarray[indexPath.row]];
    [cell.linkbtn addTarget:self action:@selector(linkbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell cellondata:dict];
    return cell;
    
}

-(IBAction)linkbtn:(UIButton*)sender
{
    UIButton*btn=(UIButton*)sender;
    CGPoint senderPosition = [btn convertPoint:CGPointZero toView:self.historytable];
    NSIndexPath *indexrPath = [self.historytable indexPathForRowAtPoint:senderPosition];
    [self performSegueWithIdentifier:@"PurchaseHistoryDetailsViewController" sender:historyarray[indexrPath.row]];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PurchaseHistoryDetailsViewController"])
    {
         PurchaseHistoryDetailsViewController *destViewController = segue.destinationViewController;
         destViewController.purchaseid = (NSMutableDictionary*) sender;
    }
}
-(IBAction)back:(id)sender
{
  
    if ([_Checkback isEqualToString:@"FirstEnter"])
    {
        ApiHendlerClass*dissmisswindow=[ApiHendlerClass new];
        [dissmisswindow dissmisscontroller];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        //[self.delegate AddMypersonalPriceController];
    }

    
 
}

@end
