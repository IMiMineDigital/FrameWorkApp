//
//  HomeViewController.m
//  Bashas
//
//  Created by kamlesh prajapati on 20/10/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import "HomeViewController.h"

#import "MyPersonalPriceViewController.h"
#import "SelectStoreNameViewController.h"

#import "SavingViewController.h"
#import "ObjectType.h"
#import "PurchaseHistoryViewController.h"
#import "ApiHendlerClass.h"
#import "SoppingListViewcontroller.h"
@interface HomeViewController ()<MyPersonalPriceViewControllerDelegate,SelectStoreNameViewControllerDelegate,SoppingListViewcontrollerDelegate,PurchaseHistoryViewControllerDelegate>
{
     BOOL isfiltercheckmark;
     NSInteger isCheckCircular;
     NSInteger currentIndex;
     NSMutableArray *arraydata;
     NSMutableArray *shoppinglistFilerarray;
     UIStoryboard*storyboard;
  
      MyPersonalPriceViewController*MyPersonalPriceViewControllerObj;
      NSMutableDictionary*CatDict;
      NSString*title;
      HomeViewController*HomeViewControllerObj;
      SoppingListViewcontroller*SoppingListViewcontrollerObj;
      UIViewController*controller;
      UIStoryboard*storybord;
    
     NSInteger soppingindex;
     BOOL issoppingadd;
     NSMutableArray*getShoppinglistarray;

      NSMutableArray*filtercatarray;
    
      BOOL isMyList;
      NSInteger onetime;
      NSInteger filerindex;
    
    UIView*view1;
    
     UIView*view2;
        NSMutableArray*arraydatastore;
    
    
    
    
}
@end

@implementation HomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
     _budgeView.hidden=YES;
        isMyList=TRUE;
    _Filterview.hidden=YES;
    CatDict=[[NSMutableDictionary alloc] init];
    arraydata= [[NSMutableArray alloc] init];
    shoppinglistFilerarray= [[NSMutableArray alloc] init];
    [self storybord];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    isCheckCircular=0;
    onetime=0;
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapScroll];
    //_shoppingFilterView.hidden=YES;
    MyPersonalPriceViewControllerObj = (MyPersonalPriceViewController*)[storyboard instantiateViewControllerWithIdentifier:@"MyPersonalPriceViewController"];
    
   _bolerView.hidden=YES;
    [_Homebtn setTitle:@"Home" forState:UIControlStateNormal];
    [self ischeckControllerType];
    SoppingListViewcontrollerObj = (SoppingListViewcontroller*)[storyboard instantiateViewControllerWithIdentifier:@"SoppingListViewcontroller"];
    SoppingListViewcontrollerObj.delegate=self;
    currentIndex = 1;
    [Validation  setRoundView:self.budgeView borderWidth:0 borderColor:nil radius:_budgeView.frame.size.width/2];
    _budgeView.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    [Validation addShadowToView:_myAccountView];
    [Validation addShadowToView:_Filterview];
    _myAccountView.hidden=YES;
    [Validation addShadowToView:_btnView];
    _activeIndicatorView.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    _btnView.backgroundColor=[UIColor whiteColor];
    
    
    
  //       NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    if (isfiltercheckmark==NO)
//    {
//        isfiltercheckmark=YES;
//        _Filtercatimg.image= [UIImage imageNamed:@"" inBundle:bundle compatibleWithTraitCollection:nil];
//         _FilterOffersimg.image= [UIImage imageNamed:@"checkmark.png" inBundle:bundle compatibleWithTraitCollection:nil];
//        _FilterOffersimg.image = [_FilterOffersimg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        [_FilterOffersimg setTintColor:[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0]];
//    }
}
-(void)hidebolerview
{
    _bolerView.hidden=YES;
}
-(void)budgeviewhide
{
    _budgeView.hidden=YES;
}
-(void)showbolerview
{
   _bolerView.hidden=NO;
}
- (void)tapped
{
     [self.view endEditing:YES];
    _Filterview.hidden=YES;
     _myAccountView.hidden=YES;
    
}
-(void)ischeckControllerType
{
    
   [UIView animateWithDuration:0.3 animations:^{
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    } completion:^(BOOL finished) {
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    }];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    if (isMyList==TRUE)
    {
        
        
        if ([_isCheckController isEqualToString:NSLocalizedString(@"Personal Ad", @"")])
        {
            [self AddMypersonalPriceController];
            [_Mylistbtn setTitle:@"MyFareway List" forState:UIControlStateNormal];
            [_Shoppinglistbtn setImage:[UIImage imageNamed:@"mylist" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
            
        }
    }
    else
    {
        
         isMyList=TRUE;
         [self addSoppingListController];
         [_Mylistbtn setTitle:@"Personal Ad" forState:UIControlStateNormal];
         _budgeView.hidden=YES;
         [_Shoppinglistbtn setImage:[UIImage imageNamed:@"personal-circular.png" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        
        
    }

}

-(void)shoppingToCircularUpdateqty:(NSMutableDictionary*)dict
{
    
  
        MyPersonalPriceViewControllerObj.delegate=self;
       // [MyPersonalPriceViewControllerObj shoppinglisttocircularQuantityUpdate:dict];
    
}
//shopping list total
-(void)shoppingToCircularUpdateTotalqtyadd:(NSMutableDictionary*)dicts
{
    

    
      MyPersonalPriceViewControllerObj.delegate=self;
      [MyPersonalPriceViewControllerObj AddRelatedCountToatalQty:dicts];
    
}
-(void)shoppingToCircularUpdateTotalqtysub:(NSMutableDictionary*)dicts
{
 
       MyPersonalPriceViewControllerObj.delegate=self;
      [MyPersonalPriceViewControllerObj SubRelatedCountToatalQty:dicts];
    
    
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
        storyboard = [UIStoryboard storyboardWithName:@"Mainipad" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else{
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:MyPersonalPriceViewController.class]];
    }
}
-(id)getShoppingListCountcircular:(NSMutableArray*)str
{
    
    if (str.count>0)
    {
        _budgeView.hidden=NO;
        _Shopingcount.text=[NSString stringWithFormat:@"%ld",str.count];
         return str;
    }
    else
    {
        _Shopingcount.text=@"0";
        _budgeView.hidden=YES;
        
    }
    return nil;
    
}
-(id)getShoppingListCount:(NSMutableArray*)str
{
    
    if (str.count>0)
       {
            _budgeView.hidden=YES;
            _Shopingcount.text=[NSString stringWithFormat:@"%ld",str.count];
           //[ shoppinglistFilerarray addObjectsFromArray:str];;
             return str;
       }
    else
    {
        _Shopingcount.text=@"0";
        _budgeView.hidden=YES;
        
    }
   return nil;
}
-(void)hidentabbar
{
    
    _Filterview.hidden=YES;
   
    _myAccountView.hidden=YES;
}
-(void)filterviewhide
{
      _Filterview.hidden=YES;
}

-(void)UpdateCircularForShopping
{
    MyPersonalPriceViewControllerObj= (MyPersonalPriceViewController*)[storyboard instantiateViewControllerWithIdentifier:@"MyPersonalPriceViewController"];
    MyPersonalPriceViewControllerObj.delegate=self;
    _budgeView.hidden=YES;
    _Shopingcount.text=@"0";
 
}

-(void)AddMypersonalPriceController
{
     //  MyPersonalPriceViewControllerObj=(MyPersonalPriceViewController*)[storyboard instantiateViewControllerWithIdentifier:@"MyPersonalPriceViewController"];
        issoppingadd=false;
        isMyList=false;
       MyPersonalPriceViewControllerObj.delegate=self;
       SoppingListViewcontrollerObj.delegate=self;
       MyPersonalPriceViewControllerObj.comefrom=_comefrom;
       MyPersonalPriceViewControllerObj.filtertype=_filtertype;
      [MyPersonalPriceViewControllerObj Filterviewclasshide];
         filerindex=0;
 self->MyPersonalPriceViewControllerObj.view.frame=CGRectMake(_ParentView.layer.frame.origin.x,_ParentView.layer.frame.origin.y , _ParentView.frame.size.width, _ParentView.frame.size.height);
      [SoppingListViewcontrollerObj removeFromParentViewController];
     [self addChildViewController:MyPersonalPriceViewControllerObj];
     [self.ParentView addSubview:MyPersonalPriceViewControllerObj.view];
     [MyPersonalPriceViewControllerObj didMoveToParentViewController:self];
     _isCheckController=NSLocalizedString(@"Personal Ad", @"");
  

    
  
}

-(void)addSoppingListController
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    } completion:^(BOOL finished) {
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    }];
    
     if (issoppingadd==false)
      {
       SoppingListViewcontrollerObj = (SoppingListViewcontroller*)[storyboard instantiateViewControllerWithIdentifier:@"SoppingListViewcontroller"];
        CATransition *transition = [[CATransition alloc] init];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.ParentView.layer addAnimation:transition forKey:kCATransition];
          SoppingListViewcontrollerObj.delegate=self;
          SoppingListViewcontrollerObj.CirCouponseidChecked=arraydata;
          MyPersonalPriceViewControllerObj.delegate=self;
           filerindex=1;
        
          
         self->SoppingListViewcontrollerObj.view.frame=CGRectMake(_ParentView.layer.frame.origin.x,_ParentView.layer.frame.origin.y , _ParentView.frame.size.width, _ParentView.frame.size.height);
     [MyPersonalPriceViewControllerObj removeFromParentViewController];
        [self addChildViewController:SoppingListViewcontrollerObj];
        [self.ParentView addSubview:SoppingListViewcontrollerObj.view];
        [SoppingListViewcontrollerObj didMoveToParentViewController:self];
        issoppingadd=true;
        isMyList=true;
    
          
    }
    else
    {
          [self AddMypersonalPriceController];
    }
}
-(void) hideBottomBar
{ [self.btnView setHidden:true];
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{ return false;
}
- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{ return YES;
}
-(void) showBottomBar
{
  [self.btnView setHidden:FALSE];
}
-(void)RemoveDetailsToShopping:(NSMutableDictionary*)dict
{
    
    
    
    
}
- (IBAction)MoreBtnfun:(UIButton*)sender
{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.activeIndicatorView setCenter:CGPointMake(self.MoreBtn.center.x,self.activeIndicatorView.center.y)];
    } completion:^(BOOL finished) {
        [self.activeIndicatorView setCenter:CGPointMake(self.MoreBtn.center.x,self.activeIndicatorView.center.y)];
    }];
    
        issoppingadd=false;
       _Filterview.hidden=YES;
       _activeIndicatorView.hidden=NO;
       [self UnSelectedAllBtn];
       _Homebtn.selected=YES;
       _myAccountView.hidden=NO;
       _Filterview.hidden=YES;
}
-(IBAction)Accountbtn:(id)sender{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    } completion:^(BOOL finished) {
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    }];
    
    _myAccountView.hidden=YES;
       PurchaseHistoryViewController *PurchaseHistoryViewControllerObj= (PurchaseHistoryViewController*)[storyboard instantiateViewControllerWithIdentifier:@"PurchaseHistoryViewController"];
    PurchaseHistoryViewControllerObj.delegate=self;
    [self performSegueWithIdentifier:@"PurchaseHistoryViewController" sender:sender];
  
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PurchaseHistoryViewController"])
    {
        PurchaseHistoryViewController *destViewController = segue.destinationViewController;
        MyPersonalPriceViewControllerObj.delegate=self;
        destViewController.delegate=self;
        destViewController.Checkback=@"";

    }
}
-(IBAction)Shopperidbtn:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    } completion:^(BOOL finished) {
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    }];
//    [self performSegueWithIdentifier:@"BarCodeViewConrtoller" sender:self];
    _myAccountView.hidden=YES;
}
-(void)Togglebtn
{
   // [Validation Togglebtn:self.ParentView];
       issoppingadd=false;
    if (currentIndex==0)
    { CATransition *transition = [[CATransition alloc] init];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.ParentView.layer addAnimation:transition forKey:kCATransition];
        currentIndex=1;
    }
    else
    {  CATransition *transition = [[CATransition alloc] init];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.ParentView.layer addAnimation:transition forKey:kCATransition];
        currentIndex=0;
    }
}


- (void) dismissAndGoToRoot
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self performSelector:@selector(gotoRoot) withObject:nil afterDelay:0.50];
}
- (void)gotoRoot
{
     [self.navigationController popToRootViewControllerAnimated:NO];
}
-(void)Deleteshoppinglist:(NSMutableDictionary*)dict
{
    
    //budge hide
    MyPersonalPriceViewControllerObj = (MyPersonalPriceViewController*)[storyboard instantiateViewControllerWithIdentifier:@"MyPersonalPriceViewController"];
    MyPersonalPriceViewControllerObj.delegate=self;
    _budgeView.hidden=YES;
    [MyPersonalPriceViewControllerObj backShoppinglistDeleted:dict];
  
}
-(IBAction)homebtnfun:(id)sender
{
      issoppingadd=false;
      ApiHendlerClass*dissmisswindow=[ApiHendlerClass new];
      [dissmisswindow dissmisscontroller];
}

- (IBAction)savingbtn:(UIButton*)sender
{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    } completion:^(BOOL finished) {
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    }];
     issoppingadd=false;
    _activeIndicatorView.hidden=NO;
     [self UnSelectedAllBtn];
    _savingbtn.selected=YES;
    _Filterview.hidden=YES;
     [self performSegueWithIdentifier:@"SavingViewController" sender:self];
}
-(void)backCircularpageForShoppinglist
{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    } completion:^(BOOL finished) {
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    }];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    if (isMyList==TRUE)
    {
        if ([_isCheckController isEqualToString:NSLocalizedString(@"Personal Ad", @"")])
        {
            [self ischeckControllerType];
            CATransition *transition = [[CATransition alloc] init];
            transition.duration = 0.5;
            transition.type = kCATransitionPush;
              _budgeView.hidden=NO;
            transition.subtype = kCATransitionFromLeft;
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.ParentView.layer addAnimation:transition forKey:kCATransition];
            [_Mylistbtn setTitle:@"MyFareway List" forState:UIControlStateNormal];
            [_Shoppinglistbtn setImage:[UIImage imageNamed:@"mylist" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
            filerindex=0;

        }
    }
    else
    {
        isMyList=TRUE;
        [self addSoppingListController];
            filerindex=1;
          _Filterview.hidden=YES;
        
         [_Mylistbtn setTitle:@"Personal Ad" forState:UIControlStateNormal];
        _budgeView.hidden=YES;
         [_Shoppinglistbtn setImage:[UIImage imageNamed:@"personal-circular.png" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        
    }
}
-(IBAction)Soppinglist:(id)sender
{
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    } completion:^(BOOL finished) {
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    }];
    _Filterview.hidden=YES;
    [self backCircularpageForShoppinglist];
  
}
-(void)list:(UIStoryboard*)str cont:(UIViewController*)con
{
       controller=con;
       storybord=str;
}

-(void)showingview
{
    if(isiPhone5s)
    {
          [Validation animationView:self.Filterview view_y:400];
         // NSLog(@"isiPhone5s");
    }
    else if(isiPhone6)
    {
         [Validation animationView:self.Filterview view_y:484];
         // NSLog(@"isiPhone6");
    }
    else if(isiPhone8Plus)
    {
        [Validation animationView:self.Filterview view_y:562];
         // NSLog(@"isiPhone8Plus");
     }
    else if(isiPhoneX )
    {
        [Validation animationView:self.Filterview view_y:621];
          //NSLog(@"isiPhoneX");
     }
    else if (isiPhoneXsMax)
    {
         [Validation animationView:self.Filterview view_y:718];
         // NSLog(@"isiPhoneXsMax");
    }
    else if(isiPad ||isiPadSmall)
    {
        // [Validation animationView:self.Filterview view_y:648];
    }
    else{
       [Validation animationView:self.Filterview view_y:400];
       // NSLog(@"Main2");
    }
   _Filterview.hidden=NO;
}

-(void)UnSelectedAllBtn
{
    [_savingbtn setSelected:FALSE];
    [_filterbtn setSelected:FALSE];
    [_MoreBtn setSelected:FALSE];
 }

-(id)function:(NSMutableArray*)dict
{
        arraydata=dict;
        return arraydata;
   
}

- (IBAction)filtersBTn:(UIButton*)sender
{
 
    if (filerindex==0)
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self.activeIndicatorView setCenter:CGPointMake(self.filterbtn.center.x,self.activeIndicatorView.center.y)];
        } completion:^(BOOL finished) {
            [self.activeIndicatorView setCenter:CGPointMake(self.filterbtn.center.x,self.activeIndicatorView.center.y)];
        }];
        _Filterview.hidden=NO;
        _activeIndicatorView.hidden=NO;
        [self UnSelectedAllBtn];
        _filterbtn.selected=YES;
        _myAccountView.hidden=YES;
        [self showingview];
      
        
        
    }
    else
    {
        
        
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
        } completion:^(BOOL finished) {
            [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
        }];
             // _shoppingFilterView.hidden=NO;
              _Filterview.hidden=YES;
        SoppingListViewcontrollerObj.delegate=self;
        SoppingListViewcontrollerObj.shoppingFilterView.hidden=NO;

    }
   
   
}
-(UIView*)hideview:(UIView*)view
{
    view.hidden=YES;
    view1=view;
    return view1;
}

-(UIView*)hideviewfilteroffers:(UIView*)view
{
    view.hidden=YES;
    view2=view;
    return view2;
}

-(IBAction)filterByCat:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    } completion:^(BOOL finished) {
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    }];



         MyPersonalPriceViewControllerObj.delegate=self;
        [MyPersonalPriceViewControllerObj Filterviewclasshide];
        [MyPersonalPriceViewControllerObj filterclasscatviewshow];
        [self hidetabbarview];
//       NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    if (isfiltercheckmark==YES)
//    {
//        isfiltercheckmark=NO;
//        _FilterOffersimg.image= [UIImage imageNamed:@"" inBundle:bundle compatibleWithTraitCollection:nil];
//        _Filtercatimg.image= [UIImage imageNamed:@"tick" inBundle:bundle compatibleWithTraitCollection:nil];
//    }

    
}
-(IBAction)filterByOffer:(id)sender
{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    } completion:^(BOOL finished) {
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    }];
    // NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//     if (isfiltercheckmark==NO)
//    {
//         isfiltercheckmark=YES;
//        _Filtercatimg.image= [UIImage imageNamed:@"" inBundle:bundle compatibleWithTraitCollection:nil];
//        _FilterOffersimg.image= [UIImage imageNamed:@"tick" inBundle:bundle compatibleWithTraitCollection:nil];
//    }
   
    
    
      MyPersonalPriceViewControllerObj.delegate=self;
      [MyPersonalPriceViewControllerObj Filterviewclassshow];
       [MyPersonalPriceViewControllerObj filterclasscatviewhide];
       [self hidetabbarview];
}
-(IBAction)sortbybtn:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    } completion:^(BOOL finished) {
        [self.activeIndicatorView setCenter:CGPointMake(self.Shoppinglistbtn.center.x,self.activeIndicatorView.center.y)];
    }];
      MyPersonalPriceViewControllerObj.delegate=self;
      [MyPersonalPriceViewControllerObj filterclasscatviewhide];
      [MyPersonalPriceViewControllerObj Filterviewclasshide];
        [MyPersonalPriceViewControllerObj sortbyviewshow];
     [self hidetabbarview];
}
-(void)hidefilterview
{
     _Filterview.hidden=YES;
}
-(void)hidetabbarview
{
      _budgeView.hidden=YES;
      _activeIndicatorView.hidden=YES;
        _btnView.hidden=YES;
}
-(void)showtabbarview
{
    _budgeView.hidden=NO;
    _activeIndicatorView.hidden=NO;
    _btnView.hidden=NO;
    
}
-(void)shoppinglistdeatilscouponseArry:(NSMutableArray*)arry
{
    
    
}
@end
