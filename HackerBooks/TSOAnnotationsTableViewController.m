//
//  TSOAnnotationsTableViewController.m
//  HackerBooks
//
//  Created by Timple Soft on 21/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOAnnotationsTableViewController.h"
#import "TSOBook.h"
#import "TSOAnnotation.h"
#import "TSOPhoto.h"
#import "TSOAnnotationViewController.h"

@interface TSOAnnotationsTableViewController ()

@property (nonatomic, strong) TSOBook *book;

@end

@implementation TSOAnnotationsTableViewController


-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                                 style:(UITableViewStyle)aStyle
                                  book:(TSOBook *)aBook{
    
    if (self = [super initWithFetchedResultsController:aFetchedResultsController style:aStyle]) {
        _book = aBook;
        self.title = self.book.title;
    }
    
    return self;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addNewAnnotation:)];
    
    self.navigationItem.rightBarButtonItem = add;
}


-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // guardamos
    NSError *error;
    [self.fetchedResultsController.managedObjectContext save:&error];
    if (error) {
        NSLog(@"Error al guardar anotaciones: %@", error.userInfo);
    }
}



-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguar la nota
    TSOAnnotation *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Creamos la celda
    static NSString *cellId = @"annotationCellId";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // Sincronizamos nota y celda
    if (n.photo.photoData) {
        cell.imageView.image = [UIImage imageWithData:n.photo.photoData];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"nophoto.jpg"];
    }
    cell.textLabel.text = n.text;
    
    return cell;
}


-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        TSOAnnotation *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.fetchedResultsController.managedObjectContext deleteObject:n];
        
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguamos la nota
    TSOAnnotation *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Creamos el controlador
    TSOAnnotationViewController *annotationVC = [[TSOAnnotationViewController alloc] initWithModel:n];
    
    // Hacemos push
    [self.navigationController pushViewController:annotationVC animated:YES];
    
}


#pragma mark - Actions
-(void) addNewAnnotation:(id) sender{
    [TSOAnnotation annotationWith:@"Nueva anotación"
                             book:self.book
                          context:self.fetchedResultsController.managedObjectContext];
}


@end
