//
//  SoppingListViewcontroller.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 21/04/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "SoppingListViewcontroller.h"
#import "SoppingListCell.h"
#import "Validation.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import <SVProgressHUD.h>
#import "ApiHendlerClass.h"
#import "ActivatedOffersCell.h"
#import "ProductDetailsViewController.h"
#import "HomeViewController.h"
@interface SoppingListViewcontroller ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPrintInteractionControllerDelegate,UITextViewDelegate,ProductDetailsViewControllerDelegate,HomeViewControllerDelegate>
{
    
        NSMutableArray*soppinglist;
        NSMutableArray*array;
        NSMutableArray*filerarray;
        NSMutableArray*ActivatedOffersArray;
       NSInteger SelectedProductIndex;
  
      NSInteger togleindxbtn;
      NSInteger selectindex;
    
    BOOL checkedAll;
    
       NSMutableArray*ActivatedsortingArry;
}
@end

@implementation SoppingListViewcontroller

-(void)GetActivatedOffersdate
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
    [self GetActivatedOffersApi];
}
-(void)GetActivatedOffersApi
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
        NSURLComponents *components = [NSURLComponents componentsWithString:ACTIVATEDOFFERS_URL];
        NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"MemberId" value:arra[0]];
        NSURLQueryItem *CategoryID = [NSURLQueryItem queryItemWithName:@"CategoryID" value:@"3"];
        components.queryItems = @[LoyaltyCardNumber,CategoryID];
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
            ActivatedOffersArray=[[[NSMutableArray alloc] init] mutableCopy];
            if ([[jsonObject valueForKey:@"errorcode"] integerValue]==0)
            {
                [SVProgressHUD dismissWithDelay:1.0];
                 NSArray* array=jsonObject[@"message"][@"WCouponsDetails"];
                 if ([array  isKindOfClass:[NSNull class]])
                 {


                 }
                  else if ([ActivatedOffersArray isKindOfClass:[NSMutableArray class]])
                 {
                     
                     [ActivatedOffersArray addObjectsFromArray:array];
                    
                }

            }
            else
            {
                [SVProgressHUD dismiss];
            }
            
        }
    }
    
}
-(void)GetShoppinglist
{
    [self getshoppinglistcheckdate];
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
-(void)getshoppinglistcheckdate
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
            // NSLog(@"jsonObject:%@",jsonObject);
             soppinglist=[[[NSMutableArray alloc] init] mutableCopy];
             if ([[jsonObject valueForKey:@"errorcode"] integerValue]==0)
            {
                  [SVProgressHUD dismissWithDelay:1.0];
                array=jsonObject[@"message"][@"ShoppingListItems"];
                if ([array  isKindOfClass:[NSNull class]])
                {
            
                    
                }
                else
                {
                       [soppinglist addObjectsFromArray:array];
                       [filerarray addObjectsFromArray:array];
                      _arrayobj=(NSMutableArray*)soppinglist;
                    
                }
               
      }
            else
            {
                [SVProgressHUD dismiss];
            }
            
        }
    }
   
}

- (void)viewDidLoad
{
        [super viewDidLoad];
        [self.soppingTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
         [self.activatedOffersTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [Validation addShadowToView:self.headerview];
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
        [_soppingTable addSubview:refreshControl];
        [self shoppinglist];
        _EmailView.hidden=YES;
        _cancelView.hidden=YES;
       _AdditemsView.hidden=YES;
        _soppingTable.hidden=YES;
        _additemsTextField.layer.borderColor=[[UIColor lightGrayColor] CGColor];
         [Validation setRoundView:_additemsTextField borderWidth:0 borderColor:nil radius:4];
         [Validation setRoundView:self.AdditemsView borderWidth:0 borderColor:nil radius:5];
        [Validation setRoundView:self.EmailView borderWidth:0 borderColor:nil radius:5];
         [Validation addShadowToView:self.AdditemsView];
        [Validation addShadowToView:self.EmailView];
        [Validation setRoundView:self.sendbtn borderWidth:0 borderColor:nil radius:4];
        [Validation setRoundView:self.additemsbtnsend borderWidth:0 borderColor:nil radius:4];
        [Validation setRoundView:self.cancelView borderWidth:0 borderColor:nil radius:_cancelView.layer.frame.size.height/2];
        _sendbtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
        _bolerView.hidden=YES;
    
       [[_segControl.subviews objectAtIndex:0] setTintColor:[UIColor lightGrayColor]];
       _Explab.hidden=YES;

      [_activatedOffersTable setDelegate:self];
      [_activatedOffersTable setDataSource:self];
      [_soppingTable setDelegate:self];
      [_soppingTable setDataSource:self];
      _EmailTextField.delegate=self;
      _additemsTextField.delegate=self;
      UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapped)];
     tapScroll.cancelsTouchesInView = NO;
     [self.activatedOffersTable addGestureRecognizer:tapScroll];
     [self.view addGestureRecognizer:tapScroll];
     [self.soppingTable addGestureRecognizer:tapScroll];
     togleindxbtn=1;
     filerarray=[[[NSMutableArray alloc] init] mutableCopy];
    ActivatedsortingArry=[[[NSMutableArray alloc] init] mutableCopy];
     [Validation addShadowToView:self.shoppingFilterView];
    _additemsTextField.delegate=self;
   _additemsTextField.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _additemsTextField.tag=0;
    _additemsTextField.layer.borderWidth=2;
    _additemsTextField.layer.cornerRadius=2;
    
    _Explab.hidden=NO;
    _pricelab.hidden=YES;
    _qtylab.hidden=YES;
    
    if ([_isCheckfilter isEqualToString:@"FirstEnter"])
    {
        _shoppingFilterView.hidden=YES;
    }
   _additemsTextField.textContainer.maximumNumberOfLines = 10;
    _additemsTextField.delegate = self;
    _additemsTextField.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
   _additemsTextField.delegate=self;
   _shoppingFilterView=[self.delegate hideview:_shoppingFilterView];
    [self Activatedlist];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.soppingTable.backgroundColor = [UIColor whiteColor];
    self.activatedOffersTable.backgroundColor = [UIColor whiteColor];
    
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
   if (textField == self.EmailTextField)
    {
        [textField resignFirstResponder];
    }
     else {
         
               [textField resignFirstResponder];
    }
    return YES; // We do not want UITextField to insert line-breaks.
}

-(IBAction)Recentatitly:(id)sender
{
    
    _shoppingFilterView=[self.delegate hideview:_shoppingFilterView];
     NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"ExpirationDate" ascending:YES];
     filerarray=(NSMutableArray*)[soppinglist sortedArrayUsingDescriptors:@[sort]];
  
        ActivatedsortingArry=(NSMutableArray*)[ActivatedOffersArray sortedArrayUsingDescriptors:@[sort]];
        ActivatedOffersArray=ActivatedsortingArry;
    
    soppinglist=filerarray;
    [_soppingTable reloadData];
    [_activatedOffersTable reloadData];
}

-(IBAction)Expairation:(id)sender
{
   _shoppingFilterView=[self.delegate hideview:_shoppingFilterView];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"ExpirationDate" ascending:NO];
    filerarray=(NSMutableArray*)[soppinglist sortedArrayUsingDescriptors:@[sort]];
    
    
    ActivatedsortingArry=(NSMutableArray*)[ActivatedOffersArray sortedArrayUsingDescriptors:@[sort]];
    ActivatedOffersArray=ActivatedsortingArry;
    
     soppinglist=filerarray;
    [_soppingTable reloadData];
    [_activatedOffersTable reloadData];
}


- (void)tapped
{
     [self.view endEditing:YES];
    _EmailView.hidden=YES;
    _cancelView.hidden=YES;
    _AdditemsView.hidden=YES;
    _shoppingFilterView.hidden=YES;
  
}


-(void)shoppinglist
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self GetShoppinglist];
     dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate getShoppingListCount:self->soppinglist];
           [self->_soppingTable reloadData];
           });
        
    });
}
-(void)Activatedlist
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          [self GetActivatedOffersApi];
        dispatch_async(dispatch_get_main_queue(), ^{
          [self->_activatedOffersTable reloadData];
            
        });
        
    });
}
- (void)handleRefresh:(UIRefreshControl *)sender
{
    [sender endRefreshing];
//    [self shoppinglist];
       [self->_activatedOffersTable reloadData];
        [self->_soppingTable reloadData];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (range.length != 0)
    {
        if ([text isEqualToString:@"\n"])
        {
            [textView resignFirstResponder];
            return YES;
        }
   }
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      if (tableView==_soppingTable)
      {

               return soppinglist.count;
      }
    else if (tableView==_activatedOffersTable)
    {
           return ActivatedOffersArray.count;
    }
   
    return 0;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_soppingTable)
    {
       return 100;
    }
    else if (tableView==_activatedOffersTable)
    {
        return 100;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView==_soppingTable)
    {
        static NSString*Cellidentifier=@"SoppingListCell";
        SoppingListCell*cell=(SoppingListCell*)[tableView dequeueReusableCellWithIdentifier:Cellidentifier];
        if (cell==nil)
        {
            [tableView registerNib:[UINib nibWithNibName:@"SoppingListCell" bundle:[NSBundle bundleForClass:SoppingListCell.class]] forCellReuseIdentifier:Cellidentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:soppinglist[indexPath.row]];
        cell.deletebtn.tag = indexPath.row;
        cell.AddOwndeletebtn.tag=indexPath.row;
   
        if ([dict[@"PrimaryOfferTypeId"] integerValue]==1 || [dict[@"PrimaryOfferTypeId"] integerValue]==2 || [dict[@"PrimaryOfferTypeId"] integerValue]==3)
         {
            cell.backgroundColor= [UIColor colorWithRed:9/255.0 green:82/255.0 blue:149/255.0 alpha:1.0];
              [cell.deletebtn addTarget:self action:@selector(rowDelete:) forControlEvents:UIControlEventTouchUpInside];
         }
        else
        {
              cell.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
              [cell.AddOwndeletebtn addTarget:self action:@selector(deleterowAddOwnitems:) forControlEvents:UIControlEventTouchUpInside];
        }
       
         [cell cellOnData:dict soppingListViewcontroller:self index1:indexPath.row];
          return cell;
    }
    else if (tableView==_activatedOffersTable)
    {
        static NSString*Cellidentifier=@"ActivatedOffersCell";
        ActivatedOffersCell*cell=(ActivatedOffersCell*)[tableView dequeueReusableCellWithIdentifier:Cellidentifier];
        if (cell==nil)
        {
            [tableView registerNib:[UINib nibWithNibName:@"ActivatedOffersCell" bundle:[NSBundle bundleForClass:SoppingListCell.class]] forCellReuseIdentifier:Cellidentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier];
        }
          cell.selectionStyle=UITableViewCellSelectionStyleNone;
         NSMutableDictionary*ActivatedOffers=[[NSMutableDictionary alloc] initWithDictionary:ActivatedOffersArray[indexPath.row]];
         [cell.btnact addTarget:self action:@selector(actidetails:) forControlEvents:UIControlEventTouchUpInside];
        selectindex=indexPath.row;
        [cell CellOndata:ActivatedOffers soppingListViewcontroller:self index:indexPath.row];
          return cell;
    }
    
     return nil;
    
    
}
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

         NSDictionary *headers = @{ @"Content-Type": @"application/json",
                                   @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                   };
             NSMutableDictionary *strDict =[[NSMutableDictionary alloc] initWithDictionary:soppinglist[index]];
             NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
             NSString *upc=strDict[@"OfferCode"];
             NSInteger counts=[strDict[@"Quantity"] integerValue];
             NSString* quantity;
 
             if (counts>0 || counts==0)
            {
                 counts++;
                 NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:strDict];
                 [dict setObject:[NSString stringWithFormat:@"%d",counts] forKey:@"Quantity"];
                 strDict=dict;
                 [soppinglist replaceObjectAtIndex:index withObject:strDict];
                 quantity=soppinglist[index][@"Quantity"];
                
                
                

//        for (int i=0; i<[_CirCouponseidChecked count]; i++)
//        {

//                if ([strDict[@"CouponID"] integerValue]==[_CirCouponseidChecked[i][@"CouponID"] integerValue])
//                {
//
//                        NSLog(@"strDict:%@",strDict[@"CouponID"]);
//                          NSLog(@"_CirCouponseidChecked:%@",_CirCouponseidChecked[i][@"CouponID"]);
//
//                          NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[_CirCouponseidChecked objectAtIndex:i]];
//                          [Cir_Dicts setObject:[NSString stringWithFormat:@"%d",counts] forKey:@"Quantity"];
//                          [_CirCouponseidChecked replaceObjectAtIndex:i withObject:Cir_Dicts];
//
//
//
//                 }
//
//        }

                
          }
        NSDictionary *profilew = @{@"ShoppingListItems":@[@{@"UPC":upc,@"Quantity":quantity,@"DateAddedOn":@"12/7/2018 10:53:31 PM"}]};
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:profilew options:0 error:NULL];
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
                //[self.delegate shoppingToCircularUpdateqty:strDict];
                [self.delegate shoppingToCircularUpdateTotalqtyadd:strDict];
                [UIView setAnimationsEnabled:NO];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                [_soppingTable beginUpdates];
                [_soppingTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                                     withRowAnimation:UITableViewRowAnimationNone];
                [_soppingTable endUpdates];
          
            }
        }
    }
}

-(void)addproductzero:(NSInteger)index
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
      
        NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                                   @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                   };
        
        NSMutableDictionary *strDict =[[NSMutableDictionary alloc] initWithDictionary:soppinglist[index]];
        NSInteger counts=[strDict[@"Quantity"] integerValue];
        NSString* quantity;
        
        if (counts>0 || counts==0)
        {
            counts++;
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:strDict];
            [dict setObject:[NSString stringWithFormat:@"%ld",counts] forKey:@"Quantity"];
            strDict=dict;
            [soppinglist replaceObjectAtIndex:index withObject:strDict];
            quantity=soppinglist[index][@"Quantity"];
        }
        NSURLComponents *components = [NSURLComponents componentsWithString:SOPPINGLISTIDZERO_URL];
        NSURLQueryItem *quantit = [NSURLQueryItem queryItemWithName:@"Quantity" value:quantity];
        NSString*strid=[NSString stringWithFormat:@"%@",soppinglist[index][@"ShoppingListItemID"]];
        NSURLQueryItem *ShoppingListOwnItemID = [NSURLQueryItem queryItemWithName:@"ShoppingListOwnItemID" value:strid];
        components.queryItems = @[ShoppingListOwnItemID,quantit];
        NSURL *url = components.URL;
        NSLog(@"URL:%@",components.URL);
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"PUT"];
        [request setAllHTTPHeaderFields:headers];
       [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        NSURLResponse*response=nil;
        NSError*err=nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        if (responseData!=nil)
        {
            NSMutableDictionary *jsonresonse = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"aajsonresonsezero:%@",jsonresonse);
            if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
            {
                [UIView setAnimationsEnabled:NO];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                [_soppingTable beginUpdates];
                [_soppingTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                                     withRowAnimation:UITableViewRowAnimationNone];
                [_soppingTable endUpdates];
                
            }
        }
    }
}
-(void)Subproductzero:(NSInteger)index
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
        
        NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                                   @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                   };
        NSMutableDictionary *strDict =[[NSMutableDictionary alloc] initWithDictionary:soppinglist[index]];
        NSInteger counts=[strDict[@"Quantity"] integerValue];
        NSString* quantity;
        
         if (counts>1)
        {
            counts--;
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:strDict];
            [dict setObject:[NSString stringWithFormat:@"%ld",counts] forKey:@"Quantity"];
            strDict=dict;
            [soppinglist replaceObjectAtIndex:index withObject:strDict];
            quantity=soppinglist[index][@"Quantity"];
        }
        NSURLComponents *components = [NSURLComponents componentsWithString:SOPPINGLISTIDZERO_URL];
        NSURLQueryItem *quantit = [NSURLQueryItem queryItemWithName:@"Quantity" value:quantity];
        NSString*strid=[NSString stringWithFormat:@"%@",soppinglist[index][@"ShoppingListItemID"]];
        NSURLQueryItem *ShoppingListOwnItemID = [NSURLQueryItem queryItemWithName:@"ShoppingListOwnItemID" value:strid];
        
        components.queryItems = @[ShoppingListOwnItemID,quantit];
        NSURL *url = components.URL;
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"PUT"];
        [request setAllHTTPHeaderFields:headers];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        NSURLResponse*response=nil;
        NSError*err=nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        if (responseData!=nil)
        {
            NSMutableDictionary *jsonresonse = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"subjsonresonsezero:%@",jsonresonse);
            if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
            {
                
                [UIView setAnimationsEnabled:NO];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                [_soppingTable beginUpdates];
                [_soppingTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                                     withRowAnimation:UITableViewRowAnimationNone];
                [_soppingTable endUpdates];
                
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
           NSMutableDictionary *strDict = [[NSMutableDictionary alloc] initWithDictionary:[soppinglist objectAtIndex:index]];
            upc =soppinglist[index][@"OfferCode"];
            count=[soppinglist[index][@"Quantity"] integerValue];
            if (count>1)
            {
                count--;
                NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:strDict];
                [dict setObject:[NSString stringWithFormat:@"%ld",count] forKey:@"Quantity"];
                strDict=dict;
                [soppinglist replaceObjectAtIndex:index withObject:strDict];
                 quantity=soppinglist[index][@"Quantity"];
                 [self subproducts:upc quantity:quantity index:index];
                
                
//                for (int i=0; i<[_CirCouponseidChecked count]; i++)
//                {
//
//                   if ([strDict[@"CouponID"] integerValue]==[_CirCouponseidChecked[i][@"CouponID"] integerValue])
//                    {
//                       NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[_CirCouponseidChecked objectAtIndex:i]];
//                        [Cir_Dicts setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Quantity"];
//                        [_CirCouponseidChecked replaceObjectAtIndex:i withObject:Cir_Dicts];
//
//                     }
//
//                }
                
                
                
            }
            //[self.delegate shoppingToCircularUpdateqty:strDict];
            [self.delegate shoppingToCircularUpdateTotalqtysub:strDict];
    }
}
-(void)subproducts:(NSString*)upc quantity:(NSString*)quantity index:(NSInteger)index
{
   
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
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
        NSLog(@"jsonresonse:%@",jsonresonse);
        if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
        {
             [UIView setAnimationsEnabled:NO];
             NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
             [_soppingTable beginUpdates];
             [_soppingTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                                            withRowAnimation:UITableViewRowAnimationNone];
             [_soppingTable endUpdates];
        }
    }
}
-(IBAction)deleterowAddOwnitems:(UIButton*)sender
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
        NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:[soppinglist objectAtIndex:sender.tag]];
        NSString* ShoppingListOwnID=[NSString stringWithFormat:@"%@",dict[@"ShoppingListItemID"]];
        NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                  };
       NSURLComponents *components = [NSURLComponents componentsWithString:DELETEROWADDOWNITEMS];
       NSURLQueryItem *ShoppingListOwnItemID = [NSURLQueryItem queryItemWithName:@"ShoppingListOwnItemID" value:ShoppingListOwnID];
       components.queryItems = @[ShoppingListOwnItemID];
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
            NSMutableDictionary *jsonObject= [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"jsonObject:%@",jsonObject);
            if ([[jsonObject valueForKey:@"responsecode"] integerValue]==1)
            {
               
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       [self GetShoppinglist];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_soppingTable reloadData];
                    });
                    
                });
                 [SVProgressHUD dismissWithDelay:1.0];
                 if ([dict  isKindOfClass:[NSNull class]])
                {
                    
                }
                else
                {
                   [self.delegate Deleteshoppinglist:dict];
                }
            }
            
        }
        
    }
    
    
    
}
- (IBAction)segColorBtnTapped:(id)sender
{
    
    if (_segControl.selectedSegmentIndex==0)
    {
        
        if (togleindxbtn==2)
        {
            togleindxbtn=1;
        }
        
         _Explab.hidden=NO;
         _pricelab.hidden=YES;
         _qtylab.hidden=YES;
        
        _soppingTable.hidden=YES;
        _activatedOffersTable.hidden=NO;
    }
    else  if(_segControl.selectedSegmentIndex==1)
    {
        if ( togleindxbtn==1)
        {
            togleindxbtn=2;
        }
        
        _Explab.hidden=YES;
        _pricelab.hidden=YES;
        _qtylab.hidden=NO;
        
        
        _soppingTable.hidden=NO;
        _activatedOffersTable.hidden=YES;
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
        if (checkedAll==true)
        {
               checkedAll=false;
              [self.delegate shoppingTocircularAllDelete];
        }
         [self.delegate backCircularpageForShoppinglist];
    }
  
    
}
-(void)sendEmailApi
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
        if(![Validation isValidEmail:self.EmailTextField.text])
        {
             self.EmailTextField.text=@"";
             [self.view makeToast:@"Please enter Valid Email" duration:TOAST_TIMEOUT position:TOAST_BOTTOM];
        }
        else
        {
            
                [SVProgressHUD show];
                NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                                           @"Device": @"5",
                                           @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                           
                                           };
                NSArray*array=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"ShopperID"];
                NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
                NSString *post=[NSString stringWithFormat:@"LoyaltyNumber=%@&Emails=%@&MemberID=%@",array[0],self.EmailTextField.text,arra[0]];
                NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                NSString *jsonString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
                NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SENDMAIL_URL]];
                [request setHTTPMethod:@"POST"];
                [request setAllHTTPHeaderFields:headers];
                [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
                [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
                NSURLResponse*response=nil;
                NSError*err=nil;
                NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
                if (responseData!=nil)
                {
                    [SVProgressHUD dismissWithDelay:1.0];
                    NSMutableDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
                    NSLog(@"jsonObject:%@",jsonObject);
                  if ([jsonObject[@"errorcode"] integerValue]==200)
                    {
//                         _EmailView.hidden=YES;
//                        _cancelView.hidden=YES;
                         [self.view makeToast:@"Sucessfully" duration:TOAST_TIMEOUT position:TOAST_BOTTOM];
                    }
                }
                
            }
     
  }

}
-(void)AlertviewcontrollerAllDeleteShoppingList
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Delete"
                                 message:@"Do you want to delete all the items from the shopping list?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Confirm"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                    [self AlldeleteShoppingListcheckdate];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(IBAction)emailbtnClick:(id)sender
{
     _AdditemsView.hidden=YES;

    if (soppinglist.count>0)
    {
        _bolerView.hidden=NO;
        [self.delegate showbolerview];
        _EmailView.hidden=NO;
        _cancelView.hidden=NO;
        [Validation zoomIn:_EmailView];
      
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Empty shopping list"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    

    
}
-(IBAction)cancelemailbtn:(id)sender
{
     _EmailView.hidden=YES;
     _cancelView.hidden=YES;
    [self.delegate hidebolerview];
    _bolerView.hidden=YES;
    _AdditemsView.hidden=YES;
}

-(IBAction)sendEmailbtn:(id)sender
{
    
    
    _bolerView.hidden=YES;
    [self.delegate hidebolerview];
    _EmailView.hidden=YES;
    _cancelView.hidden=YES;
    
  
   
    [NSTimer scheduledTimerWithTimeInterval:0.001
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:NO];
    
    
}
-(void)targetMethod:(NSTimer*)timer
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
    [self sendEmailApi];
    
}
-(IBAction)sendPrintbtn:(id)sender
{
    
    
}
-(IBAction)rowDelete:(UIButton*)sender
{
    
    
    
     _AdditemsView.hidden=YES;
      [self deleterowcheckdate:sender];
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
-(void)deleterowcheckdate:(UIButton*)sender
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
        NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:[soppinglist objectAtIndex:sender.tag]];
        
        NSString* ShoppingListI=[NSString stringWithFormat:@"%@",dict[@"ShoppingListItemID"]];
        
        NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                  };
        NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
        NSURLComponents *components = [NSURLComponents componentsWithString:SINGLEROWDELETE_URL];
        NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"MemberId" value:arra[0]];
        NSURLQueryItem *ShoppingListItemID = [NSURLQueryItem queryItemWithName:@"ShoppingListItemID" value:ShoppingListI];
        
        components.queryItems = @[ShoppingListItemID,LoyaltyCardNumber];
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
            NSMutableDictionary *jsonObject= [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"jsonObject:%@",jsonObject);
            if ([[jsonObject valueForKey:@"responsecode"] integerValue]==1)
            {
                [SVProgressHUD dismiss];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   [self GetShoppinglist];
                    dispatch_async(dispatch_get_main_queue(), ^{
                         [self->_soppingTable reloadData];
                    });

                });
               
               if ([dict  isKindOfClass:[NSNull class]])
                {
                    
                }
                else
                {
                    //[self.delegate Deleteshoppinglist:dict];
                    [self.delegate shoppingTocircularindexdataClear:soppinglist[sender.tag]];
                }
            }
            
        }
      
    }
}

-(IBAction)additems:(id)sender
{
    
    
     _AdditemsView.hidden=NO;
     _bolerView.hidden=NO;
     [self.delegate showbolerview];
     _cancelView.hidden=NO;
     _EmailView.hidden=YES;
     [Validation zoomIn:_AdditemsView];
 
}
-(IBAction)additemsendfun:(id)sender
{
    _AdditemsView.hidden=YES;
    _cancelView.hidden=YES;
    [self.delegate hidebolerview];
    _bolerView.hidden=YES;
    
    [NSTimer scheduledTimerWithTimeInterval:0.001
                                     target:self
                                   selector:@selector(AddItemstargetMethod:)
                                   userInfo:nil
                                    repeats:NO];
   
}
-(void)AddItemstargetMethod:(NSTimer*)timer
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
     [self addItemsExp];
}

-(void)addItemsExp
{
    
    _bolerView.hidden=YES;
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
        if([_additemsTextField.text length]==0)
        {
            self.additemsTextField.text=@"";
         
        }
        else
        {
            [SVProgressHUD show];
            NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                                       @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                       
                                       };
           
            NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
            NSString *post=[NSString stringWithFormat:@"MyOwnItem=%@&MemberID=%@",self.additemsTextField.text,arra[0]];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *jsonString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ADDITEMSOWN_URL]];
            [request setHTTPMethod:@"POST"];
            [request setAllHTTPHeaderFields:headers];
            [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
            [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
            NSURLResponse*response=nil;
            NSError*err=nil;
            NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
            if (responseData!=nil)
            { NSMutableDictionary *jsonObject= [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"jsonObject:%@",jsonObject);
              
                         [SVProgressHUD dismiss];
                
                            [self GetShoppinglist];
                            [_soppingTable reloadData];
                          [self.delegate budgeviewhide];
                          //[self shoppinglist];
                
                
            }
        }
        
        
        
        
        }
    
    
  
   
}
-(IBAction)showallDeleteMessageView:(id)sender
{
    
    if (soppinglist.count>0 || ActivatedOffersArray.count>0)
    {

         _EmailView.hidden=YES;
          _cancelView.hidden=YES;
         [self AlertviewcontrollerAllDeleteShoppingList];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Empty shopping list"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
    
}
-(IBAction)HideAllDeleteMessageView:(id)sender
{
 
      _cancelView.hidden=YES;
}
-(IBAction)allDeletebtn:(id)sender
{
    [self.delegate hidebolerview];
    _bolerView.hidden=YES;
    _cancelView.hidden=YES;
    _EmailView.hidden=YES;
    
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
    [self AlertviewcontrollerAllDeleteShoppingList];

   
}
-(void)AlldeleteShoppingListcheckdate
{
    
         checkedAll=true;
    
    // _AdditemsView.hidden=YES;
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
            [self AddOwnItemsAllRemove];
            NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                      };
            NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
            NSArray*ShoppingListItem=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:@"ShoppingListId"] valueForKey:@"ShoppingListId"];
            NSURLComponents *components = [NSURLComponents componentsWithString:ALLDELETE_URL];
            
            NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"MemberId" value:arra[0]];
            NSURLQueryItem *ShoppingListItemID = [NSURLQueryItem queryItemWithName:@"shoppinglistid" value:[NSString stringWithFormat:@"%@",ShoppingListItem[0]]];
            
            components.queryItems = @[ShoppingListItemID,LoyaltyCardNumber];
            NSURL *url = components.URL;
            
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"DELETE"];
            [request setAllHTTPHeaderFields:headers];
            [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
            NSURLResponse*response=nil;
            NSError*err=nil;
            NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
            if (responseData!=nil)
            { NSMutableDictionary *jsonObject= [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"jsonObject:%@",jsonObject);
                if ([[jsonObject valueForKey:@"errorcode"] integerValue]==0)
                {
                       [SVProgressHUD dismiss];
                       [soppinglist removeAllObjects];
                       [ActivatedOffersArray removeAllObjects];
                       [self shoppinglist];
                      [self Activatedlist];
                    //[self.delegate UpdateCircularForShopping];
                      [self.delegate shoppingTocircularAllDelete];
                   
                }
                
            }
   }
    
}
-(void)AddOwnItemsAllRemove
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
            NSURLComponents *components = [NSURLComponents componentsWithString:ALLADDOWNREMOVE_URL];
            NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"Memberid" value:arra[0]];
            components.queryItems = @[LoyaltyCardNumber];
            NSURL *url = components.URL;
            
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"DELETE"];
            [request setAllHTTPHeaderFields:headers];
            [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
            NSURLResponse*response=nil;
            NSError*err=nil;
            NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
            if (responseData!=nil)
            { NSMutableDictionary *jsonObject= [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"AddOwnItemsAllRemove:%@",jsonObject);
                if ([[jsonObject valueForKey:@"errorcode"] integerValue]==0)
                {
                    [SVProgressHUD dismiss];
                    [self shoppinglist];
                    [self.delegate UpdateCircularForShopping];
                }
                
            }
    }
    
}
-(IBAction)printbtn:(id)sender
{
    
  
         NSArray*ShopperID=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"ShopperID"];
         NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
         NSArray*storename=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"storename"];
         NSString*str=storename[0];
          NSString *newString = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
          NSString*url=[NSString stringWithFormat:@"%@memberid=%@&shopperid=%@&storename=%@",PRINTURL_URL,arra[0],ShopperID[0],newString];
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

}
NSIndexPath *indexrPath;
-(IBAction)actidetails:(UIButton*)sender
{
    if (_segControl.selectedSegmentIndex==0 || togleindxbtn==2)
    {
          UIButton*btn=(UIButton*)sender;
          CGPoint senderPosition = [btn convertPoint:CGPointZero toView:self.activatedOffersTable];
          indexrPath = [self.activatedOffersTable indexPathForRowAtPoint:senderPosition];
          [self performSegueWithIdentifier:@"SoppingDetails" sender:self];
    }
   
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
   if ([segue.identifier isEqualToString:@"SoppingDetails"])
    {
            ProductDetailsViewController*vc=segue.destinationViewController;
           // HomeViewController*vc1=segue.destinationViewController;
            vc.delegate=self;
//           // vc1.delegate=self;
      
                 vc.shoppingListdata =ActivatedOffersArray[indexrPath.row];
                   vc.comefrom=@"SoppingDetailsView";
                  vc.circheckedcouponseArry=_CirCouponseidChecked;
           
        
        
        
    }

}

-(void)UpdatedShoppingAddQtySubAqty:(NSMutableDictionary*)dict
{

    
    //   NSString*str=[NSString stringWithFormat:@"%@",dict[@"Quantity"]];
 
//    if (soppinglist.count>0)
//    {
        // NSMutableDictionary* dicts=[[NSMutableDictionary alloc] initWithDictionary:soppinglist[SelectedProductIndex]];
//        if (_segControl.selectedSegmentIndex==1)
//        {
        
        
//            NSMutableDictionary*Actdicts=[[NSMutableDictionary alloc] initWithDictionary:ActivatedOffersArray[selectindex]];
//           // [Actdicts setObject:str forKey:@"Quantity"];
//            [ActivatedOffersArray replaceObjectAtIndex:selectindex withObject:Actdicts];
//            [_activatedOffersTable reloadData];
//            NSIndexPath *indexPaths = [NSIndexPath indexPathForRow:selectindex inSection:0];
//            [_activatedOffersTable scrollToRowAtIndexPath:indexPaths
//                                         atScrollPosition:UITableViewScrollPositionNone
//                                                 animated:NO];
    
        
        
        //[self.delegate shoppingToCircularUpdateqty:dict];
            
//       for (int i=0; i<[_CirCouponseidChecked count]; i++)
//            {
//                if ([dict[@"PrimaryOfferTypeId"] integerValue]==2 ||[dict[@"PrimaryOfferTypeId"] integerValue]==3)
//                {
//                    if ([dict[@"CouponID"] integerValue]==[_CirCouponseidChecked[i][@"CouponID"] integerValue])
//                    {
//                       NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[_CirCouponseidChecked                               objectAtIndex:i]];
//                       // [Cir_Dicts setObject:str forKey:@"Quantity"];
//                        [_CirCouponseidChecked replaceObjectAtIndex:i withObject:Cir_Dicts];
//                    }
//                }
//                else
//                {
//                    if ([dict[@"UPC"] integerValue]==[_CirCouponseidChecked[i][@"UPC"] integerValue])
//                    {
//                        NSMutableDictionary *Cir_Dicts = [[NSMutableDictionary alloc] initWithDictionary:[_CirCouponseidChecked objectAtIndex:i]];
//                       // [Cir_Dicts setObject:str forKey:@"Quantity"];
//                        [_CirCouponseidChecked replaceObjectAtIndex:i withObject:Cir_Dicts];
//                    }
//
//                }
//            }
    
    
//       }
//     }
    
}
-(void)CircularToshoppingToatlQtyadd:(NSMutableDictionary*)dict
{
    [self.delegate shoppingToCircularUpdateTotalqtyadd:dict];
}
-(void)CircularToshoppingToatlQtysub:(NSMutableDictionary*)dict
{
   if ([dict[@"Quantity"] integerValue]==0)
    {
        [self removefun:dict];
        
    }
  [self.delegate shoppingToCircularUpdateTotalqtysub:dict];
}
-(void)RemoveShoppinglist:(NSMutableDictionary*)dict
{
    
    
}
-(void)removefun:(NSMutableDictionary*)dict
{
    
    [SVProgressHUD show];
    NSString*upc;
     NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                               @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                               };
    NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
    NSURLComponents *components = [NSURLComponents componentsWithString:REMOVE_URL];
    NSURLQueryItem *memberid = [NSURLQueryItem queryItemWithName:@"MemberId" value:arra[0]];
    
    for (NSString *key in [dict allKeys])
    {
        if ([key isEqualToString:@"UPC"])
        {
            upc=[NSString stringWithFormat:@"%@",dict[@"UPC"]];
        }
        else if ([key isEqualToString:@"OfferCode"])
        {
           upc=[NSString stringWithFormat:@"%@",dict[@"OfferCode"]];
        }
    }
    
    NSURLQueryItem *upcc = [NSURLQueryItem queryItemWithName:@"upccode" value:upc];
    components.queryItems = @[upcc,memberid];
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
          [SVProgressHUD dismissWithDelay:1.0];
        if ([[jsonresonse valueForKey:@"responsecode"] integerValue]==1)
        {

              [self shoppinglist];
              [self Activatedlist];
            
        }

    }
}
@end
