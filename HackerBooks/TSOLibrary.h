//
//  TSOLibrary.h
//  HackerBooks
//
//  Created by Timple Soft on 31/3/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

@import Foundation;
@class TSOBook;


@interface TSOLibrary : NSObject

-(id) initWithArray:(NSArray *) dictArray;


-(NSUInteger) booksCount;


-(NSArray *) tags;
-(NSUInteger) bookCountForTag:(NSString *) tag;
-(NSArray *) booksForTag:(NSString *) tag;
-(TSOBook *) bookForTag:(NSString *) tag
                atIndex:(NSUInteger) index;

@end
