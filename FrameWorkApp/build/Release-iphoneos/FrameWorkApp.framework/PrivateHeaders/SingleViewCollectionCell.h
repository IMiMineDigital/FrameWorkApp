//
//  SingleViewCollectionCell.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 5/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//
//
//#import <UIKit/UIKit.h>
//
//
//
//@interface SingleViewCollectionCell : UICollectionViewCell
//
//@end

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Validation.h"
#import "UIImageView+AFNetworking.h"
#import "ObjectType.h"

#import <SVProgressHUD.h>

@class MyPersonalPriceViewController;
@interface SingleViewCollectionCell : UICollectionViewCell
{
    NSInteger index;
}
-(void)cellOnData:(NSMutableDictionary*)str myPersonalPriceViewController:(MyPersonalPriceViewController*)myPersonalPriceViewController index1:(NSInteger)index1;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *savepriceimg;
@property (weak, nonatomic) IBOutlet UILabel *product_name;
@property (weak, nonatomic) IBOutlet UILabel *product_price;
@property (weak, nonatomic) IBOutlet UIView *shoadShow;
@property (weak, nonatomic) IBOutlet UIButton *seeeDetailsBtn;
@property (weak, nonatomic) IBOutlet UIButton *activbtn;
@property (weak, nonatomic) IBOutlet UILabel *ActivateBtn;
@property (weak, nonatomic) IBOutlet UIButton *ProductDetailsBtn;
@property (weak, nonatomic) IBOutlet UILabel *product_addPrice;
@property (weak, nonatomic) IBOutlet UILabel *product_RePrice;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *cornerView;
@property (weak, nonatomic) IBOutlet UILabel *offlab;

@property (weak, nonatomic) IBOutlet UITextView *textvieeproce;
@property (weak, nonatomic) IBOutlet UILabel *savePrice;
@property (weak, nonatomic) IBOutlet UILabel *perpoundlab;
@property (weak, nonatomic) IBOutlet UIView *savelineview;

@property (weak, nonatomic) IBOutlet UILabel *product_titleactivelab;
@property (weak, nonatomic) IBOutlet UIImageView *activeimg;
//long price
@property (weak, nonatomic) IBOutlet UILabel *Getproductprice;



@property (weak, nonatomic) IBOutlet UIImageView *stickersimg;

@property (weak, nonatomic) IBOutlet UILabel *countproductlab;
@property (weak, nonatomic) IBOutlet UILabel *addlab;
@property (weak, nonatomic) IBOutlet UILabel *sublab;
@property (weak, nonatomic) IBOutlet UIView *removeview;
@property (weak, nonatomic) IBOutlet UIView *Activateview;


@property (weak, nonatomic) IBOutlet UIButton *removebtn;
@property (weak, nonatomic) IBOutlet UILabel *additemsplus;

@property (weak, nonatomic) IBOutlet UIView *Relateditemsview;
@property (weak, nonatomic) IBOutlet UILabel *withfraewaytitle;
@property (weak, nonatomic) IBOutlet UIView *linesaveprice2;
@property (weak, nonatomic) IBOutlet UIView *linesaveprice;
@property (weak, nonatomic) IBOutlet UILabel *adddigitallab;
@property (weak, nonatomic) IBOutlet UILabel *limitShowlab;
@property (weak, nonatomic) IBOutlet UIButton *relateditemsbtn;
@property(atomic, weak)MyPersonalPriceViewController *myPersonalPriceViewController;
@property (weak, nonatomic) IBOutlet UILabel *dolerlab;
@property (weak, nonatomic) IBOutlet UILabel *fflab;
@end

//
//NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//if ([[celldata valueForKey:@"PrimaryOfferTypeId"] integerValue]==3)
//{
//    //        if ([[celldata valueForKey:@"RequiresActivation"] boolValue]==true)
//    //       {
//    //        if ([[celldata valueForKey:@"ClickCount"] integerValue]==0)
//    //        {
//    //            cell.product_titleactivelab.text=@"Activate";
//    //            cell.activbtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
//    //            cell.countproductlab.hidden=YES;
//    //            cell.removeview.hidden=YES;
//    //           // cell.activeimg.image = [UIImage imageNamed:@"add.png" inBundle:bundle compatibleWithTraitCollection:nil];
//    //
//    //        }
//    //        else
//    //        {
//    
//    if([[celldata valueForKey:@"ListCount"] integerValue]==1)
//    {
//        
//        cell.product_titleactivelab.text=@"Activated";
//        cell.activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
//        cell.activbtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
//        cell.removeview.hidden=YES;
//        
//        // cell.product_titleactivelab.text=@"Added";
//        //[cell.activbtn setTitle:@"Added" forState:UIControlStateNormal];
//        //[cell.activbtn setImage:[UIImage imageNamed:@"checkmar.png"] forState:UIControlStateNormal];
//        //                cell.removeview.hidden=NO;
//        
//    }
//    else
//    {
//        cell.activbtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
//        cell.product_titleactivelab.text=@"Activate";
//        cell.removeview.hidden=YES;
//        
//        
//        //cell.product_titleactivelab.text=@"Add";
//        // cell.activeimg.image = [UIImage imageNamed:@"add.png" inBundle:bundle compatibleWithTraitCollection:nil];
//        //                                    [cell.activbtn setTitle:@"Add" forState:UIControlStateNormal];
//        //                                    [cell.activbtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
//        
//    }
//    //  }
//    //  }
//    //    else
//    //    {
//    //        if ([[celldata valueForKey:@"ClickCount"] integerValue]==0)
//    //        {
//    //            cell.product_titleactivelab.text=@"Activate";
//    //            cell.activbtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
//    //            cell.removeview.hidden=YES;
//    //
//    //           // cell.product_titleactivelab.text=@"Add";
//    //            // cell.activeimg.image = [UIImage imageNamed:@"add.png" inBundle:bundle compatibleWithTraitCollection:nil];
//    //
//    //
//    //        }
//    //        else
//    //        {
//    //            if ([[celldata valueForKey:@"ListCount"] integerValue]==1)
//    //            {
//    //
//    //                cell.product_titleactivelab.text=@"Activated";
//    //                cell.activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
//    //                cell.activbtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
//    //                cell.removeview.hidden=YES;
//    //
//    //
//    //
//    //                //cell.product_titleactivelab.text=@"Added";
//    //               // cell.removeview.hidden=NO;
//    //
//    //            }
//    //            else
//    //            {
//    //
//    //                cell.product_titleactivelab.text=@"Activate";
//    //                cell.activbtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
//    //                cell.removeview.hidden=YES;
//    //
//    //
//    //
//    //               // cell.product_titleactivelab.text=@"Add";
//    //               // cell.activeimg.image = [UIImage imageNamed:@"add.png" inBundle:bundle compatibleWithTraitCollection:nil];
//    //               //cell.removeview.hidden=YES;
//    //            }
//    //
//    //        }
//    // }
//}
//else if([[celldata valueForKey:@"PrimaryOfferTypeId"] integerValue]==2)
//{
//    if ([[celldata valueForKey:@"ClickCount"] integerValue]>0)
//    {
//        cell.product_titleactivelab.text=@"Activated";
//        cell.activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
//        //          [cell.activbtn setTitle:@"Activated" forState:UIControlStateNormal];
//        //          [cell.activbtn setImage:[UIImage imageNamed:@"checkmar.png"] forState:UIControlStateNormal];
//        cell.activbtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
//        
//        cell.removeview.hidden=YES;
//    }
//    else
//    {
//        cell.product_titleactivelab.text=@"Activate";
//        cell.activbtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
//        cell.removeview.hidden=YES;
//        
//        // cell.activeimg.image = [UIImage imageNamed:@"add.png" inBundle:bundle compatibleWithTraitCollection:nil];
//        //        [cell.activbtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
//        //        [cell.activbtn setTitle:@"Activate" forState:UIControlStateNormal];
//        
//        
//    }
//}
//else if([[celldata valueForKey:@"PrimaryOfferTypeId"] integerValue]==1)
//{
//    //    if ([[celldata valueForKey:@"ListCount"] integerValue]==0)
//    ////    {
//    //        cell.product_titleactivelab.text=@"Add";
//    //       // cell.activeimg.image = [UIImage imageNamed:@"add.png" inBundle:bundle compatibleWithTraitCollection:nil];
//    //       cell.activbtn.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
//    //
//    //        cell.removeview.hidden=YES;
//    //
//    //    }
//    //    else
//    //    {
//    //
//    //        cell.product_titleactivelab.text=@"Added";
//    //        cell.activeimg.image = [UIImage imageNamed:@"checkmar.png" inBundle:bundle compatibleWithTraitCollection:nil];
//    //         cell.activbtn.backgroundColor=[UIColor colorWithRed:77/255.0 green:138/255.0 blue:69/255.0 alpha:1.0];
//    //
//    //        cell.removeview.hidden=NO;
//    //  }
//    cell.removeview.hidden=YES;
//    cell.Activateview.hidden=YES;
//    cell.limitShowlab.hidden=YES;
//}
//[cell cellOnData:celldata myPersonalPriceViewController:self index1:index];
