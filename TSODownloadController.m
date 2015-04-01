//
//  TSODownloadController.m
//  HackerBooks
//
//  Created by Timple Soft on 1/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSODownloadController.h"
#import "Settings.h"

@implementation TSODownloadController

-(void) downloadAndSaveJSONWithURL:(NSURL *) url{
    // En este método descargaremos el JSON de la url pasada por parámetro y lo guardaremos
    // en la carpeta Documents de la SandBox
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if (data != nil) {
        
        // Datos descargados correctamente, los guardamos en la SandBox
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL *url = [urls lastObject];
        url = [url URLByAppendingPathComponent:NSDATA_LIBRARY];
        NSError *error =nil;
        BOOL aux = [data writeToURL:url
                            options:NSDataWritingAtomic
                              error:&error];
        
        // comprobamos la escritura
        if (aux){
            NSLog(@"Datos almacenados correctamente");
        }else{
            NSLog(@"Error al escribir los datos: %@", error.userInfo);
        }

    }else{
        NSLog(@"Error descargando los datos");
    }
    
}


-(NSArray *) booksDictionaryArray{
    
    // Leemos el NSData
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    url = [url URLByAppendingPathComponent:NSDATA_LIBRARY];
    NSError *error =nil;
    NSData *data = [NSData dataWithContentsOfURL:url
                                         options:NSDataReadingMappedIfSafe
                                           error:&error];
    
    // devolvemos un array de diccionarios
    NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    if (dictArray == nil){
        NSLog(@"Error al parsear el JSON: %@", error.userInfo);
    }
    
    return dictArray;
    
}

@end
