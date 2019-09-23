//
//  SelectStoreNameViewController.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 21/12/18.
//  Copyright © 2018 kamlesh prajapati. All rights reserved.
//

#import "SelectStoreNameViewController.h"
#import "Validation.h"
#import "HomeViewController.h"
#import "ObjectType.h"
#import "SingleTanGlobalClass.h"
@interface SelectStoreNameViewController ()
{

        NSMutableArray*filercatarrayObj;
        NSMutableArray*offerFilterarrayObj;
        UIStoryboard*storyboard;
        NSMutableArray*allCatarrayObj;
        NSMutableArray*cattypedata;
        NSMutableArray*moreCoupnseArray;
        NSMutableArray*sortedarray;
    
    
    
    
        NSMutableArray*Dealsarray;
        NSMutableArray*digitalCouponsearray;
        NSMutableArray*saleitemsarray;
    
       NSMutableArray*alldatafilteroffersarray;
}
@end

@implementation SelectStoreNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       filercatarrayObj=[[NSMutableArray alloc] init];
       [self.dataload setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
       [self GetCatList];
       [self GetCatTypefilter];
  
       [self TitleSaveFromHeader];
       [Validation addShadowToView:_headerView];
       cattypedata=[[NSMutableArray alloc] init];
  
    
     Dealsarray=[[NSMutableArray alloc] init];
     digitalCouponsearray=[[NSMutableArray alloc] init];
     saleitemsarray=[[NSMutableArray alloc] init];
     [self FiltersByOffers];
}
-(void)TitleSaveFromHeader
{
   if ([_isCheckcontrollerstr isEqualToString:NSLocalizedString(@"Personal Ad", @"")])
    {
       if ([_comefrom isEqualToString:@"Catogories"])
        {
            _HeaderTitle.text=@"Filter By Catogories";
        }
        else if([_comefrom isEqualToString:@"Filters"])
        {
            
            _HeaderTitle.text=@"Filter By Offers";
        }
    }

}
-(void)GetCatList
{
    
    //[filercatarrayObj removeAllObjects];
//     filercatarrayObj=(NSMutableArray*)_categoriesArray;
     filercatarrayObj=(NSMutableArray*)_filterCatOrgdict;
     allCatarrayObj=[[NSMutableArray alloc] init];
     sortedarray=[[NSMutableArray alloc] init];
    
 
    
     NSString*CateGoryID=@"";
     NSString*hasstrID=@"";
     NSString*CateGoryIDes=@"";

    NSString*str=[NSString stringWithFormat:@"%d",[filercatarrayObj objectAtIndex:0]];
      NSInteger countAll=0;
        countAll=[filercatarrayObj count];
        for (int i=0; i<[filercatarrayObj count]; i++)
        {
            if(CateGoryID!=filercatarrayObj[i][@"CategoryID"])
            {
                hasstrID=[NSString stringWithFormat:@"%@%@%@",@"#",filercatarrayObj[i][@"CategoryID"],@"#"];
                if(![CateGoryIDes containsString:hasstrID])
                {
                    CateGoryIDes = [NSString stringWithFormat:@"%@%@%@%@%@",CateGoryIDes,@"#",filercatarrayObj[i][@"CategoryID"],@"#",@","];
                    CateGoryID=filercatarrayObj[i][@"CategoryID"];
                  
                    NSInteger contcar=0;
                    for (int j=0; j<[filercatarrayObj count]; j++)
                    {
                        if(CateGoryID==filercatarrayObj[j][@"CategoryID"])
                        {
                            contcar=contcar+1;
                        }
                    }
                    if (i==0) {
                        NSMutableDictionary*Temp=[[NSMutableDictionary alloc] init];
                        [Temp setObject:@"0" forKey:@"CategoryID"];
                        [Temp setObject:[NSString stringWithFormat:@"%@(%ld)",@"All Category",(long)countAll] forKey:@"CategoryName"];
                         [sortedarray addObject:Temp];
                    }
                    NSMutableDictionary*Temp=[[NSMutableDictionary alloc] init];
                    [Temp setObject:filercatarrayObj[i][@"CategoryID"] forKey:@"CategoryID"];
                    [Temp setObject:[NSString stringWithFormat:@"%@(%ld)",filercatarrayObj[i][@"CategoryName"],(long)contcar] forKey:@"CategoryName"];
                      [sortedarray addObject:Temp];

                    
                }
            }
            
        }
    
   
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"CategoryName" ascending:YES];
    allCatarrayObj=(NSMutableArray*)[sortedarray sortedArrayUsingDescriptors:@[sort]];
    
}
-(void)GetCatTypefilter
{
    
    offerFilterarrayObj=[[NSMutableArray alloc] init];
    {
        NSMutableDictionary*CatDict=[[NSMutableDictionary alloc] init];
        [CatDict setObject:@"All My Offers" forKey:@"Filers"];
        [offerFilterarrayObj addObject:CatDict];
        
    }
    {
        NSMutableDictionary*CatDict=[[NSMutableDictionary alloc] init];
        [CatDict setObject:@"My Personal Deals" forKey:@"Filers"];
        [offerFilterarrayObj addObject:CatDict];
        
    }
    {
        NSMutableDictionary*CatDict=[[NSMutableDictionary alloc] init];
        [CatDict setObject:@"Digital Coupons" forKey:@"Filers"];
        [offerFilterarrayObj addObject:CatDict];
        
    }
    {
        NSMutableDictionary*CatDict=[[NSMutableDictionary alloc] init];
        [CatDict setObject:@"Sale Items" forKey:@"Filers"];
        [offerFilterarrayObj addObject:CatDict];
        
    }
  
  
}


-(IBAction)backbtn:(id)sender
{
 [self.navigationController popViewControllerAnimated:YES];
}


-(void)storybord
{
    
    if(isiPhone5s)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:HomeViewController.class]];
       // NSLog(@"isiPhone5s");
    }
    else if(isiPhone6)
    {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main7" bundle:[NSBundle bundleForClass:HomeViewController.class]];
       // NSLog(@"Main7");
    }
    else if(isiPhone8Plus)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main8" bundle:[NSBundle bundleForClass:HomeViewController.class]];
        
       // NSLog(@"Main8");
    }
    else if(isiPhoneX ||isiPhoneXsMax)
    {
        storyboard = [UIStoryboard storyboardWithName:@"MainX" bundle:[NSBundle bundleForClass:HomeViewController.class]];
        
       // NSLog(@"MainX");
    }
    else if(isiPad ||isiPadSmall)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Mainipad" bundle:[NSBundle bundleForClass:HomeViewController.class]];
       // NSLog(@"Mainipad");
    }
    else{
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:HomeViewController.class]];
        
       // NSLog(@"Main2");
    }
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:( NSIndexPath *)indexPath
{
    
    return 45;
    
}
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([_isCheckcontrollerstr isEqualToString:NSLocalizedString(@"Personal Ad", @"")])
    {
        if ([_comefrom isEqualToString:@"Catogories"])
        {
            return [allCatarrayObj count];
            
        }
        else
        {
            return [offerFilterarrayObj count];
        }
        
    }
    else
    {
        if ([_comefrom isEqualToString:@"Catogories"])
        {
            return [allCatarrayObj count];
            
        }
        else
        {
            return [moreCoupnseArray count];
        }
        
        
    }
    return 0;
    
}
SelectSecreteCell*celll;
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath
{
    
    static NSString*CellIdentifier=@"SelectSecreteCell";
    celll=(SelectSecreteCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (celll==nil)
    {
     [tableView registerNib:[UINib nibWithNibName:@"SelectSecreteCell" bundle:[NSBundle bundleForClass:SelectSecreteCell.class]] forCellReuseIdentifier:CellIdentifier];
        celll=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
      celll.selectionStyle=UITableViewCellSelectionStyleNone;

     if ([_isCheckcontrollerstr isEqualToString:NSLocalizedString(@"Personal Ad", @"")])
     {
      if ([_comefrom isEqualToString:@"Catogories"])
      {
          celll.city_name.text=[NSString stringWithFormat:@"%@",[allCatarrayObj[indexPath.row] valueForKey:@"CategoryName"]];
      }
      else if ([_comefrom isEqualToString:@"Filters"])
      {
          NSMutableDictionary*FilSelectRowData=offerFilterarrayObj[indexPath.row][@"Filers"];
          [celll celldata:FilSelectRowData];
      }


  }
//  else
//  {
//      if ([_comefrom isEqualToString:@"Catogories"])
//      {
//          celll.city_name.text=[NSString stringWithFormat:@"%@",[allCatarrayObj[indexPath.row] valueForKey:@"CategoryName"]];
//      }
//      else if ([_comefrom isEqualToString:@"Filters"])
//      {
//          NSMutableDictionary*FilSelectRowData=moreCoupnseArray[indexPath.row][@"Couponse"];
//          [celll celldata:FilSelectRowData];
//      }
//
//
//  }
     return celll;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

     if ([_isCheckcontrollerstr isEqualToString:NSLocalizedString(@"Personal Ad", @"")])
     {
         if ([_comefrom isEqualToString:@"Filters"])
         {
             _HeaderTitle.text=@"Filter By Offers";
             [self storybord];
            HomeViewController*vc=(HomeViewController*)[storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            vc.isCheckController=_isCheckcontrollerstr;
           
             if (indexPath.row==0)
             {
                      vc.filtertype=@"Filters";
                      vc.idcatarray=alldatafilteroffersarray;
                      vc.FilterByoffersarray=alldatafilteroffersarray;
                      [self.navigationController pushViewController:vc animated:YES];
                 
             }
             else if (indexPath.row==1)
             {
              
                   vc.filtertype=@"Filters";
                   vc.comefrom=@"Deals";
                   vc.idcatarray=Dealsarray;
                   vc.FilterByoffersarray=alldatafilteroffersarray;
                   [self.navigationController pushViewController:vc animated:YES];
             }
             else if (indexPath.row==2)
             {
            
                     vc.filtertype=@"Filters";
                     vc.comefrom=@"Coupons";
                     vc.idcatarray=digitalCouponsearray;
                     vc.FilterByoffersarray=alldatafilteroffersarray;
                     [self.navigationController pushViewController:vc animated:YES];
                 
                 
             }
             else if (indexPath.row==3)
             {
                  vc.filtertype=@"Filters";
                  vc.comefrom=@"items";
                  vc.idcatarray=saleitemsarray;
                  vc.FilterByoffersarray=alldatafilteroffersarray;
              [self.navigationController pushViewController:vc animated:YES];
                 
             }
            
             
         }
         else if ([_comefrom isEqualToString:@"Catogories"])
         {
             
              _HeaderTitle.text=@"Filter By Catogories";
              [self storybord];
              HomeViewController*vc=(HomeViewController*)[storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
              vc.filtertype=@"Catogories";
              vc.isCheckController=_isCheckcontrollerstr;
       
             if([allCatarrayObj[indexPath.row][@"CategoryID"] integerValue]==0)
             {
                  vc.idcatarray=filercatarrayObj;
                  // vc.FilterByoffersarray=alldatafilteroffersarray;
             }
             else
             {
                 NSInteger index=[allCatarrayObj[indexPath.row][@"CategoryID"] integerValue];
                 for ( int i=0; i<[filercatarrayObj count]; i++)
                 {
                     if ([filercatarrayObj[i][@"CategoryID"] integerValue]==index)
                     {
                        [cattypedata addObject:filercatarrayObj[i]];
                         vc.idcatarray=cattypedata;
                        //vc.FilterByoffersarray=alldatafilteroffersarray;
                     }
                     
                 }
                 
             }
                [self.navigationController pushViewController:vc animated:YES];
             
         }
   }
//   else
//   {
//
//       if ([_comefrom isEqualToString:@"Filters"])
//       {
//           _HeaderTitle.text=@"Filter By Offers";
//           [self storybord];
//            HomeViewController*vc=(HomeViewController*)[storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//            vc.isCheckController=_isCheckcontrollerstr;
//               if (indexPath.row==0)
//               {
//                [self.navigationController pushViewController:vc animated:YES];
//
//               }
//               else if (indexPath.row==1)
//               {
//
//                   [self.navigationController pushViewController:vc animated:YES];
//               }
//
//
//       }
//       else if ([_comefrom isEqualToString:@"Catogories"])
//       {
//           _HeaderTitle.text=@"Filter By Catogories";
//           [self storybord];
//            HomeViewController*vc=(HomeViewController*)[storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//            vc.filtertype=@"MoreCat";
//            vc.isCheckController=_isCheckcontrollerstr;
//           if([allCatarrayObj[indexPath.row][@"CategoryID"] integerValue]==0)
//           {
//               vc.idcatarray=filercatarrayObj;
//           }
//           else
//           {
//               NSInteger index=[allCatarrayObj[indexPath.row][@"CategoryID"] integerValue];
//               for ( int i=0; i<[filercatarrayObj count]; i++)
//               {
//                   if ([filercatarrayObj[i][@"CategoryID"] integerValue]==index)
//                   {
//
//                       [cattypedata addObject:filercatarrayObj[i]];
//                       vc.idcatarray=cattypedata;
//
//                   }
//
//               }
//
//           }
//
//           [self.navigationController pushViewController:vc animated:YES];
//
//       }
//
//  }

}
-(void)FiltersByOffers
{
    
      NSMutableArray*array=(NSMutableArray*)_categoriesArray;
    alldatafilteroffersarray=(NSMutableArray*)_categoriesArray;
//      [[SingleTanGlobalClass instance] FilterdataStore:array];
//      NSMutableArray*filarray=[[SingleTanGlobalClass instance] FilterdataStoreRetrunAll];
    
       for (int j=0; j<[array count]; j++)
            {
                if ([array[j][@"PrimaryOfferTypeId"] integerValue]==1)
                {
                    [saleitemsarray  addObject:array[j]];
                }
               else if ([array[j][@"PrimaryOfferTypeId"] integerValue]==3)
                {
                    [Dealsarray  addObject:array[j]];
                }
              else  if ([array[j][@"PrimaryOfferTypeId"] integerValue]==2)
                {
                    [digitalCouponsearray  addObject:array[j]];
           
                }

            }
    
    
}



@end
