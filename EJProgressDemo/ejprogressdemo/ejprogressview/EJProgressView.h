//
//  EJProgressView.h
//  EJProgressDemo
//
//  Created by Evelyn on 2016/12/15.
//  Copyright © 2016年 Evelyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
* A progress view for showing progress.
 */
@interface EJProgressView : NSButton


-(id)initOnView:(NSView *)backView;

-(void)setProgressCornerRadius:(float)radius;
-(void)setProgressBackgroundColor:(CGColorRef)rgbColor;
-(void)setBottomColor:(CGColorRef)rgbColor;

-(void)showProgressWithString:(NSString *)msgStr;
-(void)showProgress;
-(void)hideProgress;


@end
