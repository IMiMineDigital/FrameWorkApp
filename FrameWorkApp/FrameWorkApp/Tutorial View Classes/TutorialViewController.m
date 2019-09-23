//
//  TutorialViewController.m
//  Shareq
//
//  Created by Mayank Barnwal on 29/08/17.
//  Copyright © 2017 SynchSoft Technologies. All rights reserved.
//

#import "TutorialViewController.h"
#import "FirstPageViewController.h"
#import "SecondPageViewController.h"
#import "ThirdPageViewController.h"
#import "FourthPageViewController.h"
#import "MenuViewController.h"
#import "HomeViewController.h"

@interface TutorialViewController ()
{
      UIStoryboard *stort;
}
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _skipBtn.hidden=YES;
   // [GlobalScope addShadowToView:_btnview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    [self.pageController setCurrentPage:swipeView.currentPage];
    [self swipbtnTitleChange];
}

- (IBAction)onSkipBtn:(id)sender
{
    [self.view removeFromSuperview];
}

- (IBAction)onNextBtn:(id)sender
{
    if(self.swipeView.currentPage < 3)
    {
        [self.swipeView setCurrentPageWithAnimation:++self.swipeView.currentPage];
    }
    else
    {
        [self CircularPage];
    }
    [self swipbtnTitleChange];
}
-(void)CircularPage
{
    UIStoryboard *stort;
    if(isiPhone5s)
    {
        stort = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPhone6)
    {
        stort = [UIStoryboard storyboardWithName:@"Main7" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPhone8Plus)
    {
        stort = [UIStoryboard storyboardWithName:@"Main8" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPhoneX || isiPhoneXsMax)
    {
        stort = [UIStoryboard storyboardWithName:@"MainX" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else if(isiPad ||isiPadSmall)
    {
        stort = [UIStoryboard storyboardWithName:@"Mainipad" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    else
    {
        stort = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:HomeViewController.class]];
    }
    HomeViewController*controller=[stort instantiateViewControllerWithIdentifier:@"HomeViewController"];
    SlideNavigationController * slideNavCtl =[[SlideNavigationController alloc] initWithRootViewController:controller];
    MenuViewController *leftMenu =(MenuViewController*) [stort instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].navigationBarHidden=YES;
    [self presentViewController:slideNavCtl animated:YES completion:nil];
    NSLog(@"final");
    
}
-(void)swipbtnTitleChange
{
    if(self.swipeView.currentPage == 3)
    {
        _skipBtn.hidden=NO;
        [_skipBtn setTitle:@"Later" forState:UIControlStateNormal];
        [_NextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_NextBtn setBackgroundColor:[UIColor redColor]];
        [_NextBtn setTitle:@"Core Location" forState:UIControlStateNormal];
        [_NextBtn setTitle:@"Core Location" forState:UIControlStateSelected];
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
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView{
    return 4;
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIView *contantView = nil;
    if(index == 0)
    {
        FirstPageViewController *firstPageViewController = [[FirstPageViewController alloc] initWithNibName:@"FirstPageViewController" bundle:[NSBundle bundleForClass:FirstPageViewController.class]];
        firstPageViewController.view.frame = CGRectMake(0, 0,firstPageViewController.view.frame.size.width , firstPageViewController.view.frame.size.height);
        contantView  = firstPageViewController.view;
    }
    else if(index == 1)
    {
        SecondPageViewController *secondPageViewController = [[SecondPageViewController alloc] initWithNibName:@"SecondPageViewController" bundle:[NSBundle bundleForClass:SecondPageViewController.class]];
        secondPageViewController.view.frame = CGRectMake(0, 0,secondPageViewController.view.frame.size.width , secondPageViewController.view.frame.size.height);
        contantView  = secondPageViewController.view;
    }
    else if(index == 2)
    {
        ThirdPageViewController *thirdPageViewController = [[ThirdPageViewController alloc] initWithNibName:@"ThirdPageViewController" bundle:[NSBundle bundleForClass:ThirdPageViewController.class]];
        thirdPageViewController.view.frame = CGRectMake(0, 0,thirdPageViewController.view.frame.size.width , thirdPageViewController.view.frame.size.height);
        contantView  = thirdPageViewController.view;
       [self swipbtnTitleChange];
    }
    else if (index ==3)
    {
       FourthPageViewController *fourthPageViewController = [[FourthPageViewController alloc] initWithNibName:@"FourthPageViewController" bundle:[NSBundle bundleForClass:FourthPageViewController.class]];
      fourthPageViewController.view.frame = CGRectMake(0, 0,fourthPageViewController.view.frame.size.width , fourthPageViewController.view.frame.size.height);
        contantView  = fourthPageViewController.view;
        
    }
    
    return contantView;
}




@end
