//
//  ATSpeechRecognizer.h
//  demo
//
//  Created by kamlesh prajapati on 31/01/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ATSpeechRecognizerState)
{
    ATSpeechRecognizerStateRunning,
    ATSpeechRecognizerStateStopped
};
@protocol ATSpeechDelegate <NSObject>
@required
-(void)convertedSpeechToText:(NSString *) parsedText;
/*This method relays change in Speech recognition ability to delegate responder class*/
-(void) speechRecAvailabilityChanged:(BOOL) status;
/*This method relays error messages to delegate responder class*/
-(void) sendErrorInfoToViewController:(NSString *) errorMessage;
-(void)hideview:(UIView*)view;

@optional
/*This method relays info regarding whether speech rec is running or stopped to delegate responder class. State with be either ATSpeechRecognizerStateRunning or ATSpeechRecognizerStateStopped. You may or may not implement this method*/
-(void) changeStateIndicator:(ATSpeechRecognizerState) state;
@end
@interface ATSpeechRecognizer : NSObject <SFSpeechRecognizerDelegate>
+ (ATSpeechRecognizer *)sharedObject;
@property (weak, nonatomic) id<ATSpeechDelegate> delegate;

-(void) toggleRecording;
-(void) stopRecording;
//-(void)hideview:(UIView*)view;
-(void) activateSpeechRecognizerWithLocaleIdentifier:(NSString *) localeIdentifier andBlock:(void (^)(BOOL isAuthorized))successBlock;
@end


NS_ASSUME_NONNULL_END
