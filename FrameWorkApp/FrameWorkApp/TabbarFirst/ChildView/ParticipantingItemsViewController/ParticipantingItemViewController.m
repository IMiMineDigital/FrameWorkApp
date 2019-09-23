//
//  ParticipantingItemViewController.m
//  Bashas
//
//  Created by kamlesh prajapati on 9/10/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import "ParticipantingItemViewController.h"
#import "ProductDetailsViewController.h"
#import "GroupCollectionCell.h"
#import "Reachability.h"
#import "ApiHendlerClass.h"
@interface ParticipantingItemViewController ()<ProductDetailsViewControllerDelegate,ParticipantingItemViewControllerDelegate>
{
          NSMutableArray*RelatedItemsArraj;
          NSString*ClickType;
          NSArray*GroupArray;
          NSMutableArray*filterA;
          UIStoryboard*storyboard;
          NSString*ClickGroup;
          NSInteger SelectedProductIndex;
          UIView*addtolistview;
    
    
    
     NSString*UPC_CouponId;
     NSString *Actpost;
     NSInteger Groupcount;
     NSString* GroupN;
     NSString*GroupName;
    
      NSMutableArray*getShoppinglistarray;
      NSString *addtolab;
    NSInteger isactivat;
    
  
}
@end

@implementation ParticipantingItemViewController



-(void)ReletedItemsList
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
    [self relateditemscheckdate];
}
-(void)relateditemscheckdate
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
        NSURLComponents *components = [NSURLComponents componentsWithString:RELATED_ITEMS_URL];
        NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"MemberID" value:arra[0]];
        components.queryItems = @[LoyaltyCardNumber];
        NSURL *url = components.URL;
        if ([_dataDict[@"PrimaryOfferTypeId"]integerValue]==2 ||[_dataDict[@"PrimaryOfferTypeId"]integerValue]==3)
        {
            UPC_CouponId=_dataDict[@"CouponID"];
        }
        else
        {
            UPC_CouponId=_dataDict[@"UPC"];
        }
        NSString *post=[NSString stringWithFormat:@"PriceAssociationCode=%@&UPC=%@&StoreId=%@&Plateform=%@&PrimaryOfferTypeId=%@&RelevantUPC=%@",_dataDict[@"PriceAssociationCode"],UPC_CouponId,_dataDict[@"StoreID"],@"2",_dataDict[@"PrimaryOfferTypeId"],_dataDict[@"RelevantUPC"]];
     
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *jsonString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setAllHTTPHeaderFields:headers];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLResponse*response=nil;
        NSError*err=nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        if (responseData!=nil)
        {
     
            NSMutableArray *jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
           // NSLog(@"jsonObject:%@",jsonObject);
            RelatedItemsArraj=[[[NSMutableArray alloc] init] mutableCopy];
            if ([jsonObject count]!=0)
            {
                [SVProgressHUD dismissWithDelay:1.0];
                [RelatedItemsArraj addObjectsFromArray:jsonObject];
            }
            else
            {
                 [SVProgressHUD dismiss];
            }
        }
        else
        {
           [SVProgressHUD dismiss];
        }
        
    }
}
-(void)storybord
{
    if(isiPhone5s)///2
    {
        
        
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:ParticipantingItemViewController.class]];
       // NSLog(@"isiPhone5s");
       // NSString*str=_dataDict[@"Groupname"];
         if ([GroupArray count]==0)
         {
             
             
             
                _titleGroup.hidden=YES;
               _CollectionView.hidden=YES;
              NSInteger y=self.headerView.frame.origin.x+self.headerView.frame.size.height;
               [self.ParticipantingTableData setFrame:CGRectMake(self.view.frame.origin.x, y+5, self.view.frame.size.width, self.ParticipantingTableData.frame.size.height+100)];
        }
        else if ([GroupArray count]>1)
        {
            
            
            
            
             _CollectionView.hidden=YES;
             [self.ParticipantingTableData setFrame:CGRectMake(self.view.frame.origin.x, self.CollectionView.frame.origin.y, self.view.frame.size.width, self.ParticipantingTableData.frame.size.height+145)];
        }
   }
    else if(isiPhone6)
    {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main7" bundle:[NSBundle bundleForClass:ParticipantingItemViewController.class]];
       // NSLog(@"Main7");
        NSString*str=_dataDict[@"Groupname"];
          if ([GroupArray count]==0)
        {
            _titleGroup.hidden=YES;
            _CollectionView.hidden=YES;
             NSInteger y=self.headerView.frame.origin.x+self.headerView.frame.size.height;
            [self.ParticipantingTableData setFrame:CGRectMake(self.view.frame.origin.x, y+5, self.view.frame.size.width, self.ParticipantingTableData.frame.size.height+110)];
        }
          else if ([GroupArray count]>1)
        {
            _CollectionView.hidden=YES;
               [self.ParticipantingTableData setFrame:CGRectMake(self.view.frame.origin.x, self.CollectionView.frame.origin.y, self.view.frame.size.width, self.ParticipantingTableData.frame.size.height+160)];
            
        }
    }
    else if(isiPhone8Plus)
    { storyboard = [UIStoryboard storyboardWithName:@"Main8" bundle:[NSBundle bundleForClass:ParticipantingItemViewController.class]];
       // NSLog(@"Main8");
         NSString*str=_dataDict[@"Groupname"];
        if ([GroupArray count]==0)
        { _titleGroup.hidden=YES;
            _CollectionView.hidden=YES;
            NSInteger y=self.headerView.frame.origin.x+self.headerView.frame.size.height;
            [self.ParticipantingTableData setFrame:CGRectMake(self.ParticipantingTableData.frame.origin.x, y+5, self.ParticipantingTableData.frame.size.width, self.ParticipantingTableData.frame.size.height+115)];
        }
           else if ([GroupArray count]>1)
        {         _CollectionView.hidden=YES;
                  [self.ParticipantingTableData setFrame:CGRectMake(self.view.frame.origin.x, self.CollectionView.frame.origin.y, self.view.frame.size.width, self.ParticipantingTableData.frame.size.height+60)];
      
        }
   }
     else if(isiPhoneX || isiPhoneXsMax)
    { storyboard = [UIStoryboard storyboardWithName:@"MainX" bundle:[NSBundle bundleForClass:ParticipantingItemViewController.class]];
       // NSLog(@"MainX");
        NSString*str=_dataDict[@"Groupname"];
         if ([GroupArray count]==0)
        { _titleGroup.hidden=YES;
            _CollectionView.hidden=YES;
              NSInteger y=self.headerView.frame.origin.x+self.headerView.frame.size.height;
            [self.ParticipantingTableData setFrame:CGRectMake(self.view.frame.origin.x, y+5, self.view.frame.size.width, self.ParticipantingTableData.frame.size.height+160)];
        }
          else if ([GroupArray count]>1)
        {_CollectionView.hidden=YES;
            [self.ParticipantingTableData setFrame:CGRectMake(self.view.frame.origin.x, self.CollectionView.frame.origin.y, self.view.frame.size.width, self.ParticipantingTableData.frame.size.height+292)];
        }
     
    }
    else if(isiPad ||isiPadSmall)
    {
     
        
        
        
        
        
        
    }
    else
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:ParticipantingItemViewController.class]];
       // NSLog(@"Main");
         NSString*str=_dataDict[@"Groupname"];
        if ([GroupArray count]==0)
        {_titleGroup.hidden=YES;
            _CollectionView.hidden=YES;
            NSInteger y=self.headerView.frame.origin.x+self.headerView.frame.size.height;
            [self.ParticipantingTableData setFrame:CGRectMake(self.view.frame.origin.x, y+5, self.view.frame.size.width, self.ParticipantingTableData.frame.size.height+100)];
        }
          else if ([GroupArray count]>1)
        { _CollectionView.hidden=YES;
             [self.ParticipantingTableData setFrame:CGRectMake(self.view.frame.origin.x, self.CollectionView.frame.origin.y, self.view.frame.size.width, self.ParticipantingTableData.frame.size.height+145)];
        }

        
    }
}
- (void)viewDidLoad
{
    
      [super viewDidLoad];

       [[self navigationController] setNavigationBarHidden:YES animated:YES];
       [self.ParticipantingTableData setSeparatorStyle:UITableViewCellSeparatorStyleNone];
       UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
       [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
       [_ParticipantingTableData addSubview:refreshControl];
      // [self GetGroupName];
      // [self storybord];
      // [self ReletedItemsList];
         GroupN=@"";
      // [self FirstArrayGroup];
     ////[self maindata];
      [Validation addShadowToView:_headerView];
      [self headeractivatebtnfun];
      [self storybord];
      [self mainfun];
       [Validation addShadowToView:self.Activateview];
      isactivat=0;
    NSLog(@"comefrom:%@",_comefrom);
    if ([[_dataDict valueForKey:@"PrimaryOfferTypeId"] integerValue]==1)
    {
        _Activateview.hidden=YES;
    }
    else
    {
         _Activateview.hidden=NO;
    }
}
- (void) tapped
{
    [self.view endEditing:YES];
  //  addtolistview.hidden=YES;
}
-(void)mainfun
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         [self GetGroupName];
         [self ReletedItemsList];
         [self FirstArrayGroup];
           dispatch_async(dispatch_get_main_queue(), ^{
             [self->_ParticipantingTableData reloadData];
        });

    });
    
}
-(IBAction)activatebtnheader:(id)sender
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
           ClickType=@"2";
        [self activatedHeaderbutton:ClickType];
    }
   
}

-(void)activatedheaderbuttonIndex:(NSInteger)index parameters:(NSString*)parameters
{
     NSMutableDictionary*dicts;
     NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                               @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                               };
    
    GroupName=_dataDict[@"Groupname"];
 
    NSData *postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
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
        NSLog(@"jsonresonse:%@",jsonresonse);
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
        {
            _product_titleactivelab.text=@"Activated";
            _activeimg.hidden=NO;
            _activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
            _ActivateheaderBtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
        
            if ([_comefrom isEqualToString:@"Cicular"])
            {
                if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                {

                    [self.Delegate BackActivateFuc:RelatedItemsArraj[index] backdatadict:_dataDict];
                }
                else
                {

                    [self.Delegate BackActivateFuc:filterA[index] backdatadict:_dataDict];
                }

            }
            else if ([_comefrom isEqualToString:@"SoppingDeatils"])
            {
                    NSLog(@"_comefrom:%@",_comefrom);
                
            }
                 
            
         
        }
    }
    

    
}
//only header activated click
-(void)activatedHeaderbutton:(NSString*)clicktype
{
    
    NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                               @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                               };
    GroupName=_dataDict[@"Groupname"];
    NSArray*memberid=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
    NSString*str=[NSString stringWithFormat:@"UPCCode=%@&CategoryID=%@&SalePrice=%@&PrimaryOfferTypeId=%@&OfferDetailId=%@&PersonalCircularID=%@&ExpirationDate=%@&ClientID=%@&PackagingSize=%@&DisplayPrice=%@&RelevantUPC=%@&Description=%@&SpecialInformation=%@&CouponID=%@&MemberID=%@&DeviceId=%@&OPMOfferID=%@&iPositionID=%@&PageID=%@&ClickType=%@&Savings=%@&AdPrice=%@&RegPrice=%@",_dataDict[@"UPC"],_dataDict[@"CategoryID"],_dataDict[@"FinalPrice"],_dataDict[@"PrimaryOfferTypeId"],_dataDict[@"OfferDetailId"],_dataDict[@"PersonalCircularID"],_dataDict[@"ValidityEndDate"],@"1",_dataDict[@"PackagingSize"],_dataDict[@"DisplayPrice"],_dataDict[@"RelevantUPC"],_dataDict[@"Description"],_dataDict[@"SpecialInformation"],_dataDict[@"CouponID"],memberid[0],@"1",_dataDict[@"PricingMasterID"],_dataDict[@"TileNumber"],_dataDict[@"PageID"],clicktype,_dataDict[@"Savings"],_dataDict[@"AdPrice"],_dataDict[@"RegularPrice"]];
    
    NSData *postData = [str dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
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
        NSLog(@"jsonresonse:%@",jsonresonse);
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
        {
            if (![_comefrom isEqualToString:@"Deatils"])
           {
            [self.Delegate RelatedHeaderActivateToCircular:_dataDict];
           }
           else if ([_comefrom isEqualToString:@"SoppingDeatils"])
           {
               
           }
            else
            {
              [self.Delegate DetailToRelatedsBack:_dataDict];
            }
            
            if ([GroupName isEqualToString:@""])
            {
                for (int i=0; i<RelatedItemsArraj.count; i++)
                {
                    NSMutableDictionary*dicts=[[NSMutableDictionary alloc] initWithDictionary:RelatedItemsArraj[i]];
                    [dicts setObject:@"1" forKey:@"ClickCount"];
                    [RelatedItemsArraj replaceObjectAtIndex:i withObject:dicts];
                }
                
            }
            else
            {
                for (int i=0; i<filterA.count; i++)
                {
                    NSMutableDictionary*dicts=[[NSMutableDictionary alloc] initWithDictionary:filterA[i]];
                    [dicts setObject:@"1" forKey:@"ClickCount"];
                    [filterA replaceObjectAtIndex:i withObject:dicts];
                }
            }
            
            
            
            _product_titleactivelab.text=@"Activated";
            _activeimg.hidden=NO;
            _activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
            _ActivateheaderBtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
        }
    }
    
}
-(void)headeractivatebtnfun
{
if ([_dataDict[@"PrimaryOfferTypeId"] integerValue]==1)
{
    
     _Headerstitle.text=@"Varieties";
      [Validation setRoundView:_ActivateheaderBtn borderWidth:0 borderColor:nil radius:2];
}
else if ([_dataDict[@"PrimaryOfferTypeId"] integerValue]==2)
{
            [self showingHeaderActivate:_dataDict];
               _Headerstitle.text=@"Participating Items";
}
else if ([_dataDict[@"PrimaryOfferTypeId"] integerValue]==3)
{
     [self showingHeaderActivate:_dataDict];
     _Headerstitle.text=@"Varieties";
 }
    
}
-(void)showingHeaderActivate:(NSMutableDictionary*)dict
{
   
     NSBundle *bundle = [NSBundle bundleForClass:[self class]];
     if ([[_dataDict valueForKey:@"PrimaryOfferTypeId"] integerValue]==3 || [[_dataDict valueForKey:@"PrimaryOfferTypeId"] integerValue]==2)
    {
        
        if ([[_dataDict valueForKey:@"ClickCount"] integerValue]==1)
        {
              _product_titleactivelab.text=@"Activated";
              _activeimg.hidden=NO;
              _ActivateheaderBtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
              _activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
        }
        else
        {
      
            _ActivateheaderBtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
            _product_titleactivelab.text=@"Activate";
            _activeimg.hidden=YES;
        }
        
    }
    else
    {
         _Activateview.hidden=YES;
    }
     [Validation setRoundView:self.ActivateheaderBtn borderWidth:0 borderColor:nil radius:_ActivateheaderBtn.layer.frame.size.height/2];
    
}
-(void)GetGroupName
{
    
    
    
        GroupArray=[[NSArray alloc] init];
       GroupName=_dataDict[@"Groupname"];
    if ([[GroupName componentsSeparatedByString:@","] count]>1) {
        
    
       if (![GroupName isEqualToString:@""] || GroupName==nil)
        {
            GroupArray=[GroupName componentsSeparatedByString:@","];
        }
    }
      //NSLog(@"GroupArraycount:%d",GroupArray.count);
}
- (void)handleRefresh:(UIRefreshControl *)sender
{
    [sender endRefreshing];
    [_ParticipantingTableData reloadData];

}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:( NSIndexPath *)indexPath
{
    return 500;
    
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([_dataDict[@"Groupname"] isEqualToString:@""])
    {
        return [RelatedItemsArraj count];
    }
    else
    {
        
        if ([ClickGroup isEqualToString:@"click"])
        {
            return [filterA count];
        }
        else
        {
            return [filterA count];
        }
    }

    return 0;
}
-(IBAction)backbtn:(id)sender
{
    //backup updates
    
    if ([_iscontrollercheckback isEqualToString:@"iscircularcontroller"])
    {
         [self.navigationController popViewControllerAnimated:YES];
    }
    else if([_comefrom isEqualToString:@"Deatils"])
    {
       [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath
{
    static NSString*CellIdentifier=@"ParticipntingItemCell";
     ParticipntingItemCell*celle=(ParticipntingItemCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (celle==nil)
    {[tableView registerNib:[UINib nibWithNibName:@"ParticipntingItemCell" bundle:[NSBundle bundleForClass:ParticipntingItemCell.class]] forCellReuseIdentifier:CellIdentifier];
         celle=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
//    [addtolistview addSubview:celle];
  //  addtolistview=celle.addtolistview;
    celle.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([_dataDict[@"Groupname"] isEqualToString:@""] || GroupArray.count==1)
    {
            NSMutableDictionary*celldata=RelatedItemsArraj[indexPath.row];
        //[self SetparticipantingCelldata:celldata index:indexPath.row cell:celle];
           [celle cellOnData:celldata participantingItemViewController:self index1:indexPath.row];
    }
    else
    {     NSMutableDictionary*celldata=filterA[indexPath.row];
        //[self SetparticipantingCelldata:celldata index:indexPath.row cell:celle];
        [celle cellOnData:celldata participantingItemViewController:self index1:indexPath.row];
    }

     return celle;
}

-(void)SetparticipantingCelldata:(NSMutableDictionary*)celldata index:(NSInteger)index  cell:(ParticipntingItemCell*)cell
{

//        [cell cellOnData:celldata participantingItemViewController:self index1:index];
}
//+

-(void)addproduct:(NSInteger)index
{
    
    NSString *upc;
    NSInteger count;
    NSString* quantity;
    NSString* parametrs;
    //add
   if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==NotReachable)
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
        
        NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
        NSLog(@"count:%@",RelatedItemsArraj[index][@"Quantity"]);
        GroupName=_dataDict[@"Groupname"];
        if ([GroupName isEqualToString:@""] || GroupArray.count==1)
        {
             upc =RelatedItemsArraj[index][@"UPC"];
            count=[RelatedItemsArraj[index][@"Quantity"] integerValue];
            if (count==0)
            {
                
             parametrs=[NSString stringWithFormat:@"UPCCode=%@&CategoryID=%@&SalePrice=%@&PrimaryOfferTypeId=%@&OfferDetailId=%@&PersonalCircularID=%@&ExpirationDate=%@&ClientID=%@&PackagingSize=%@&DisplayPrice=%@&RelevantUPC=%@&Description=%@&SpecialInformation=%@&CouponID=%@&MemberID=%@&DeviceId=%@&OPMOfferID=%@&iPositionID=%@&PageID=%@&ClickType=%@&Savings=%@&AdPrice=%@&RegPrice=%@",RelatedItemsArraj[index][@"UPC"],RelatedItemsArraj[index][@"CategoryID"],RelatedItemsArraj[index][@"FinalPrice"],RelatedItemsArraj[index][@"PrimaryOfferTypeId"],RelatedItemsArraj[index][@"OfferDetailId"],RelatedItemsArraj[index][@"PersonalCircularID"],RelatedItemsArraj[index][@"ValidityEndDate"],@"1",RelatedItemsArraj[index][@"PackagingSize"],RelatedItemsArraj[index][@"DisplayPrice"],RelatedItemsArraj[index][@"RelevantUPC"],RelatedItemsArraj[index][@"Description"],RelatedItemsArraj[index][@"SpecialInformation"],RelatedItemsArraj[index][@"CouponID"],arra[0],@"1",RelatedItemsArraj[index][@"PricingMasterID"],RelatedItemsArraj[index][@"TileNumber"],RelatedItemsArraj[index] [@"PageID"],@"1",RelatedItemsArraj[index][@"Savings"],RelatedItemsArraj[index][@"AdPrice"],RelatedItemsArraj[index][@"RegularPrice"]];
               [self activatedheaderbuttonIndex:index parameters:parametrs];
                
               
        
                if ([_comefrom isEqualToString:@"Deatils"])
                {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [self.Delegate DetailToRelatedsshoppinglistcount];
                    });
                }
               else if ([_comefrom isEqualToString:@"SoppingDeatils"])
               {
                       NSLog(@"_comefrom:%@",_comefrom);
                     [self.Delegate shoppingViewListApi];
               }
               else
                {
                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [self.Delegate shoppinglistcount];
                    });
               }
           }
          
            if (count>0 || count==0)
            {
                count++;
                NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:RelatedItemsArraj[index]];
                [dict setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Quantity"];
                [RelatedItemsArraj replaceObjectAtIndex:index withObject:dict];
                quantity=RelatedItemsArraj[index][@"Quantity"];
            }
            


            
       }
        else
        {
          
            upc =filterA[index][@"UPC"];
            count=[filterA[index][@"Quantity"] integerValue];
            if (count==0)
            {
         parametrs=[NSString stringWithFormat:@"UPCCode=%@&CategoryID=%@&SalePrice=%@&PrimaryOfferTypeId=%@&OfferDetailId=%@&PersonalCircularID=%@&ExpirationDate=%@&ClientID=%@&PackagingSize=%@&DisplayPrice=%@&RelevantUPC=%@&Description=%@&SpecialInformation=%@&CouponID=%@&MemberID=%@&DeviceId=%@&OPMOfferID=%@&iPositionID=%@&PageID=%@&ClickType=%@&Savings=%@&AdPrice=%@&RegPrice=%@",filterA[index][@"UPC"],filterA[index][@"CategoryID"],filterA[index][@"FinalPrice"],filterA[index][@"PrimaryOfferTypeId"],filterA[index][@"OfferDetailId"],filterA[index][@"PersonalCircularID"],filterA[index][@"ValidityEndDate"],@"1",filterA[index][@"PackagingSize"],filterA[index][@"DisplayPrice"],filterA[index][@"RelevantUPC"],filterA[index][@"Description"],filterA[index][@"SpecialInformation"],filterA[index][@"CouponID"],arra[0],@"1",filterA[index][@"PricingMasterID"],filterA[index][@"TileNumber"],filterA[index][@"PageID"],@"1",filterA[index][@"Savings"],filterA[index][@"AdPrice"],filterA[index][@"RegularPrice"]];
              [self activatedheaderbuttonIndex:index parameters:parametrs];
                  if ([_comefrom isEqualToString:@"Deatils"])
                 {
                      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                         [self.Delegate DetailToRelatedsshoppinglistcount];
                     });

               }
                else if ([_comefrom isEqualToString:@"SoppingDeatils"])
                {
                    NSLog(@"_comefrom:%@",_comefrom);
                    [self.Delegate shoppingViewListApi];
                }
                else
                {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       [self.Delegate shoppinglistcount];
                    });
                }
         
              
               
            }
            if (count>0 || count==0)
            {
                count++;
                NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:filterA[index]];
                [dict setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Quantity"];
                [filterA replaceObjectAtIndex:index withObject:dict];
                quantity=filterA[index][@"Quantity"];
         
            }
          
        }
        NSDictionary *profile = @{@"ShoppingListItems":@[@{@"UPC":upc,@"Quantity":quantity,@"DateAddedOn":@"12/7/2018 10:53:31 PM"}]};
      
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:profile options:0 error:NULL];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString*finaljson=[NSString stringWithFormat:@"'%@'",jsonString];
       // NSLog(@"finaljson %@",finaljson);
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
                
                
                if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                {

                    NSMutableDictionary* dicts=[[NSMutableDictionary alloc] initWithDictionary:RelatedItemsArraj[index]];
                    [dicts setObject:@"1" forKey:@"ClickCount"];
                    [RelatedItemsArraj replaceObjectAtIndex:index withObject:dicts];
                }
                else
                {

                    NSMutableDictionary* dicts=[[NSMutableDictionary alloc] initWithDictionary:filterA[index]];
                    [dicts setObject:@"1" forKey:@"ClickCount"];
                    [filterA replaceObjectAtIndex:index withObject:dicts];


                }

                [UIView setAnimationsEnabled:NO];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                [_ParticipantingTableData beginUpdates];
                [_ParticipantingTableData reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                                                withRowAnimation:UITableViewRowAnimationNone];
                [_ParticipantingTableData endUpdates];
                
            
                
             if ([_comefrom isEqualToString:@"Cicular"])
                {
                    
                    
                    if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                    {

                         [self.Delegate BackActivateFuc:RelatedItemsArraj[index] backdatadict:_dataDict];
                         [self.Delegate AddRelatedCountToatalQty:RelatedItemsArraj[index]];
                    }
                    else
                    {

                          [self.Delegate BackActivateFuc:filterA[index] backdatadict:_dataDict];
                          [self.Delegate AddRelatedCountToatalQty:filterA[index]];
                    }

                }
                else if ([_comefrom isEqualToString:@"Deatils"])
                {
                    
                         if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                          {
                               [self.Delegate DetailToRelatedsAddqty:RelatedItemsArraj[index]];
                               [self.Delegate DetailsToRelatedTotalQtyAdd:RelatedItemsArraj[index]];
                          }
                        else
                        {
                              [self.Delegate DetailToRelatedsAddqty:filterA[index]];
                              [self.Delegate DetailsToRelatedTotalQtyAdd:filterA[index]];
                        }
                }
                else if ([_comefrom isEqualToString:@"SoppingDeatils"])
                {
                    
                    
                      if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                      {
                         [self.Delegate ShoppingViewListUpdateAdd:RelatedItemsArraj[index]];
                      }
                     else
                      {
                         [self.Delegate ShoppingViewListUpdateAdd:filterA[index]];
                      }
                   
                
                }
               
               else
                {
                    if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                    {
                        [self.Delegate DetailToRelatedsAddqty:RelatedItemsArraj[index]];
                        [self.Delegate DetailsToRelatedTotalQtyAdd:RelatedItemsArraj[index]];
                    }
                    else
                    {
                        [self.Delegate DetailToRelatedsAddqty:filterA[index]];
                        [self.Delegate DetailsToRelatedTotalQtyAdd:filterA[index]];
                    }
                }

           }
        }
    }
}
-(void)shoppinglistviewpage
{
  [self.Delegate shoppingViewListApi];
}
-(void)shoppinglistViewpageAdd:(NSMutableDictionary*)dicts
{
          NSString*str=[NSString stringWithFormat:@"%@",dicts[@"Quantity"]];
    if ([GroupName isEqualToString:@""] || GroupArray.count==1)
    {
        if ([dicts[@"PrimaryOfferTypeId"] integerValue]==3 ||[dicts[@"PrimaryOfferTypeId"] integerValue]==2)
        {
            dicts=[[RelatedItemsArraj objectAtIndex:SelectedProductIndex] mutableCopy];
            [dicts setObject:@"1" forKey:@"ListCount"];
            [dicts setObject:@"1" forKey:@"ClickCount"];
            [dicts setObject:str forKey:@"Quantity"];
            [RelatedItemsArraj replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
            [_ParticipantingTableData reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
            [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                            atScrollPosition:UITableViewScrollPositionTop
                                                    animated:YES];
            
        }
        else
        {
            dicts=[[RelatedItemsArraj objectAtIndex:SelectedProductIndex] mutableCopy];
            [dicts setObject:@"1" forKey:@"ListCount"];
            // [dict setObject:str forKey:@"Quantity"];
            [RelatedItemsArraj replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
            [_ParticipantingTableData reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
            [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                            atScrollPosition:UITableViewScrollPositionTop
                                                    animated:YES];
        }
    }
    else
    {
        if ([dicts[@"PrimaryOfferTypeId"] integerValue]==3 ||[dicts[@"PrimaryOfferTypeId"] integerValue]==2)
        {
            dicts=[[filterA objectAtIndex:SelectedProductIndex] mutableCopy];
            [dicts setObject:@"1" forKey:@"ListCount"];
            [dicts setObject:@"1" forKey:@"ClickCount"];
            [dicts setObject:str forKey:@"Quantity"];
            [filterA replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
            [_ParticipantingTableData reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
            [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                            atScrollPosition:UITableViewScrollPositionTop
                                                    animated:YES];
            
        }
        else
        {
            dicts=[[filterA objectAtIndex:SelectedProductIndex] mutableCopy];
            [dicts setObject:@"1" forKey:@"ListCount"];
            // [dict setObject:str forKey:@"Quantity"];
            [filterA replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
            [_ParticipantingTableData reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
            [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                            atScrollPosition:UITableViewScrollPositionTop
                                                    animated:YES];
        }
    }
    
    
    
    
    
    
   [self.Delegate ShoppingViewListUpdateAdd:dicts];
}
-(void)shoppinglistViewpageSub:(NSMutableDictionary*)dicts
{
      NSString*str=[NSString stringWithFormat:@"%@",dicts[@"Quantity"]];
    if ([GroupName isEqualToString:@""] || GroupArray.count==1)
    {
        if ([dicts[@"PrimaryOfferTypeId"] integerValue]==3 ||[dicts[@"PrimaryOfferTypeId"] integerValue]==2)
        {
            dicts=[[RelatedItemsArraj objectAtIndex:SelectedProductIndex] mutableCopy];
            [dicts setObject:@"1" forKey:@"ListCount"];
            [dicts setObject:@"1" forKey:@"ClickCount"];
            [dicts setObject:str forKey:@"Quantity"];
            [RelatedItemsArraj replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
            [_ParticipantingTableData reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
            [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                            atScrollPosition:UITableViewScrollPositionTop
                                                    animated:YES];
            
        }
        else
        {
            dicts=[[RelatedItemsArraj objectAtIndex:SelectedProductIndex] mutableCopy];
            [dicts setObject:@"1" forKey:@"ListCount"];
            // [dict setObject:str forKey:@"Quantity"];
            [RelatedItemsArraj replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
            [_ParticipantingTableData reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
            [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                            atScrollPosition:UITableViewScrollPositionTop
                                                    animated:YES];
        }
    }
    else
    {
        if ([dicts[@"PrimaryOfferTypeId"] integerValue]==3 ||[dicts[@"PrimaryOfferTypeId"] integerValue]==2)
        {
            dicts=[[filterA objectAtIndex:SelectedProductIndex] mutableCopy];
            [dicts setObject:@"1" forKey:@"ListCount"];
            [dicts setObject:@"1" forKey:@"ClickCount"];
            [dicts setObject:str forKey:@"Quantity"];
            [filterA replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
            [_ParticipantingTableData reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
            [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                            atScrollPosition:UITableViewScrollPositionTop
                                                    animated:YES];
            
        }
        else
        {
            dicts=[[filterA objectAtIndex:SelectedProductIndex] mutableCopy];
            [dicts setObject:@"1" forKey:@"ListCount"];
            // [dict setObject:str forKey:@"Quantity"];
            [filterA replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
            [_ParticipantingTableData reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
            [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                            atScrollPosition:UITableViewScrollPositionTop
                                                    animated:YES];
        }
    }
    
    
    
   [self.Delegate ShoppingViewListUpdateSub:dicts];
}






-(void)AddTotalqty:(NSMutableDictionary*)dict
{
  
   [self.Delegate AddRelatedCountToatalQty:dict];
    
}
-(void)SubTotalqty:(NSMutableDictionary*)dict
{
      [self.Delegate SubRelatedCountToatalQty:dict];
}
-(void)DetailsRelatedDetailsShoppinglist
{
    
    
     [self.Delegate  shoppinglistcount];
  
}
//Details to related to deatils to circular
-(void)DeatilsShoppinglistcount
{
    
    [self.Delegate DetailToRelatedsshoppinglistcount];
    
    
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
         GroupName=_dataDict[@"Groupname"];
        if ([GroupName isEqualToString:@""])
        {  NSMutableDictionary *strDict = [[NSMutableDictionary alloc] initWithDictionary:[RelatedItemsArraj objectAtIndex:index]];
            upc =RelatedItemsArraj[index][@"UPC"];
            count=[RelatedItemsArraj[index][@"Quantity"] integerValue];
            if (count==1)
            {
               
               if ([_comefrom isEqualToString:@"Deatils"])
                {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [self.Delegate DetailToRelatedsshoppinglistcount];
                    });
                     [self Removeprouct:index];
                }
               else if ([_comefrom isEqualToString:@"SoppingDeatils"])
               {
                   
               }
               else if ([_comefrom isEqualToString:@"ParticipantingDeatilsView"])
               {
                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       [self.Delegate DetailToRelatedsshoppinglistcount];
                   });
                     [self Removeprouct:index];
               }
           
                else
                {
                    //circular
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [self.Delegate shoppinglistcount];
                    });
                }
                  [self Removeprouct:index];
            }
            
             if (count>0)
             {
                count--;
                NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:strDict];
                [dict setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Quantity"];
                strDict=dict;
                [RelatedItemsArraj replaceObjectAtIndex:index withObject:strDict];
                 quantity=RelatedItemsArraj[index][@"Quantity"];
                 [self subproducts:upc quantity:quantity index:index];
            }
       }
        else
        {
            NSMutableDictionary *strDict = [[NSMutableDictionary alloc] initWithDictionary:[filterA objectAtIndex:index]];
            upc =filterA[index][@"UPC"];
            count=[filterA[index][@"Quantity"] integerValue];
            if (count==1)
            {
                [self Removeprouct:index];
                if ([_comefrom isEqualToString:@"Deatils"])
                {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [self.Delegate DetailToRelatedsshoppinglistcount];
                    });
                }
                else if ([_comefrom isEqualToString:@"SoppingDeatils"])
                {
                   
                }
                
                else
                {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [self.Delegate shoppinglistcount];
                    });
               }
            }
            if (count>0)
            {
                count--;
                NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:strDict];
                [dict setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Quantity"];
                strDict=dict;
                [filterA replaceObjectAtIndex:index withObject:strDict];
                 quantity=filterA[index][@"Quantity"];
                [self subproducts:upc quantity:quantity index:index];
            }
        }
     }
}
-(void)subproducts:(NSString*)upc quantity:(NSString*)quantity index:(NSInteger)index
{
   
    GroupName=_dataDict[@"Groupname"];
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                               };
    NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
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
        NSLog(@"jsonresonse:%@",jsonresonse);
        if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
        {
            
            
            if ([_comefrom isEqualToString:@"Cicular"])
             {
                  if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                    {

                         [self.Delegate BackActivateFuc:RelatedItemsArraj[index] backdatadict:_dataDict];
                         [self.Delegate SubRelatedCountToatalQty:RelatedItemsArraj[index]];
                    }
                  else
                  {

                       [self.Delegate BackActivateFuc:filterA[index] backdatadict:_dataDict];
                       [self.Delegate SubRelatedCountToatalQty:filterA[index]];
                  }
                 
            }
            else if ([_comefrom isEqualToString:@"SoppingDeatils"])
            {
              
                            if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                            {
                                [self.Delegate ShoppingViewListUpdateSub:RelatedItemsArraj[index]];
                            }
                            else
                            {
                                 [self.Delegate ShoppingViewListUpdateSub:filterA[index]];
                            }
                
                
            }
               else if ([_comefrom isEqualToString:@"Deatils"])
               {
                   if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                   {
                       [self.Delegate DetailToRelatedsAddqty:RelatedItemsArraj[index]];
                       [self.Delegate DetailsToRelatedTotalQtySub:RelatedItemsArraj[index]];
                   }
                   else
                   {
                       [self.Delegate DetailToRelatedsAddqty:filterA[index]];
                       [self.Delegate DetailsToRelatedTotalQtySub:filterA[index]];
                   }
                   
               }
          
            else
            {
                
                
                if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                {
                    [self.Delegate DetailToRelatedsAddqty:RelatedItemsArraj[index]];
                    [self.Delegate DetailsToRelatedTotalQtySub:RelatedItemsArraj[index]];
                }
                else
                {
                    [self.Delegate DetailToRelatedsAddqty:filterA[index]];
                    [self.Delegate DetailsToRelatedTotalQtySub:filterA[index]];
                }

            }
            [UIView setAnimationsEnabled:NO];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [_ParticipantingTableData beginUpdates];
            [_ParticipantingTableData reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                                            withRowAnimation:UITableViewRowAnimationNone];
            [_ParticipantingTableData endUpdates];
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
        GroupName=_dataDict[@"Groupname"];
        if ([GroupName isEqualToString:@""] || GroupArray.count==1)
        {
            upc = [NSURLQueryItem queryItemWithName:@"upccode" value:RelatedItemsArraj[index][@"UPC"]];
        }
        else
        {
             upc = [NSURLQueryItem queryItemWithName:@"upccode" value:filterA[index][@"UPC"]];
        }
        NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                                   @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                   };
         NSURLComponents *components = [NSURLComponents componentsWithString:REMOVE_URL];
        NSURLQueryItem *memberid = [NSURLQueryItem queryItemWithName:@"MemberId" value:arra[0]];
        components.queryItems = @[upc,memberid];
        NSURL *url = components.URL;
       // NSLog(@"url:%@",url);
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
            if ([[jsonresonse valueForKey:@"responsecode"] integerValue]==1)
            {
                 if ([_comefrom isEqualToString:@"Deatils"])
                 {
                 
                     GroupName=_dataDict[@"Groupname"];
                     if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                     {
                       [self.Delegate DetailToRelatedsRemoveBack:RelatedItemsArraj[index]];
                     }
                     else
                     {
                        [self.Delegate DetailToRelatedsRemoveBack:filterA[index]];
                     }
                 }
                 else if ([_comefrom isEqualToString:@"SoppingDeatils"])
                 {
                     
                 }
                else
                {
                    NSMutableDictionary*dict;
                    GroupName=_dataDict[@"Groupname"];
                    if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                    {
                        dict=[[NSMutableDictionary alloc] initWithDictionary:RelatedItemsArraj[index]];
                        [dict setObject:@"0" forKey:@"ListCount"];
                        [dict setObject:@"0" forKey:@"Quantity"];
                        [RelatedItemsArraj replaceObjectAtIndex:index withObject:dict];
                        [self.Delegate BackRemoveQuantity:RelatedItemsArraj[index]];
                        
                    }
                    else
                    {
                        dict=[[NSMutableDictionary alloc] initWithDictionary:filterA[index]];
                        [dict setObject:@"0" forKey:@"ListCount"];
                        [dict setObject:@"0" forKey:@"Quantity"];
                        [filterA replaceObjectAtIndex:index withObject:dict];
                        [self.Delegate BackRemoveQuantity:filterA[index]];
                    }
                }
             
                
                
                
               
            }
        }
    }
    
}
-(void)openDetails:(NSInteger)index
{
    SelectedProductIndex=index;
    [self performSegueWithIdentifier:@"ProductDetailsViewController" sender:self];
}
// details page activate Related items and circular
-(void)backActivateParticipanting:(NSMutableDictionary*)dict
{
    
    
     NSLog(@"_comefrom:%@",_comefrom);
    
    
    NSString*str=[NSString stringWithFormat:@"%@",dict[@"Quantity"]];
     GroupName=_dataDict[@"Groupname"];
     if ([GroupName isEqualToString:@""] || GroupArray.count==1)
        {
                  if ([dict[@"PrimaryOfferTypeId"] integerValue]==3 ||[dict[@"PrimaryOfferTypeId"] integerValue]==2)
                    {
                          dict=[[RelatedItemsArraj objectAtIndex:SelectedProductIndex] mutableCopy];
                          [dict setObject:@"1" forKey:@"ListCount"];
                          [dict setObject:@"1" forKey:@"ClickCount"];
                           [dict setObject:str forKey:@"Quantity"];
                          [RelatedItemsArraj replaceObjectAtIndex:SelectedProductIndex withObject:dict];
                          [_ParticipantingTableData reloadData];
                          NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
                          [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                                        atScrollPosition:UITableViewScrollPositionTop
                                                                animated:YES];
                        
                    }
                    else
                    {
                         dict=[[RelatedItemsArraj objectAtIndex:SelectedProductIndex] mutableCopy];
                        [dict setObject:@"1" forKey:@"ListCount"];
                         // [dict setObject:str forKey:@"Quantity"];
                        [RelatedItemsArraj replaceObjectAtIndex:SelectedProductIndex withObject:dict];
                        [_ParticipantingTableData reloadData];
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
                        [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                                        atScrollPosition:UITableViewScrollPositionTop
                                                                animated:YES];
                    }
   }
    else
    {
        if ([dict[@"PrimaryOfferTypeId"] integerValue]==3 ||[dict[@"PrimaryOfferTypeId"] integerValue]==2)
        {
            dict=[[filterA objectAtIndex:SelectedProductIndex] mutableCopy];
            [dict setObject:@"1" forKey:@"ListCount"];
            [dict setObject:@"1" forKey:@"ClickCount"];
             [dict setObject:str forKey:@"Quantity"];
            [filterA replaceObjectAtIndex:SelectedProductIndex withObject:dict];
            [_ParticipantingTableData reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
            [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                            atScrollPosition:UITableViewScrollPositionTop
                                                    animated:YES];
            
        }
        else
        {
            dict=[[filterA objectAtIndex:SelectedProductIndex] mutableCopy];
            [dict setObject:@"1" forKey:@"ListCount"];
              [dict setObject:str forKey:@"Quantity"];
            [filterA replaceObjectAtIndex:SelectedProductIndex withObject:dict];
            [_ParticipantingTableData reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:SelectedProductIndex inSection:0];
            [_ParticipantingTableData scrollToRowAtIndexPath:indexPath
                                            atScrollPosition:UITableViewScrollPositionTop
                                                    animated:YES];
        }
  }
    
    
  if ([_comefrom isEqualToString:@"Cicular"])
    {
        
        
                   if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                    {
                       
                        [self.Delegate BackActivateFuc:RelatedItemsArraj[SelectedProductIndex] backdatadict:_dataDict];
                        
                    }
                    else
                    {
                     
                        [self.Delegate BackActivateFuc:filterA[SelectedProductIndex] backdatadict:_dataDict];
                        
                        
                    }

   }
    else if ([_comefrom isEqualToString:@"Deatils"])
    {
        
            
            //ParticipantingotherView
        if ([GroupName isEqualToString:@""] || GroupArray.count==1)
        {
            
            [self.Delegate DetailToRelatedsAddqty:RelatedItemsArraj[SelectedProductIndex]];
            
        }
        else
        {
            [self.Delegate DetailToRelatedsAddqty:filterA[SelectedProductIndex]];
            
        }
    }
   else
   {
       
       
       if ([GroupName isEqualToString:@""] || GroupArray.count==1)
       {
           [self.Delegate DetailToRelatedsBack:RelatedItemsArraj[SelectedProductIndex]];
       }
       else
       {
           [self.Delegate DetailToRelatedsBack:filterA[SelectedProductIndex]];
       }
   }
    
   
 
}
-(void)DetaileRelatedDetaileToUpdatedCircularAdd:(NSMutableDictionary*)dict
{
    NSInteger count=[_dataDict[@"ClickCount"] integerValue];
    if (count==0)
    {
        ClickType=@"2";
        [self activatedHeaderbutton:ClickType];
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        _product_titleactivelab.text=@"Activated";
        _activeimg.hidden=NO;
        _activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
        _ActivateheaderBtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
    }
  
   if ([_comefrom isEqualToString:@"Deatils"])
    {
        
        
        //ParticipantingotherView
        
        if ([GroupName isEqualToString:@""] || GroupArray.count==1)
        {
            [self.Delegate DetailsToRelatedTotalQtyAdd:RelatedItemsArraj[SelectedProductIndex]];
        }
        else
        {
          
            [self.Delegate DetailsToRelatedTotalQtyAdd:filterA[SelectedProductIndex]];
        }
        
        
        
    }
  
    
}
-(void)DetaileRelatedDetaileToUpdatedCircularSub:(NSMutableDictionary*)dict
{
    
    if ([_comefrom isEqualToString:@"Deatils"])
    {
        
        
        //ParticipantingotherView
        
        if ([GroupName isEqualToString:@""] || GroupArray.count==1)
        {
           [self.Delegate DetailsToRelatedTotalQtySub:RelatedItemsArraj[SelectedProductIndex]];
        }
        else
        {
          
            [self.Delegate DetailsToRelatedTotalQtySub:filterA[SelectedProductIndex]];
        }
        
        
        
    }
    
    
}
//-(void)RelatedItems:(NSInteger)index
//{
//    
//}
-(void)FirstArrayGroup
{
    
    
    filterA=[[NSMutableArray alloc] init];
    for ( int i=0; i<[RelatedItemsArraj count]; i++)
    {
        
//        if ([@"A" isEqualToString:RelatedItemsArraj[i][@"Filter"]])
         if (GroupArray.count>1)
        {
             ClickGroup=@"click";
            NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:RelatedItemsArraj[i]];
            [filterA  addObject:dict];
        }
        
     //[_ParticipantingTableData reloadData];
  }
  
}
// details page remove quantity
-(void)removeQuantityRelatedFromDetailspage:(NSMutableDictionary*)dicts
{
    
    if ([GroupName isEqualToString:@""] || GroupArray.count==1)
     {
         dicts=[[RelatedItemsArraj objectAtIndex:SelectedProductIndex] mutableCopy];
         [dicts setObject:@"0" forKey:@"ListCount"];
        // [dicts setObject:@"0" forKey:@"Quantity"];
         [RelatedItemsArraj replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
          [_ParticipantingTableData reloadData];
    }
    else
    {
        dicts=[[filterA objectAtIndex:SelectedProductIndex] mutableCopy];
        [dicts setObject:@"0" forKey:@"ListCount"];
        //[dicts setObject:@"0" forKey:@"Quantity"];
        [filterA replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
         [_ParticipantingTableData reloadData];
    }
    
    // circular quantity remove,remove
     if ([_comefrom isEqualToString:@"Cicular"])
     {
                     GroupName=_dataDict[@"Groupname"];
                     if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                     {
                       
                         [self.Delegate BackRemoveQuantity:RelatedItemsArraj[SelectedProductIndex]];
                         
                     }
                     else
                     {
                       
                         [self.Delegate BackRemoveQuantity:filterA[SelectedProductIndex]];
                     }
    }
     else if ([_comefrom isEqualToString:@"SoppingDeatils"])
     {
         
     }
     else if ([_comefrom isEqualToString:@"Deatils"])
     {
         
         if ([GroupName isEqualToString:@""] || GroupArray.count==1)
         {
             [self.Delegate DetailToRelatedsRemoveBack:RelatedItemsArraj[SelectedProductIndex]];
         }
         else
         {
             [self.Delegate DetailToRelatedsRemoveBack:filterA[SelectedProductIndex]];
         }
         
         
     }
    
}
-(void)updatedata:(NSInteger)index
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
          GroupName=_dataDict[@"Groupname"];
          ClickType=@"1";
          NSArray*memberid=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
        if ([ClickGroup isEqualToString:@"click"])
        {
        
            Actpost=[NSString stringWithFormat:@"UPCCode=%@&CategoryID=%@&SalePrice=%@&PrimaryOfferTypeId=%@&OfferDetailId=%@&PersonalCircularID=%@&ExpirationDate=%@&ClientID=%@&PackagingSize=%@&DisplayPrice=%@&RelevantUPC=%@&Description=%@&SpecialInformation=%@&CouponID=%@&MemberID=%@&DeviceId=%@&OPMOfferID=%@&iPositionID=%@&PageID=%@&ClickType=%@&Savings=%@&AdPrice=%@&RegPrice=%@",filterA[index][@"UPC"],filterA[index][@"CategoryID"],filterA[index][@"FinalPrice"],filterA[index][@"PrimaryOfferTypeId"],filterA[index][@"OfferDetailId"],filterA[index][@"PersonalCircularID"],filterA[index][@"ValidityEndDate"],@"1",filterA[index][@"PackagingSize"],filterA[index][@"DisplayPrice"],filterA[index][@"RelevantUPC"],filterA[index][@"Description"],filterA[index][@"SpecialInformation"],filterA[index][@"CouponID"],memberid[0],@"1",filterA[index][@"PricingMasterID"],filterA[index][@"TileNumber"],filterA[index][@"PageID"],ClickType,filterA[index][@"Savings"],filterA[index][@"AdPrice"],filterA[index][@"RegularPrice"]];
        }
        else
        {
            
        
            Actpost=[NSString stringWithFormat:@"UPCCode=%@&CategoryID=%@&SalePrice=%@&PrimaryOfferTypeId=%@&OfferDetailId=%@&PersonalCircularID=%@&ExpirationDate=%@&ClientID=%@&PackagingSize=%@&DisplayPrice=%@&RelevantUPC=%@&Description=%@&SpecialInformation=%@&CouponID=%@&MemberID=%@&DeviceId=%@&OPMOfferID=%@&iPositionID=%@&PageID=%@&ClickType=%@&Savings=%@&AdPrice=%@&RegPrice=%@",RelatedItemsArraj[index][@"UPC"],RelatedItemsArraj[index][@"CategoryID"],RelatedItemsArraj[index][@"FinalPrice"],RelatedItemsArraj[index][@"PrimaryOfferTypeId"],RelatedItemsArraj[index][@"OfferDetailId"],RelatedItemsArraj[index][@"PersonalCircularID"],RelatedItemsArraj[index][@"ValidityEndDate"],@"1",RelatedItemsArraj[index][@"PackagingSize"],RelatedItemsArraj[index][@"DisplayPrice"],RelatedItemsArraj[index][@"RelevantUPC"],RelatedItemsArraj[index][@"Description"],RelatedItemsArraj[index][@"SpecialInformation"],RelatedItemsArraj[index][@"CouponID"],memberid[0],@"1",RelatedItemsArraj[index][@"PricingMasterID"],RelatedItemsArraj[index][@"TileNumber"],RelatedItemsArraj[index][@"PageID"],ClickType,RelatedItemsArraj[index][@"Savings"],RelatedItemsArraj[index][@"AdPrice"],RelatedItemsArraj[index][@"RegularPrice"]];
        }
        NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                                   @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                   };
        NSData *postData = [Actpost dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
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
           NSLog(@"jsonresonse:%@",jsonresonse);
            if ([[jsonresonse valueForKey:@"errorcode"] integerValue]==0)
            {
             
                if ([_comefrom isEqualToString:@"Deatils"])
                {
                  if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                     {
                         [self.Delegate DetailToRelatedsBack:RelatedItemsArraj[index]];
                     }
                    else
                    {
                           [self.Delegate DetailToRelatedsBack:filterA[index]];
                    }
                           
       }
                else
                {
                    
                    if ([GroupName isEqualToString:@""] || GroupArray.count==1)
                    {
                        NSMutableDictionary*strDict=[[RelatedItemsArraj objectAtIndex:index] mutableCopy];
                        [strDict setObject:@"1" forKey:@"ListCount"];
                        [strDict setObject:@"1" forKey:@"ClickCount"];
                        [RelatedItemsArraj replaceObjectAtIndex:index withObject:strDict];
                        [self.Delegate UpdateGroupName:_dataDict];
                        for (int i=0; i<[RelatedItemsArraj count]; i++)
                        {
                            NSMutableDictionary*str=[[RelatedItemsArraj objectAtIndex:i] mutableCopy];
                            [str setObject:@"1" forKey:@"ClickCount"];
                            [RelatedItemsArraj replaceObjectAtIndex:i withObject:str];
                            
                        }
                      [self.Delegate BackActivateFuc:RelatedItemsArraj[index] backdatadict:_dataDict];
                    }
                    else
                    {
                        NSMutableDictionary*strDict=[[filterA objectAtIndex:index] mutableCopy];
                        [strDict setObject:@"1" forKey:@"ListCount"];
                        [strDict setObject:@"1" forKey:@"ClickCount"];
                        [filterA replaceObjectAtIndex:index withObject:strDict];
                        
                        
                        Groupcount=1;
                        [self setlabtitle];
                        [self.Delegate UpdateGroupName:_dataDict];
                        for (int i=0; i<[filterA count]; i++)
                        {
                            NSMutableDictionary*str=[[filterA objectAtIndex:i] mutableCopy];
                            [str setObject:@"1" forKey:@"ClickCount"];
                            [filterA replaceObjectAtIndex:i withObject:str];
                            
                        }
                        [self.Delegate BackActivateFuc:filterA[index] backdatadict:_dataDict];
                
                    }
                }
                
            }
        }
    }
   
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return GroupArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{    GroupCollectionCell *Collcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupCollectionCell"   forIndexPath:indexPath];
    NSMutableDictionary*dict=[GroupArray objectAtIndex:indexPath.row];
    [Collcell cellOnData:dict participantingItemViewController:self index1:indexPath.row];
    [self setlabtitle];
    Collcell.backgroundColor=[UIColor lightGrayColor];
   // NSLog(@"GroupArray:%@", GroupArray);
    return Collcell;
}
-(void)setlabtitle
{
    
    
    GroupName=_dataDict[@"Groupname"];
    NSString* selectGroupLimitDetail=@"";
   // NSLog(@"GroupName:%@",GroupName);
     NSInteger GN=0;
    
    
    NSLog(@"GroupName:%@",GroupName);
    

    
    
     NSMutableArray *arary = [[NSMutableArray alloc] initWithArray:[GroupName componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/:,"]]];
      NSString*groupstr=@"";
       // NSLog(@"arary:%@",arary);
      for (int i=0; i<[arary count]; i++)
     {
        if (i<2)
        {
             if ([GroupN isEqualToString:arary[i]])
             {
               
               if([arary[i+1] integerValue]-Groupcount>=0)
               GN=[arary[i+1] integerValue]-Groupcount;
               else
                   GN=[arary[i+1] integerValue];
            }
            else
                GN=[arary[i+1] integerValue];
               selectGroupLimitDetail = [NSString stringWithFormat:@"%@ %d from %@",selectGroupLimitDetail,GN,arary[i]];
             groupstr=[NSString stringWithFormat:@"%@:%ld",arary[i],GN];
           // NSLog(@"GroupN:%@",GroupN);
            if([GroupN isEqualToString:@""])
            {
                 NSLog(@"arary[i]:%@",arary[i]);
                 GroupN=[NSString stringWithFormat:@"%@",arary[i]];
                // NSLog(@"GroupN:%@",GroupN);
            }
            
             // NSLog(@"GroupN:%@",GroupN);
              ++i;
        }
        else
        {
           
             if ([GroupN isEqualToString:arary[i]])
            {
              if([arary[i+1] integerValue]-Groupcount>=0)
                    GN=[arary[i+1] integerValue]-Groupcount;
                else
                    GN=[arary[i+1] integerValue];
            }
            else
                GN=[arary[i+1] integerValue];
              selectGroupLimitDetail = [NSString stringWithFormat:@"%@ and %ld from %@",selectGroupLimitDetail,GN,arary[i]];
              groupstr=[NSString stringWithFormat:@"%@,%@:%ld",groupstr,arary[i],GN];
              ++i;
        }
        
     
    }
    selectGroupLimitDetail=[NSString stringWithFormat:@" You Must buy %@",selectGroupLimitDetail];
    NSLog(@"selectGroupLimitDetail:%@",selectGroupLimitDetail);
    _titleGroup.text=[NSString stringWithFormat:@"%@",selectGroupLimitDetail];
    GroupName=groupstr;
    NSMutableDictionary*dic=[[NSMutableDictionary alloc] initWithDictionary:_dataDict];
    [dic setObject:groupstr forKey:@"Groupname"];
    _dataDict=dic;
     Groupcount=0;
}
-(void)SelectGroupbtn:(NSMutableArray*)array index:(NSInteger)indexPath
{
        GroupName=_dataDict[@"Groupname"];
        ClickGroup=@"click";
         filterA=[[NSMutableArray alloc] init];
       if (![GroupName isEqualToString:@""] || GroupName==nil)
       {
         [filterA removeAllObjects];
        NSString*string=[NSString stringWithFormat:@"%@",array];
        for ( int i=0; i<[RelatedItemsArraj count]; i++)
        {
            if ([string isEqualToString:RelatedItemsArraj[i][@"Filter"]])
            {
                GroupN=string;
                NSMutableDictionary*dict=[[NSMutableDictionary alloc] initWithDictionary:RelatedItemsArraj[i]];
                [filterA  addObject:dict];
            }
            [_ParticipantingTableData reloadData];
        }
       
   }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    
       NSLog(@"_comefrom:%@",_comefrom);
    
    if ([segue.identifier isEqualToString:@"ProductDetailsViewController"])
    {
        ProductDetailsViewController *destViewController = segue.destinationViewController;
        destViewController.delegate=self;
        if ([_comefrom isEqualToString:@"Cicular"])
        {
        
             if ([_dataDict[@"Groupname"] isEqualToString:@""] || GroupArray.count==1)
             {
                 destViewController.data=RelatedItemsArraj[SelectedProductIndex];
             }
            else
            {
                destViewController.data=filterA[SelectedProductIndex];
               
                
            }
           destViewController.comefrom=@"ParticipantingCircularView";
          
        }
     else if ([_comefrom isEqualToString:@"SoppingDeatils"])
     {
     
         
                     if ([_dataDict[@"Groupname"] isEqualToString:@""] || GroupArray.count==1)
                     {
                         destViewController.data=RelatedItemsArraj[SelectedProductIndex];
                     }
                     else
                     {
                         destViewController.data=filterA[SelectedProductIndex];
                         
                         
                     }
                     destViewController.comefrom=@"SoppingDeatils2";
         
         
    }
         else if([_comefrom isEqualToString:@"ParticipantingDeatilsView"])
         {
           
             if ([_dataDict[@"Groupname"] isEqualToString:@""] || GroupArray.count==1)
             {
                 destViewController.data=RelatedItemsArraj[SelectedProductIndex];
             }
             else
             {
                 destViewController.data=filterA[SelectedProductIndex];
                 
                 
             }
                destViewController.comefrom=@"Deatils";
             
         }
          else if([_comefrom isEqualToString:@"Deatils"])
          {
              if ([_dataDict[@"Groupname"] isEqualToString:@""] || GroupArray.count==1)
              {
                  destViewController.data=RelatedItemsArraj[SelectedProductIndex];
              }
              else
              {
                  destViewController.data=filterA[SelectedProductIndex];
                  
                  
              }
              destViewController.comefrom=@"ParticipantingDeatilsView";
              
          }
       
      
 }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)DetailsToParticipantingAddQtyAndSubQty:(NSMutableDictionary*)dict
{
    
    //if ([[_dataDict valueForKey:@"ClickCount"] integerValue]==1)
       NSInteger count=[_dataDict[@"ClickCount"] integerValue];
        if (count==0)
        {
            ClickType=@"2";
            [self activatedHeaderbutton:ClickType];
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            _product_titleactivelab.text=@"Activated";
            _activeimg.hidden=NO;
            _activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
            _ActivateheaderBtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
        }
  
    NSString*UPCRelated=[NSString stringWithFormat:@"%@",dict[@"UPC"]];
    NSString*UPCRelatedOfferscode=[NSString stringWithFormat:@"%@",dict[@"UPC"]];

    NSString*str=[NSString stringWithFormat:@"%@",dict[@"Quantity"]];
   if ([_dataDict[@"Groupname"] isEqualToString:@""])
    {
        NSMutableDictionary*dicts=[[NSMutableDictionary alloc] initWithDictionary:RelatedItemsArraj[SelectedProductIndex]];
        NSString*UPCCircular=[NSString stringWithFormat:@"%@",dicts[@"UPC"]];
     
        
        if([dict[@"PrimaryOfferTypeId"] integerValue]==3 || [dict[@"PrimaryOfferTypeId"] integerValue]==2)
        {
            if ([UPCRelated isEqualToString:UPCCircular] || [UPCRelatedOfferscode isEqualToString:dicts[@"OfferCode"]])
            {    [dicts setObject:@"1" forKey:@"ClickCount"];
                [dicts setObject:@"1" forKey:@"ListCount"];
                [dicts setObject:str forKey:@"Quantity"];
            }
            else
            {    [dicts setObject:@"1" forKey:@"ClickCount"];
                
            }
        }
        
        [RelatedItemsArraj replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
        
        
    }
    else
    {
        NSMutableDictionary*dicts=[[NSMutableDictionary alloc] initWithDictionary:filterA[SelectedProductIndex]];
        NSString*UPCCircular=[NSString stringWithFormat:@"%@",dicts[@"UPC"]];
        if([dict[@"PrimaryOfferTypeId"] integerValue]==3 || [dict[@"PrimaryOfferTypeId"] integerValue]==2)
        {
            if ([UPCRelated isEqualToString:UPCCircular] || [UPCRelatedOfferscode isEqualToString:dicts[@"OfferCode"]])
            {
                [dicts setObject:@"1" forKey:@"ClickCount"];
                [dicts setObject:@"1" forKey:@"ListCount"];
                [dicts setObject:str forKey:@"Quantity"];
            }
            else
            {
                [dict setObject:@"1" forKey:@"ClickCount"];
                
            }
        }
        
        [filterA replaceObjectAtIndex:SelectedProductIndex withObject:dicts];
        
        
    }

        NSMutableDictionary*cir=[[NSMutableDictionary alloc] initWithDictionary:_dataDict];
        [cir setObject:str forKey:@"Quantity"];
        _dataDict=cir;
    
        [self.Delegate DetailToRelatedsBack:_dataDict];
}


-(void)DetailsRelatedTodetailsTocircularTotalQtyAdd:(NSMutableDictionary*)dict
{
    
  
      //[self.Delegate DetailsToRelatedTotalQtyAdd:dict];
    
        [self.Delegate DetailsToRelatedTotalQtyAdd:dict];
}
-(void)DetailsRelatedTodetailsTocircularTotalQtySub:(NSMutableDictionary*)dict
{
    
    
    
}
@end
