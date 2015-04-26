//
//  TSOAnnotationViewController.h
//  HackerBooks
//
//  Created by Timple Soft on 21/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

@class TSOAnnotation;
#import <UIKit/UIKit.h>

@interface TSOAnnotationViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

-(id) initWithModel:(TSOAnnotation *) model;

@property (weak, nonatomic) IBOutlet UITextField *textView;
@property (weak, nonatomic) IBOutlet UILabel *creationDateView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

- (IBAction)takePhoto:(id)sender;
- (IBAction)deletePhoto:(id)sender;

@property (strong, nonatomic) TSOAnnotation *model;

@end
