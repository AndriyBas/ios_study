//
//  StudentsViewController.m
//  Test12CoreData
//
//  Created by Andriy Bas on 4/18/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "StudentsViewController.h"
#import "ASStudent.h"
#import "ASCourse.h"
#import "ASCar.h"
#import "ASUniversity.h"

@interface StudentsViewController ()

@end

@implementation StudentsViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.course.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - NSFetchedResultsControllerDelegate
- (NSFetchedResultsController *)fetchedResultsController {
    
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"ASStudent" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    [fetchRequest setFetchBatchSize:30];
    
    NSSortDescriptor* sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor* sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor1, sortDescriptor2]];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%@ IN courses",  self.course];
    [fetchRequest setPredicate:predicate];
    
    NSFetchedResultsController* fetchedResultsController =
        [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                            managedObjectContext:self.managedObjectContext
                                              sectionNameKeyPath:@"university.name"
                                                       cacheName:nil];

    
    fetchedResultsController.delegate = self;
    self.fetchedResultsController = fetchedResultsController;
    
    NSError* error = nil;
    if(![fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error : %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}


#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ASStudent* student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%lu : %@ %@ (%.1f)", indexPath.row + 1, student.firstName, student.lastName, [[student score] floatValue]];
    NSString* carModel = nil;
    if(nil != student.car) {
        carModel = [[student car] model];
    }
    cell.detailTextLabel.text = carModel;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo name];
}

#pragma marg  - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ASStudent* student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSLog(@"%@ %@", student.firstName, student.lastName);
}


@end
