//
//  AdditionalOffers.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 21/07/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "AdditionalOffers.h"
#import "ObjectType.h"
@implementation AdditionalOffers

- (void)awakeFromNib {
    [super awakeFromNib];
       _title.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
       _PAtitle.backgroundColor=[UIColor colorWithRed:208/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
        NSArray*arra=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"storename"];
       _storetitle.text=[NSString stringWithFormat:@"%@",arra[0]];
    
}

@end
