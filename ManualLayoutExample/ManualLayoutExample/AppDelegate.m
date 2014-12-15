//
//  AppDelegate.m
//  ManualLayoutExample
//
//  Created by Sam Morrison on 12/15/14.
//  Copyright (c) 2014 Patreon. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = [[ViewController alloc] init];
  [self.window makeKeyAndVisible];

  return YES;
}

@end
