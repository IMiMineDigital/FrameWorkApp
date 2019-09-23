//
//  GroupCollectionCell.h
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 17/01/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ParticipantingItemViewController;
@interface GroupCollectionCell : UICollectionViewCell
{
        NSInteger index;
       NSMutableArray*array;
       NSInteger no;
}
//-(void)selectGroupbtn:(NSInteger)index dict:(NSMutableDictionary*)dict;

-(void)cellOnData:(NSMutableDictionary*)str participantingItemViewController:(ParticipantingItemViewController*)participantingItemViewController index1:(NSInteger)index1;

@property(strong,atomic)IBOutlet UIButton*Groupbtn;
@property(atomic, weak)ParticipantingItemViewController *participantingItemViewController;

@end

NS_ASSUME_NONNULL_END
