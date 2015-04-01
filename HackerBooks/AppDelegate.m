//
//  AppDelegate.m
//  HackerBooks
//
//  Created by Timple Soft on 31/3/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "TSOLibrary.h"
#import "TSOBook.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    // pruebas
    TSOLibrary *library = [[TSOLibrary alloc] init];

//    NSLog(@"%d", [library bookCountForTag:@"python"]);
//    NSLog(@"%d", [library bookCountForTag:@"pythona"]);
//    
//    NSArray *books = [library booksForTag:@"python"];
//    NSArray *books2 = [library booksForTag:@"aaa"];
//    
//    for (id book in books){
//        NSLog(@"%@", book);
//    }
//    
//    for (id book in books2){
//        NSLog(@"%@", book);
//    }
//
//    TSOBook *book = [library bookForTag:@"algo2" atIndex:0];
//    TSOBook *book2 = [library bookForTag:@"python" atIndex:0];
//    TSOBook *book3 = [library bookForTag:@"python" atIndex:1];
//    TSOBook *book4 = [library bookForTag:@"python" atIndex:2];
//    
//    NSLog(@"%@ %@ %@ %@", book, book2, book3, book4);
    
    NSArray *tags = [library tags];
    for (id tag in tags){
        NSLog(@"%@  ", tag);
    }
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
