//
//  CustomProgressView.m
//  Test1
//
//  Created by Evelyn on 2016/8/30.
//  Copyright © 2016年 Evelyn. All rights reserved.
//

#import "CustomProgressView.h"
#import "ITProgressIndicator.h"

@interface CustomProgressView()

@property (strong , nonatomic) NSView * parentView;
@property (strong , nonatomic) CustomProgressView * backgroundView;
@property (strong , nonatomic) ITProgressIndicator * progressView;
@property (strong , nonatomic) NSTextField * messageField;

@end

//加上背景(自由更改背景透明度)，progress，字串
@implementation CustomProgressView

-(id)initFromView:(NSView *)backView setBackAlpha:(float)alpha
{
    //backView = 想要設定的view =parentView
    _backgroundView = [[CustomProgressView alloc] init];
    [_backgroundView setEnabled:YES];
    _backgroundView.title = @"";
    if(!_backgroundView.wantsLayer) {
        CALayer* layer = [CALayer layer];
        _backgroundView.wantsLayer = YES;
        [_backgroundView setLayer:layer];
    }
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [_backgroundView.layer setOpacity:0.5];
    [_backgroundView setHidden:YES];
    _backgroundView.layer.backgroundColor = CGColorCreateGenericGray(0.5, alpha);
//    _backgroundView.layer.backgroundColor = CGColorCreateGenericRGB(1.0, 1.0, 1.0, alpha);
    [backView addSubview:_backgroundView positioned:NSWindowAbove relativeTo:backView];
    
//    NSEdgeInsets padding = NSEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    
    [backView addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:_backgroundView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:backView
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:0.0],
                                
                                [NSLayoutConstraint constraintWithItem:_backgroundView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:backView
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1.0
                                                              constant:0.0],
                                
                                [NSLayoutConstraint constraintWithItem:_backgroundView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:backView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:0.0],
                                
                                [NSLayoutConstraint constraintWithItem:_backgroundView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:backView
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0.0]
                                
                                ]];
    
    
    _parentView = [[NSView alloc] init];
    if(!_parentView.wantsLayer) {
        CALayer* layer = [CALayer layer];
        [_parentView setLayer:layer];
        _parentView.wantsLayer = YES;
    }
    [_parentView.layer setCornerRadius:15.0];
//    [_parentView.layer setBorderWidth:1.5];
//    [_parentView.layer setBorderColor:CGColorCreateGenericRGB(163/255, 163/255, 163/255, 0.9)];
    _parentView.translatesAutoresizingMaskIntoConstraints = NO;
    _parentView.layer.backgroundColor = CGColorCreateGenericRGB(0.5, 0.5, 0.5, 0.5);
    [_backgroundView addSubview:_parentView];
//    [self changeParentViewConstraint:YES];
    //15.0, 35.0, 100.0, 100.0
    _progressView = [[ITProgressIndicator alloc] initWithFrame:NSMakeRect(20.0, 50.0, 90.0, 90.0)];
    [_progressView setIndeterminate:YES];
    _progressView.animates = NO;
    _progressView.widthOfLine = 3.0;
    _progressView.lengthOfLine = 25.0;//30.0
    _progressView.innerMargin = 12.0;//15.0
    _progressView.numberOfLines = 10;
    _progressView.animationDuration = YES;
    _progressView.steppedAnimation = YES;
    _progressView.hideWhenStopped = YES;
    [_parentView addSubview:_progressView];
    

    
    _messageField = [[NSTextField alloc] initWithFrame:NSMakeRect(0.0, 0.0, 130.0, 40.0)];
    _messageField.editable = NO;
    [_messageField setPreferredMaxLayoutWidth:130.0];
    NSTextFieldCell * msgCell = [[NSTextFieldCell alloc] init];
    [msgCell setWraps:YES];
    [msgCell setLineBreakMode:NSLineBreakByWordWrapping];
    [msgCell setAlignment:NSTextAlignmentCenter];

    NSFont * boldFont = [NSFont boldSystemFontOfSize:15.0f];
    
    msgCell.font = boldFont;
    _messageField.cell = msgCell;
    _messageField.hidden = YES;
    [_parentView addSubview:_messageField];
    
    return self;
}


//- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//    
//    // Drawing code here.
//    
//    
//}

-(void)setProgressBackgroundColor:(CGColorRef)rgbColor
{
    _parentView.layer.backgroundColor = rgbColor;
}

-(void)changeParentViewConstraint:(BOOL)hasStr
{
    float strHeight , strWidth;
    if(hasStr){
        strHeight = 150.0;//135
        strWidth = 130.0;
    }else{
        strHeight = 110.0;
        strWidth = 110.0;
    }
    [_backgroundView addConstraints:@[
                                      [NSLayoutConstraint constraintWithItem:_parentView
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_backgroundView
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0
                                                                    constant:0.0],
                                      
                                      [NSLayoutConstraint constraintWithItem:_parentView
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_backgroundView
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.0
                                                                    constant:0.0],
                                      
                                      [NSLayoutConstraint constraintWithItem:_parentView
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:1.0
                                                                    constant:strWidth],
                                      
                                      [NSLayoutConstraint constraintWithItem:_parentView
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeHeight
                                                                  multiplier:1.0
                                                                    constant:strHeight]
                                      ]];
    
}


-(void)showProgressString:(NSString *)msgStr
{
    [_backgroundView setHidden:NO];
     _progressView.animates = YES;
    
    if (msgStr == nil || [msgStr isEqualToString:@""])
    {
        _messageField.hidden = YES;
        [_progressView setFrame:NSMakeRect(10.0, 10.0, 90.0, 90.0)];//5.0, 5.0, 100.0, 100.0
        [self changeParentViewConstraint:NO];
    }
    else
    {
        [_progressView setFrame:NSMakeRect(20.0, 50.0, 90.0, 90.0)];//15.0, 40.0, 100.0, 100.0
        _messageField.hidden = NO;
        _messageField.stringValue = msgStr;
        [self changeParentViewConstraint:YES];
    }
}

-(void)hideProgress
{
    if(_backgroundView != nil)
    {
        _progressView.animates = NO;
        [_progressView setHidden:YES];
        [_backgroundView removeFromSuperview];
        _backgroundView = nil;
    }
    
}

@end
