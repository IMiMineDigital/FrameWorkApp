//
//  FooterCell.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 20/07/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "FooterCell.h"
#import "MyPersonalPriceViewController.h"
@implementation FooterCell
{
   
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [Validation setRoundView:self.Applebtn1 borderWidth:0 borderColor:nil radius:5];
    [Validation setRoundView:self.Applebtn2 borderWidth:0 borderColor:nil radius:5];
    _Applebtn1.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
    _Applebtn2.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
}
-(void)celldata:(MyPersonalPriceViewController*)myPersonalPriceViewController index:(NSInteger)index
{
  _myPersonalPriceViewController = myPersonalPriceViewController;
    index1=index;
}
-(IBAction)Applebtn1:(id)sender
{
    
    NSLog(@"Applebtn1");
    
    [_myPersonalPriceViewController apple1:index1];
    //[self cancelSearching];
    
}
-(IBAction)Applebtn2:(id)sender
{
    
    
    NSLog(@"Applebtn2");
      [_myPersonalPriceViewController apple2:index1];
    // [self cancelSearching];
}
@end
