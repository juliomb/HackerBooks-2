//
//  TSOLibraryTableViewController.m
//  HackerBooks
//
//  Created by Timple Soft on 3/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOLibraryTableViewController.h"
#import "TSOLibrary.h"
#import "TSOBook.h"

@interface TSOLibraryTableViewController ()

@end

@implementation TSOLibraryTableViewController


-(id) initWithModel:(TSOLibrary *) model
              style:(UITableViewStyle) style{
    
    if (self = [super initWithStyle:style]){
        _model = model;
        self.title = @"Librería";
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.model tags].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    NSString *tag = [[self.model tags] objectAtIndex:section];
    return [self.model bookCountForTag:tag];
    
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[self.model tags] objectAtIndex:section];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Rescatamos el libro del modelo
    NSString *tag = [[self.model tags] objectAtIndex:indexPath.section];
    TSOBook *book = [self.model bookForTag:tag atIndex:indexPath.row];
    
    // Cramos la celda
    static NSString *cellId = @"BookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellId];
    }
    
    // Configuramos la celda
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = [book.authors componentsJoinedByString:@", "];
    cell.imageView.image = [UIImage imageWithData:[book imageData]];
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Rescatamos el libro del model
    NSString *tag = [[self.model tags] objectAtIndex:indexPath.section];
    TSOBook *book = [self.model bookForTag:tag atIndex:indexPath.row];
    
    // Si nuestro delegado entiende el mensaje se lo enviamos
    if ([self.delegate respondsToSelector:@selector(libraryTableViewController:didSelectBook:)]) {
        [self.delegate libraryTableViewController:self
                                    didSelectBook:book];
    }
    
    
}

@end
