//
//  EJProgressView.m
//  EJProgressDemo
//
//  Created by Evelyn on 2016/12/15.
//  Copyright © 2016年 Evelyn. All rights reserved.
//

#import "EJProgressView.h"
#import "ITProgressIndicator.h"

@interface EJProgressView()

@property (strong , nonatomic) NSView * parentView; //outer view
//@property (strong , nonatomic) EJProgressView * backgroundView;
@property (strong , nonatomic) ITProgressIndicator * progressIndicator;
@property (strong , nonatomic) NSTextField * messageField;

@end


@implementation EJProgressView

-(id)initOnView:(NSView *)backView
{
    self = [super init];
    if(self != nil && backView != nil)
    {
        [self setEnabled:YES];  //if set YES, textField won't focus.
        self.title = @"";
        if(!self.wantsLayer) {
            CALayer* layer = [CALayer layer];
            self.wantsLayer = YES;
            [self setLayer:layer];
        }
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self.layer setOpacity:0.5];
        [self setHidden:YES];
        self.layer.backgroundColor = CGColorCreateGenericGray(0.5, 0.5);
        [backView addSubview:self positioned:NSWindowAbove relativeTo:backView];
        
        [backView addConstraints:@[
                                   [NSLayoutConstraint constraintWithItem:self
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:backView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:0.0],
                                   
                                   [NSLayoutConstraint constraintWithItem:self
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:backView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0
                                                                 constant:0.0],
                                   
                                   [NSLayoutConstraint constraintWithItem:self
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:backView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:0.0],
                                   
                                   [NSLayoutConstraint constraintWithItem:self
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
        [self addSubview:_parentView];
        
        //15.0, 35.0, 100.0, 100.0
        _progressIndicator = [[ITProgressIndicator alloc] initWithFrame:NSMakeRect(20.0, 50.0, 90.0, 90.0)];
        [_progressIndicator setIndeterminate:YES];
        _progressIndicator.animates = NO;
        _progressIndicator.widthOfLine = 3.0;
        _progressIndicator.lengthOfLine = 25.0;//30.0
        _progressIndicator.innerMargin = 12.0;//15.0
        _progressIndicator.numberOfLines = 10;
        _progressIndicator.animationDuration = YES;
        _progressIndicator.steppedAnimation = YES;
        _progressIndicator.hideWhenStopped = YES;
        [_parentView addSubview:_progressIndicator];
        
        
        
        _messageField = [[NSTextField alloc] initWithFrame:NSMakeRect(0.0, 5.0, 130.0, 40.0)];
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
    }
    
    
    return self;
}

-(void)setProgressCornerRadius:(float)radius
{
    [_parentView.layer setCornerRadius:radius];
}

-(void)setProgressBackgroundColor:(CGColorRef)rgbColor
{
    _parentView.layer.backgroundColor = rgbColor;
}

-(void)setBottomColor:(CGColorRef)rgbColor
{
    self.layer.backgroundColor = rgbColor;
}


-(void)changeParentViewConstraint:(BOOL)hasStr
{
    float strHeight , strWidth;
    if(hasStr){
        strHeight = 150.0;
        strWidth = 130.0;
    }else{
        strHeight = 110.0;
        strWidth = 110.0;
    }
    [self addConstraints:@[
                                      [NSLayoutConstraint constraintWithItem:_parentView
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0
                                                                    constant:0.0],
                                      
                                      [NSLayoutConstraint constraintWithItem:_parentView
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
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


-(void)showProgressWithString:(NSString *)msgStr
{
    [self setHidden:NO];
    _progressIndicator.animates = YES;
    
    [_progressIndicator setFrame:NSMakeRect(20.0, 50.0, 90.0, 90.0)];
    _messageField.hidden = NO;
    _messageField.stringValue = msgStr;
    [self changeParentViewConstraint:YES];

}

-(void)showProgress
{
    [self setHidden:NO];
    _progressIndicator.animates = YES;
    
    _messageField.hidden = YES;
    [_progressIndicator setFrame:NSMakeRect(10.0, 10.0, 90.0, 90.0)];
    [self changeParentViewConstraint:NO];
}

-(void)hideProgress
{
    _progressIndicator.animates = NO;
    [_progressIndicator setHidden:YES];
    [self removeFromSuperview];
    
}


@end
