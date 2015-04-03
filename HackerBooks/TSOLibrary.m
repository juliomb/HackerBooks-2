//
//  TSOLibrary.m
//  HackerBooks
//
//  Created by Timple Soft on 31/3/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOLibrary.h"
#import "TSOBook.h"

@interface TSOLibrary()

@property (nonatomic, strong) NSArray *booksArray;
//@property (nonatomic, strong) NSArray *tagsArray;

@end


@implementation TSOLibrary

# pragma mark - Properties

-(NSUInteger) booksCount{
    return [self.booksArray count];
}


# pragma mark - Inits
-(id) initWithArray:(NSArray *) dictArray{
    if (self = [super init]){
        _booksArray = [self booksFromDictionaryArray:dictArray];
    }
    return self;
}



#pragma mark - Utils


-(NSArray *) tags{
    
    // Creamos un array mutable para ir metiendo los tags
    NSMutableArray *tags = [[NSMutableArray alloc] init];
    
    for (TSOBook *book in self.booksArray){
        for (NSString *tag in book.tags){
            
            // añadimos si no está
            if (![tags containsObject:tag]) {
                [tags addObject:tag];
            }
            
        }
    }
    
    // Ordenamos alfabéticamente
    NSArray *sortedArray = [tags sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return sortedArray;
}


-(NSUInteger) bookCountForTag:(NSString *) tag{
    
    // Creamos un contador
    NSUInteger counter = 0;
    
    // si el libro contiene el tag sumamos 1
    for (TSOBook *book in self.booksArray){
        if ([book.tags containsObject:tag]) {
            counter += 1;
        }
    }
    
    return counter;
}


-(NSArray *) booksForTag:(NSString *) tag{
    
    // Creamos un array mutable para ir añadiendo los libros
    NSMutableArray *books = [[NSMutableArray alloc] init];
    
    // si el libro contiene el tag lo añadimos
    for (TSOBook *book in self.booksArray){
        if ([book.tags containsObject:tag]) {
            [books addObject:book];
        }
    }
    
    // si no hay ninguno devolvemos nil
    if ([books count] > 0){
        
        // Deben estar ordenados ya
        return books;
        
    }else{
        return nil;
    }
}


-(TSOBook *) bookForTag:(NSString *) tag
                atIndex:(NSUInteger) index{
    
    // Extraemos los libros usando el método anterior
    NSArray *books = [self booksForTag:tag];
    
    // si no existe el tag o el índice es mayor que el número de libros devolvemos nil
    if (books == nil || [books count] <= index){
        return nil;
    }else{
        // devolvemos el libro
        return [books objectAtIndex:index];
    }
    
}

-(NSArray *) booksFromDictionaryArray:(NSArray *) dictArray{
    
    // Recorremos el array y vamos añadiendo los libros
    NSMutableArray *books = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in dictArray) {
        TSOBook *book = [[TSOBook alloc] initWithDictionary:dict];
        [books addObject:book];
    }
    
    // devolvemos, ya deben estar ordenados
    return books;
    
}



@end
