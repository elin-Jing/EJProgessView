//
//  AppDelegate.m
//  EJProgressDemo
//
//  Created by Evelyn on 2016/12/15.
//  Copyright © 2016年 Evelyn. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoWindowController.h"

@interface AppDelegate ()
{
    DemoWindowController * demoWindow;
}
//@property (weak) IBOutlet NSWindow *window;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    demoWindow = [[DemoWindowController alloc] initWithWindowNibName:@"DemoWindowController"];
    [demoWindow showWindow:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
