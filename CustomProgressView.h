//
//  CustomProgressView.h
//  Test1
//
//  Created by Evelyn on 2016/8/30.
//  Copyright © 2016年 Evelyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CustomProgressView : NSButton


-(id)initFromView:(NSView *)backView setBackAlpha:(float)alpha;
-(void)setProgressBackgroundColor:(CGColorRef)rgbColor;
-(void)showProgressString:(NSString *)msgStr;
-(void)hideProgress;

@end
