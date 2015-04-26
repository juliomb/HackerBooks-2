//
//  TSOAnnotationViewController.m
//  HackerBooks
//
//  Created by Timple Soft on 21/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOAnnotationViewController.h"
#import "TSOAnnotation.h"
#import "TSOPhoto.h"
#import "TSOLocalization.h"

@interface TSOAnnotationViewController ()

@end

@implementation TSOAnnotationViewController


#pragma mark - Init
-(id) initWithModel:(TSOAnnotation *) model{
    
    if (self = [super init]) {
        _model = model;
    }
    return self;
    
}


-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // Sincronizar modelo y vista
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterShortStyle;
    self.creationDateView.text = [fmt stringFromDate:self.model.creationDate];
    self.modificationDateView.text = [fmt stringFromDate:self.model.modificationDate];
    self.textView.text = self.model.text;
    if (self.model.photo.photoData) {
        self.imageView.image = [UIImage imageWithData:self.model.photo.photoData];
    }
    
    if (self.model.hasLocation){
        self.locationLabel.text = [self.locationLabel.text stringByAppendingString:
                                   [NSString stringWithFormat:@"%@ %@", self.model.localization.latitude,
                                    self.model.localization.longitude]];
    }
    
    // Asignamos delegados
    self.textView.delegate = self;
}


-(void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];

    // Sincronizo vistas -> modelo
    self.model.text = self.textView.text;
    
    // guardamos
    NSError *error;
    [self.model.managedObjectContext save:&error];
    if (error) {
        NSLog(@"Error al guardar anotación: %@", error.userInfo);
    }
    
}


- (IBAction)takePhoto:(id)sender {
    
    // Creamos un UIImagePickerController
    UIImagePickerController *picker = [UIImagePickerController new];
    
    // Lo configuramos
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // usamos la cámara
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        // tiro del carrete
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // Lo mostramos de forma modal
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         // Esto se va a ejecutar cuando termine la animación que muestra al picker
                     }];
}

- (IBAction)deletePhoto:(id)sender {
    
    // la eliminamos del modelo
    self.model.photo.photoData = nil;
    CGRect oldRect = self.imageView.bounds;
    
    // actualizamos la vista
    [UIView animateWithDuration:0.7
                     animations:^{
                         self.imageView.alpha = 0;
                         self.imageView.bounds = CGRectZero;
                         self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
                         
                     } completion:^(BOOL finished) {
                         // tenemos que volver a darle valores correctos a la view
                         self.imageView.alpha = 1;
                         self.imageView.bounds = oldRect;
                         self.imageView.transform = CGAffineTransformIdentity;
                         
                         self.imageView.image = nil;
                     }];
    
}



#pragma mark - UITextFieldDelegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    // OJO! pico de memoria asegurado, especialmente en dispositivos antiguos
    // Sacamos la foto del diccionario
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // La guardamos en el modelo
    self.model.photo.photoData = UIImageJPEGRepresentation(img, 0.9);
    
    // Quito de encima al controlador que estamos presentando
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 // Esto se ejecuta cuando se oculta del todo
                             }];
    
}


@end
