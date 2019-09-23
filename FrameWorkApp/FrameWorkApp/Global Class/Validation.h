//
//  Validation.h
//  Skill Grok
//
//  Created by experience on 5/21/14.
//  Copyright (c) 2014 Alcanzar Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ObjectType.h"

@interface Validation : NSObject

+(BOOL)isValidEmail:(NSString *)email;
+(BOOL)isValidImageId:(NSString*) imageName;
+(BOOL)isValidText:(NSString *)text;
+(BOOL)isValidCardNumber:(NSString *)number;
+(BOOL)isPassMatch:(NSString *)pass conpass:(NSString *)conpass;
+(BOOL)isMonth:(NSString *)month;
+(BOOL)isDay:(NSString *)day;
+(BOOL)isYear:(NSString *)year;
+(BOOL)isPass:(NSString *)pass;
+(void) addShadowToViewwhite:(UIView*) view;
+(void)moveUp:(UIView *) controller upMargin:(float)upMargin;
+(void)moveBack:(UIView *) controller downMargin:(float)downMargin;
+(void)showToastOnTop:(NSString *)msg ViewController:(UIViewController*)viewController Seconds:(float) sec ;
+(BOOL)isValidConfirmCardNumber:(NSString *)pre current:(NSString*)current;
+(BOOL)isMatchEmail:(NSString *)email confemail:(NSString*)confemail;
+(BOOL)isValidPreferredStore:(NSString *)store;
+(BOOL)isZipcode:(NSString *)pass;
+(BOOL)ismobilecheck:(NSString *)number;
+(NSString*) getXibName:(NSString*) xibActualName;
+(void) addShadowToView:(UIView*) view;
+(NSString*) getXibName:(NSString*) xibActualName cell:(UITableViewCell*)cell;
+(void)alerViewController:(UIViewController*)view msz:(NSString*)msz;
+(void)setRoundView:(UIView *)view borderWidth:(CGFloat) width  borderColor:(CGColorRef) color radius:(CGFloat)radius;
+(void)zoomIn:(UIView *)_slideshow;
+(void)animationView:(UIView*)view view_y:(CGFloat)view_y;
+(void)getPostImageFromServer_v2:(NSString*)imagename showOnpostimage:(UIImageView*)showOnpostimage;
+(NSString*)convertHtmlPlainText:(NSString*)HTMLString;
+(NSMutableAttributedString *)plainStringToAttributedUnits:(NSString *)string :(NSString *)type;
+(NSMutableAttributedString *)plainStringToAttributedUnitsDouble:(NSString *)string :(NSString *)type;
+(void)Togglebtn:(UIView*)view ;
+(NSMutableAttributedString *)plainStringToAttributedUnitsDeatilspage:(NSString *)string :(NSString *)type;
+(void)setView:(UILabel*)lab;

@end

