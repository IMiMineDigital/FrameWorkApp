


#import <UIKit/UIKit.h>
#import "SelectSecreteCell.h"
@protocol SelectStoreNameViewControllerDelegate <NSObject>

@end
@interface SelectStoreNameViewController : UIViewController
@property(strong,atomic) NSArray*arrayObj;
//@property(strong,atomic) NSMutableArray*categoriesArray;

@property(strong,atomic) NSMutableDictionary*categoriesArray;

@property(strong,atomic) NSMutableDictionary*filterCatOrgdict;
@property(strong,atomic) NSMutableDictionary*gloaray;
@property(strong,atomic) NSString*comefrom;
@property(strong,atomic) NSString*isCheckcontrollerstr;
@property(strong,atomic)IBOutlet UITableView*dataload;
@property (weak, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property(strong,atomic)id<SelectStoreNameViewControllerDelegate>delegate;
@end


//        else if([allCatarrayObj[indexPath.row][@"CategoryID"] integerValue]==0)
//         {
//           HomeViewController*vc=(HomeViewController*)[storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//            vc.filtertype=@"Catogories";
//           vc.idcatarray=filercatarrayObj;
//           [self.navigationController pushViewController:vc animated:YES];
//
//       }











