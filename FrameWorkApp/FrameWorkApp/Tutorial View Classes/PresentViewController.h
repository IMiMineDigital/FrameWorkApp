//
//  PresentViewController.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 25/02/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol PresentViewControllerDelegate <NSObject>

-(void) onNextBtn;


@end
@interface PresentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIPageControl*pageController;
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (weak, nonatomic) IBOutlet NSString *destinationView;
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
@property (weak, nonatomic) IBOutlet UIButton *NextBtn;
@property (weak, nonatomic) IBOutlet UIView *btnview;
@property (strong,nonatomic) id<PresentViewControllerDelegate> delegate;


@property (weak, nonatomic) IBOutlet NSString *comefrom;
-(void)dismisFun;
@end

NS_ASSUME_NONNULL_END
