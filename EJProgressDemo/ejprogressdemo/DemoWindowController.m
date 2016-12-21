//
//  DemoWindowController.m
//  EJProgressDemo
//
//  Created by Evelyn on 2016/12/15.
//  Copyright © 2016年 Evelyn. All rights reserved.
//

#import "DemoWindowController.h"
#import "EJProgressView.h"

@interface DemoWindowController ()

@property (nonatomic , strong) EJProgressView *progressView;
@property (nonatomic) NSTimer *showTime;
@property (strong) IBOutlet NSTextField *enterField;


@end

@implementation DemoWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    self.window.backgroundColor = [NSColor whiteColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.enterField.window makeFirstResponder:nil];
    });
    
}

- (IBAction)showProgressView:(NSButton *)sender
{
    _progressView = [[EJProgressView alloc] initOnView:self.window.contentView];
    [_progressView showProgressWithString:@"Download..."];
    
    _showTime = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(stopProgress:) userInfo:nil repeats:NO];
    
}

- (IBAction)showWithNoString:(NSButton *)sender
{
    _progressView = [[EJProgressView alloc] initOnView:self.window.contentView];
    [_progressView showProgress];
    
    _showTime = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(stopProgress:) userInfo:nil repeats:NO];
}


-(void)stopProgress:(id)sender
{
    [_progressView hideProgress];
}

- (IBAction)pressTestBtn:(NSButton *)sender {
    NSLog(@"Press Test Button !");
}

@end
