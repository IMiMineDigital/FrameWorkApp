//
//  ATSpeechRecognizer.m
//  demo
//
//  Created by kamlesh prajapati on 31/01/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "ATSpeechRecognizer.h"
@interface ATSpeechRecognizer ()
@property SFSpeechAudioBufferRecognitionRequest *speechAudioRec;
@property SFSpeechRecognitionTask *speechRecogTask;
@property SFSpeechRecognizer *speechRecognizer;
@property AVAudioEngine *audioEngine;
@property(strong,atomic) UIView*view1;
@end
@implementation ATSpeechRecognizer
#define kErrorMessageAuthorize  @"You declined the permission to perform speech Permission. Please authorize the operation in your device settings."
#define kErrorMessageRestricted @"Speech recognition isn't available on this OS version. Please upgrade to iOS 10 or later."
#define kErrorMessageNotDetermined  @"Speech recognition isn't authorized yet"
#define kErrorMessageAudioInputNotFound @"This device has no audio input node"
#define kErrorMessageRequestFailed @"Unable to create an SFSpeechAudioBufferRecognitionRequest object"
#define kErrorMessageAudioRecordingFailed   @"Unable to start Audio recording due to failure in Recording Engine"

+ (ATSpeechRecognizer *)sharedObject
{
     static ATSpeechRecognizer *sharedClass = nil;
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
        sharedClass = [[self alloc] init];
     });
     return sharedClass;
}
- (id)init {
    if (self = [super init])
    
    {
        
    }
    return self;
}
#pragma mark - Recognition methods

-(void) activateSpeechRecognizerWithLocaleIdentifier:(NSString *) localeIdentifier andBlock:(void (^)(BOOL isAuthorized))successBlock{
    //enter Described language here
    if([localeIdentifier length]>0){
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
        _speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:locale];
        _speechRecognizer.delegate = self;
        _audioEngine = [[AVAudioEngine alloc] init];
        [self getSpeechRecognizerAuthenticationStatusWithSuccessBlock:^(BOOL isAuthorized) {
            successBlock(isAuthorized);
        }];
    }
    else{
        successBlock(NO);
    }
    
}
-(void) toggleRecording
{
    if(_audioEngine.isRunning)
    {
        [self stopAudioEngine];
        NSLog(@"stop");
    }
    else
    {
        [self startAudioEngine];
             NSLog(@"start");
    }
}

-(void) startAudioEngine
{
   
    [self startRecordingSpeech:nil];
}
-(void) stopAudioEngine{

    [_audioEngine stop];
    [_speechAudioRec endAudio];
    self.speechRecogTask = nil;
    self.speechAudioRec = nil;
  
}
-(void) getSpeechRecognizerAuthenticationStatusWithSuccessBlock:(void (^)(BOOL isAuthorized))successBlock{
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                successBlock(YES);
                break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                [self sendErrorMessageToDelegate:kErrorMessageAuthorize];
                successBlock(NO);
                
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                [self sendErrorMessageToDelegate:kErrorMessageRestricted];
                successBlock(NO);
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                [self sendErrorMessageToDelegate:kErrorMessageNotDetermined];
                successBlock(NO);
                break;
            default:
                break;
        }
    }];
}
-(void) startRecordingSpeech:(NSString*)str
{
    if(_speechRecogTask!=nil)
     {
          [_speechRecogTask cancel];
          _speechRecogTask = nil;
     }
   AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    @try {
       [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
        [audioSession setMode:AVAudioSessionModeMeasurement error:nil];
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [audioSession setActive:YES error:nil];
    } @catch (NSException *exception)
    {
        [self sendErrorMessageToDelegate:exception.reason];
    }
  @try
    {
        _speechAudioRec = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    }
    @catch (NSException *exception)
    {
        [self sendErrorMessageToDelegate:kErrorMessageRequestFailed];
    }
    if(_audioEngine.inputNode!=nil)
     {
        AVAudioInputNode *inputNode = _audioEngine.inputNode;
       _speechAudioRec.shouldReportPartialResults = YES;
       _speechRecogTask = [_speechRecognizer recognitionTaskWithRequest:_speechAudioRec resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error)
        {
             BOOL isFinal = FALSE;
             if(result)
             {
                 if([self isDelegateValidForSelector:NSStringFromSelector(@selector(convertedSpeechToText:))]){
                     [self->_delegate convertedSpeechToText:[[result bestTranscription] formattedString]];
                 }
                   isFinal = !result.isFinal;
                
                 
               
               
             }
            if(error)
            {
                 [self->_audioEngine stop];
                 [inputNode removeTapOnBus:0];
                 self.speechRecogTask = nil;
                 self.speechAudioRec = nil;
              
                 if(error!=nil)
                 {
                    [self stopAudioEngine];
                     [self sendErrorMessageToDelegate:[NSString stringWithFormat:@"%li - %@",error.code, error.localizedDescription]];
                
                }
            }
            
        }];
   
         AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
          [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when)
              {
                 
                  [self.speechAudioRec appendAudioPCMBuffer:buffer];
              }];
           [_audioEngine prepare];
        @try {
            [_audioEngine startAndReturnError:nil];
        } @catch (NSException *exception) {
            [self sendErrorMessageToDelegate:kErrorMessageAudioRecordingFailed];
        }
        
    }
    else
    {
        [self sendErrorMessageToDelegate:kErrorMessageAudioInputNotFound];
    }
    str=@"Say something, I'm listening!";
    
}
-(BOOL) isDelegateValidForSelector:(NSString*)selectorName
{
    if(_delegate!=nil && [_delegate respondsToSelector:NSSelectorFromString(selectorName)])
    {
        return YES;
    }
    return NO;
}

-(void) sendErrorMessageToDelegate:(NSString*) errorMessage
{
    if([self isDelegateValidForSelector:NSStringFromSelector(@selector(sendErrorInfoToViewController:))])
    {
         [_delegate sendErrorInfoToViewController:errorMessage];
    }
}
-(void)hideview:(UIView*)view
{
   view.hidden=YES;
}
#pragma mark - Speech Recognizer Delegate Methods

-(void) speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if(!available){
        [self stopAudioEngine];
    }
    [_delegate speechRecAvailabilityChanged:available];
}
@end
