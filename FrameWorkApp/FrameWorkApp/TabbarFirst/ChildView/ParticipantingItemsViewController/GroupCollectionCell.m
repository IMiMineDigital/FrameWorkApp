//
//  GroupCollectionCell.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 17/01/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "GroupCollectionCell.h"
#import "ParticipantingItemViewController.h"
@implementation GroupCollectionCell


-(void)cellOnData:(NSMutableDictionary*)str participantingItemViewController:(ParticipantingItemViewController*)participantingItemViewController index1:(NSInteger)index1
{
    _participantingItemViewController = participantingItemViewController;
     index = index1;
    [array addObject:str];
    [self cellOndata:str];
    
    
}
-(void)cellOndata:(NSMutableDictionary*)dict
{
  NSString*GroupName=[NSString stringWithFormat:@"%@",dict];
  NSMutableArray *arary = [[NSMutableArray alloc] initWithArray:[GroupName componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/:,"]]];

    for (int i=0; i<[arary count]; i++)
    {
        if (no==i)
        {
             array=arary[i];
            [_Groupbtn setTitle:[NSString stringWithFormat:@"Group %@",arary[i]] forState:UIControlStateNormal];
       
        }
        
        
    }
    

}

-(IBAction)ClickGroupbtn:(id)sender
{
    [_participantingItemViewController SelectGroupbtn:array index:index];
}
@end
