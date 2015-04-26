//
//  TSOHackerBooksBaseClass.m
//  HackerBooks
//
//  Created by Timple Soft on 26/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOHackerBooksBaseClass.h"

@implementation TSOHackerBooksBaseClass




#pragma mark - Class Methods
+(NSArray *) observableKeys{
    return @[];
}



#pragma mark - Life cycle
-(void) awakeFromInsert{
    [super awakeFromInsert];
    
    // Solo se produce una vez en la vida del objeto
    [self setupKVO];
}

-(void) awakeFromFetch{
    [super awakeFromFetch];
    
    // Se produce n veces  a lo largo de la vida del objeto
    [self setupKVO];
}

-(void) willTurnIntoFault{
    [super willTurnIntoFault];
    
    // Se produce cuadno el objeto se vacía convirtiendose en faukt
    // Baja en notificaciones
    [self tearDownKVO];
    
}


#pragma mark - KVO
-(void) setupKVO{
    
    for (NSString *key in [[self class] observableKeys]){
        
        // Observamos todas las propiedades EXCEPTO modificationDate (peligro bucle infinito)
        [self addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                  context:NULL];
        
    }
    
    
}


-(void) tearDownKVO{
    
    for (NSString *key in [[self class] observableKeys]){
        
        // Me doy de baja en todas las notificaciones
        [self removeObserver:self
                  forKeyPath:key];
        
    }
    
}

@end
