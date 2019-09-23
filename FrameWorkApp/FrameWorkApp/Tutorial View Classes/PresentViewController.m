//
//  PresentViewController.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 25/02/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "PresentViewController.h"
#import "FirstPageViewController.h"
#import "SecondPageViewController.h"
#import "ThirdPageViewController.h"
#import "FourthPageViewController.h"

#import "HomeViewController.h"
#import "Validation.h"
#import "BarCodeViewConrtoller.h"
#import "SoppingListViewcontroller.h"
#import "PurchaseHistoryViewController.h"
@interface PresentViewController ()<HomeViewControllerDelegate,PresentViewControllerDelegate>
{
      UIStoryboard *stort;
}
@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _skipBtn.hidden=YES;

    [Validation addShadowToView:_btnview];
}


- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    [self.pageController setCurrentPage:swipeView.currentPage];
    [self swipbtnTitleChange];
}

- (IBAction)onSkipBtn:(id)sender
{
//    [self.view removeFromSuperview];
}

- (IBAction)onNextBtn:(id)sender
{
    if(self.swipeView.currentPage < 3)
    {
      [self.swipeView setCurrentPageWithAnimation:++self.swipeView.currentPage];
    }
    else
    {
        [self SetCircularPage];
    }
  [self swipbtnTitleChange];
}
-(void)SetCircularPage
{
    
    
    
    NSLog(@"_comefrom:%@",_comefrom);
    if(isiPhone5s)
    { stort = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPhone6)
    {stort = [UIStoryboard storyboardWithName:@"Main7" bundle:[NSBundle bundleForClass:HomeViewController.class]];
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
    {stort = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }

    if ([_comefrom isEqualToString:NSLocalizedString(@"Personal Ad", @"")])
    {
         HomeViewController*controller=[stort instantiateViewControllerWithIdentifier:@"HomeViewController"];
         UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:controller];
         nav.navigationBarHidden=true;
         controller.isCheckController=NSLocalizedString(@"Personal Ad", @"");
         controller.delegate=self;
         [self presentViewController:nav animated:YES completion:nil];
    }
    else if ([_comefrom isEqualToString:NSLocalizedString(@"shoppingListPage", @"")])
    {
        SoppingListViewcontroller*controller=[stort instantiateViewControllerWithIdentifier:@"SoppingListViewcontroller"];
        UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:controller];
        controller.Checkback=@"FirstEnter";
         controller.isCheckfilter=@"FirstEnter";
        nav.navigationBarHidden=true;
        [self presentViewController:nav animated:YES completion:nil];
    }
    else if ([_comefrom isEqualToString:NSLocalizedString(@"PurcheaseHistoryPage", @"")])
    {
        PurchaseHistoryViewController*controller=[stort instantiateViewControllerWithIdentifier:@"PurchaseHistoryViewController"];
         controller.Checkback=@"FirstEnter";
        UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:controller];
        nav.navigationBarHidden=true;
        [self presentViewController:nav animated:YES completion:nil];
        
    }
 }

-(void)swipbtnTitleChange
{
    if(self.swipeView.currentPage == 3)
    {
         //_skipBtn.hidden=NO;
        // [_skipBtn setTitle:@"Later" forState:UIControlStateNormal];
         _skipBtn.hidden=YES;
         [_NextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [_NextBtn setBackgroundColor:[UIColor redColor]];
         [_NextBtn setTitle:@"Allow Location" forState:UIControlStateNormal];
         [_NextBtn setTitle:@"Allow Location" forState:UIControlStateSelected];
    }
    else
    {
         _skipBtn.hidden=YES;
         [_NextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
         [_NextBtn setTitle:@"NEXT" forState:UIControlStateNormal];
         [_NextBtn setBackgroundColor:[UIColor whiteColor]];
         [_NextBtn setTitle:@"NEXT" forState:UIControlStateSelected];
    }
}
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 4;
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIView *contantView = nil;
    if(index == 0)
    { FirstPageViewController *firstPageViewController = [[FirstPageViewController alloc] initWithNibName:[Validation getXibName:@"FirstPageViewController"] bundle:[NSBundle bundleForClass:FirstPageViewController.class]];
        firstPageViewController.view.frame = CGRectMake(0, 0,firstPageViewController.view.frame.size.width , firstPageViewController.view.frame.size.height);
        contantView  = firstPageViewController.view;
    }
    else if(index == 1)
    {SecondPageViewController *secondPageViewController = [[SecondPageViewController alloc] initWithNibName:[Validation getXibName:@"SecondPageViewController"] bundle:[NSBundle bundleForClass:SecondPageViewController.class]];
        secondPageViewController.view.frame = CGRectMake(0, 0,secondPageViewController.view.frame.size.width , secondPageViewController.view.frame.size.height);
        contantView  = secondPageViewController.view;
    }
    else if(index == 2)
    { ThirdPageViewController *thirdPageViewController = [[ThirdPageViewController alloc] initWithNibName:[Validation getXibName:@"ThirdPageViewController"] bundle:[NSBundle bundleForClass:ThirdPageViewController.class]];
        thirdPageViewController.view.frame = CGRectMake(0, 0,thirdPageViewController.view.frame.size.width , thirdPageViewController.view.frame.size.height);
        contantView  = thirdPageViewController.view;
        
    }
    else if (index ==3)
    { FourthPageViewController *fourthPageViewController = [[FourthPageViewController alloc] initWithNibName:[Validation getXibName:@"FourthPageViewController"] bundle:[NSBundle bundleForClass:FourthPageViewController.class]];
        fourthPageViewController.view.frame = CGRectMake(0, 0,fourthPageViewController.view.frame.size.width , fourthPageViewController.view.frame.size.height);
        contantView  = fourthPageViewController.view;
        [self swipbtnTitleChange];
    }
   return contantView;
}
-(void)dismisFun
{
   FourthPageViewController*fourth=[[FourthPageViewController alloc] initWithNibName:[Validation getXibName:@"FourthPageViewController"] bundle:[NSBundle bundleForClass:FourthPageViewController.class]];
    ThirdPageViewController *thirdPageViewController = [[ThirdPageViewController alloc] initWithNibName:[Validation getXibName:@"ThirdPageViewController"] bundle:[NSBundle bundleForClass:ThirdPageViewController.class]];
    SecondPageViewController *secondPageViewController = [[SecondPageViewController alloc] initWithNibName:[Validation getXibName:@"SecondPageViewController"] bundle:[NSBundle bundleForClass:SecondPageViewController.class]];
   FirstPageViewController *firstPageViewController = [[FirstPageViewController alloc] initWithNibName:[Validation getXibName:@"FirstPageViewController"] bundle:[NSBundle bundleForClass:FirstPageViewController.class]];
     [fourth removeFromParentViewController];
        [thirdPageViewController removeFromParentViewController];
        [secondPageViewController removeFromParentViewController];
        [firstPageViewController removeFromParentViewController];
//    _swipeView.hidden=YES;
//    _btnview.hidden=YES;

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
