//
//  TSODownloadController.m
//  HackerBooks
//
//  Created by Timple Soft on 1/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSODownloadController.h"

@implementation TSODownloadController

-(void) downloadAndSaveJSONWithURL:(NSURL *) url{
    // En este método descargaremos el JSON de la url pasada por parámetro y lo guardaremos
    // en la carpeta Documents de la SandBox
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if (data != nil) {
        NSLog(@"Datos descargados correctamente");
    }else{
        NSLog(@"Error descargando los datos");
    }
    
}

@end
