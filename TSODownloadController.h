//
//  TSODownloadController.h
//  HackerBooks
//
//  Created by Timple Soft on 1/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSODownloadController : NSObject

-(void) downloadAndSaveJSONWithURL:(NSURL *) url;
-(NSArray *) booksDictionaryArray;

@end