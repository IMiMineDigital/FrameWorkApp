//
//  TutorialViewController.h
//  Shareq
//
//  Created by Mayank Barnwal on 29/08/17.
//  Copyright © 2017 SynchSoft Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
@protocol TutorialViewControllerDelegate <NSObject>

-(void) onNextBtn;


@end

@interface TutorialViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPageControl*pageController;
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (weak, nonatomic) IBOutlet NSString *destinationView;
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
@property (weak, nonatomic) IBOutlet UIButton *NextBtn;
@property (weak, nonatomic) IBOutlet UIView *btnview;
@property (strong,nonatomic) id<TutorialViewControllerDelegate> delegate;

@end

