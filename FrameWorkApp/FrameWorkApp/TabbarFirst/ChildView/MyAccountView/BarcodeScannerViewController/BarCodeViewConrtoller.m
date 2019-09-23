//
//  BarCodeViewConrtoller.m
//  FrameWorkApp
//
//  Created by kamlesh prajapati on 8/05/19.
//  Copyright © 2019 kamlesh prajapati. All rights reserved.
//

#import "BarCodeViewConrtoller.h"
#import <AVFoundation/AVFoundation.h>
#import "Validation.h"
#import "ApiHendlerClass.h"
@interface BarCodeViewConrtoller ()<AVCaptureMetadataOutputObjectsDelegate>
{
     CIFilter *filter;
     CIFilter *barCodeFilter;
}
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureLayer;
@end

@implementation BarCodeViewConrtoller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScanningSession];
    [Validation addShadowToView:_headerView];
 
}

- (void)setupScanningSession {
   
    NSArray*array=(NSArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:USERDATA] valueForKey:@"ShopperID"];
   _txtlab.text=[NSString stringWithFormat:@"%@%@",@"45",array[0]];
    NSString*str=[NSString stringWithFormat:@"%@",_txtlab.text];
    if (str)
    {
     
         NSData *barCodeData=[str dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:false];
         filter=[CIFilter  filterWithName:@"CICode128BarcodeGenerator"];
        
         [filter setValue:barCodeData forKey:@"inputMessage"];
         UIImage*image=[UIImage imageWithCIImage:filter.outputImage];
        _img.image=image;
    }
    
}
-(IBAction)back:(id)sender
{
      [self.navigationController popViewControllerAnimated:YES];
//    ApiHendlerClass*dissmisswindow=[ApiHendlerClass new];
//    [dissmisswindow dissmisscontroller];
}
@end
