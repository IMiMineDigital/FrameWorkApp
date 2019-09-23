//
//  ApiHendlerClass.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 11/01/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "ApiHendlerClass.h"
#import "ObjectType.h"
#import "Reachability.h"
#import "HomeViewController.h"

#import "PresentViewController.h"
#import "SoppingListViewcontroller.h"
#import "BarCodeViewConrtoller.h"
#import "PurchaseHistoryViewController.h"
#import "PurchaseHistoryViewController.h"
@implementation ApiHendlerClass
{
      UIStoryboard *stort;
    UIWindow*windows;
    HomeViewController*HomeViewControllerOBj;
}
-(void)getAccessToken:(NSString*)baseurl
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
        NSDictionary *headers = @{
                                   @"Password": @"123456",
                                   @"username":@"imemine@usa.com",
                                   @"ClientID":@"1",
                                   @"Content-Type": @"application/x-www-form-urlencoded"
                                   };

        NSMutableData *postData = [[NSMutableData alloc] initWithData:[@"grant_type=password" dataUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseurl]];
        [request setHTTPMethod:@"POST"];
        [request setAllHTTPHeaderFields:headers];
        [request setHTTPBody:postData];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        NSURLResponse * response = nil;
        NSError * error = nil;
        NSData * dataResponse = [NSURLConnection sendSynchronousRequest:request
                                                      returningResponse:&response
                                                                  error:&error];
        NSMutableDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:dataResponse options:NSJSONReadingAllowFragments error:&error];
       if(dataResponse != nil)
        {
            NSMutableDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:dataResponse options:NSJSONReadingAllowFragments error:&error];
          //  NSLog(@"jsonObject:%@",jsonObject);
             NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
            if (statusCode== 200)
            {
                [[NSUserDefaults standardUserDefaults] setObject:jsonObject forKey:ACCESS_TOKEN];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }

        }
    }

}
-(void)GlobalNsuserDefaultValues
{
    NSArray *keys = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys];
    if (![keys containsObject:ACCESS_TOKEN])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:ACCESS_TOKEN];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (![keys containsObject:USERDATA])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USERDATA];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (![keys containsObject:@"Tutorials"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"Tutorials"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
 
    if (![keys containsObject:@"ischeckclear"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ischeckclear"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (![keys containsObject:@"footerstr"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"footerstr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (![keys containsObject:@"isSearching"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"isSearching"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
     [self getAccessToken:ACCESSTOKEN_URL];
//    [self getAccessToken:[NSString stringWithFormat:@"%@%@",GLOBAL_URL,ACCESSTOKEN_URL]];
   
}
-(void)getLoginData:(NSString*)name pass:(NSString*)pass
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
        [self GlobalNsuserDefaultValues];
        NSDictionary *headers = @{ @"Content-Type": @"application/x-www-form-urlencoded",
                                   @"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                                   };
        NSString *post = [NSString stringWithFormat:@"UserName=%@&Password=%@",name,pass];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GLOBAL_URL,LOGIN_URL]]];
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:LOGIN_URL]];
        [request setHTTPMethod:@"POST"];
        [request setAllHTTPHeaderFields:headers];
        [request setHTTPBody:postData];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        NSURLResponse*response=nil;
        NSError*err=nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        if (responseData!=nil)
        {
            NSMutableDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
            NSMutableArray* arrayObj=[[NSMutableArray alloc] init];
             // NSLog(@"getAccessToken:%@",[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN]);
           //  NSLog(@"login data:%@",jsonObject);
//            NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
//           NSLog(@"CFBundleVersion:%@",appVersion);
            if ([[jsonObject valueForKey:@"errorcode"] integerValue]==0)
            {
                [arrayObj addObject:jsonObject];
            
                [[NSUserDefaults standardUserDefaults] setObject:arrayObj[0][@"message"] forKey:USERDATA];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self GetshopperListIdApi];
            }
        }
    }
}

-(id)CircularPage
{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"isSearching"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
   if(isiPhone5s)
    {
        stort = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPhone6)
    { stort = [UIStoryboard storyboardWithName:@"Main7" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPhone8Plus)
    { stort = [UIStoryboard storyboardWithName:@"Main8" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPhoneX || isiPhoneXsMax)
    { stort = [UIStoryboard storyboardWithName:@"MainX" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPad ||isiPadSmall)
    { stort = [UIStoryboard storyboardWithName:@"Mainipad" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else
    { stort = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Tutorials"] integerValue]==0)
    {
          PresentViewController*contro=[stort instantiateViewControllerWithIdentifier:@"PresentViewController"];
          contro.comefrom=NSLocalizedString(@"Personal Ad", @"");
         //contro.delegate=self;
          [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Tutorials"];
          [[NSUserDefaults standardUserDefaults] synchronize];
          UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:contro];
          nav.navigationBarHidden=true;
          return nav;
    }
    else
    {
           HomeViewController*controller=[stort instantiateViewControllerWithIdentifier:@"HomeViewController"];
           controller.isCheckController=NSLocalizedString(@"Personal Ad", @"");
           //controller.delegate=self;
           UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:controller];
           nav.navigationBarHidden=true;
           return nav;
   }
   
}
-(void)GetshopperListIdApi
{
    NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"token_type"],[[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN] valueForKey:@"access_token"]],
                              };
    NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"MemberId"];
    NSURLComponents *components = [NSURLComponents componentsWithString:GETSHOPPERLISTID_URL];
    NSURLQueryItem *LoyaltyCardNumber = [NSURLQueryItem queryItemWithName:@"MemberId" value:arra[0]];
    components.queryItems = @[LoyaltyCardNumber,];
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
        
        [[NSUserDefaults standardUserDefaults] setObject:jsonObject[@"message"][@"ListName"] forKey:@"ShoppingListId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
       // NSLog(@"jsonObject:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ShoppingListId"]);
    }
}
-(id)shoppingListPage
{
    if(isiPhone5s)
    {
        stort = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:SoppingListViewcontroller.class]];
    }
    else if(isiPhone6)
    { stort = [UIStoryboard storyboardWithName:@"Main7" bundle:[NSBundle bundleForClass:SoppingListViewcontroller.class]];
    }
    else if(isiPhone8Plus)
    { stort = [UIStoryboard storyboardWithName:@"Main8" bundle:[NSBundle bundleForClass:SoppingListViewcontroller.class]];
    }
    else if(isiPhoneX || isiPhoneXsMax)
    { stort = [UIStoryboard storyboardWithName:@"MainX" bundle:[NSBundle bundleForClass:SoppingListViewcontroller.class]];
    }
    else if(isiPad ||isiPadSmall)
    { stort = [UIStoryboard storyboardWithName:@"Mainipad" bundle:[NSBundle bundleForClass:SoppingListViewcontroller.class]];
    }
    else
    { stort = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:SoppingListViewcontroller.class]];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Tutorials"] integerValue]==0)
    {
        PresentViewController*contro=[stort instantiateViewControllerWithIdentifier:@"PresentViewController"];
        contro.comefrom=NSLocalizedString(@"shoppingListPage", @"");
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Tutorials"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:contro];
        nav.navigationBarHidden=true;
        return nav;
    }
    else
    {
        SoppingListViewcontroller*controller=[stort instantiateViewControllerWithIdentifier:@"SoppingListViewcontroller"];
        controller.Checkback=@"FirstEnter";
        controller.isCheckfilter=@"FirstEnter";
        UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:controller];
        nav.navigationBarHidden=true;
        return nav;
    }
    
}

-(id)getPurcheaseHistoryPage
{
    if(isiPhone5s)
    {
        stort = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPhone6)
    { stort = [UIStoryboard storyboardWithName:@"Main7" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPhone8Plus)
    { stort = [UIStoryboard storyboardWithName:@"Main8" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPhoneX || isiPhoneXsMax)
    { stort = [UIStoryboard storyboardWithName:@"MainX" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPad ||isiPadSmall)
    { stort = [UIStoryboard storyboardWithName:@"Mainipad" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else
    { stort = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Tutorials"] integerValue]==0)
    {
        PresentViewController*contro=[stort instantiateViewControllerWithIdentifier:@"PresentViewController"];
        contro.comefrom=NSLocalizedString(@"PurcheaseHistoryPage", @"");
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Tutorials"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:contro];
        nav.navigationBarHidden=true;
        return nav;
    }
    else
    {
        PurchaseHistoryViewController*controller=[stort instantiateViewControllerWithIdentifier:@"PurchaseHistoryViewController"];
        controller.Checkback=@"FirstEnter";
        UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:controller];
        nav.navigationBarHidden=true;
        return nav;
    }
  
    
}
-(id)moreCouponse
{
 return nil;
}
-(void) dissmisscontroller
{
    UIWindow* windows= [[UIApplication sharedApplication] keyWindow];
    [windows.rootViewController dismissViewControllerAnimated:NO completion:nil];
}
-(void)soppinglist:(UIStoryboard*)str cont:(UIViewController*)con
{   con=(UIViewController*)[str instantiateViewControllerWithIdentifier:@"SecondViewController"];
    NSString *storyboardID = storyboardID;
    UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:con];
    [nav.navigationController pushViewController:con animated:YES];
  
}
-(void)logoutfunction
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USERDATA];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"footerstr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"isSearching"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
}


@end
