//
//  TableViewController.m
//  TestView6EditingTest
//
//  Created by Andriy Bas on 2/7/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "TableViewController.h"
#import "Group.h"
#import "Student.h"

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* groupsArray;

@end

@implementation TableViewController


- (void) loadView {
    [super loadView];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    tableView.delegate = self;
    tableView.dataSource = self;

    tableView.editing = YES;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupsArray = [NSMutableArray array];
    
    for(int i = 0; i < (5 + arc4random() % 5); i++) {
        Group* group = [[Group alloc] init];
        group.name = [NSString stringWithFormat:@"Group IO-2%d", i + 1];
        
        NSMutableArray* students = [NSMutableArray array];
        for(int j = 0; j < (arc4random() % 11 + 15); j++) {
            [students addObject:[Student randomStudent]];
        }
        group.students = [NSArray arrayWithArray:students];
        
        [self.groupsArray addObject:group];
    }
    
    [self.tableView reloadData];
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

#pragma mark - UITableViewDelegate 

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    Group* group = [self.groupsArray objectAtIndex:indexPath.section];
//    Student* student = [group.students objectAtIndex:indexPath.row];
    
//    if(student.averageGrade >= 4.0) {
//        return UITableViewCellEditingStyleInsert;
//    } else if(student.averageGrade >= 3.0) {
//        return UITableViewCellEditingStyleNone;
//    } else {
        return UITableViewCellEditingStyleDelete;
//    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { // Default is 1 if not implemented
    return self.groupsArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {    // fixed font style. use custom view (UILabel) if you want something different
    Group* group = [self.groupsArray objectAtIndex:section];
    return group.name;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    Group* group = [self.groupsArray objectAtIndex:section];
    return [NSString stringWithFormat:@"Total : %ld", group.students.count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Group* group = [self.groupsArray objectAtIndex:section];
    return group.students.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString* identifier = @"TableViewController.Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    Group* group = [self.groupsArray objectAtIndex:indexPath.section];
    Student* student = [group.students objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", student.averageGrade];
    
    if(student.averageGrade >= 4.0) {
        cell.detailTextLabel.textColor = [UIColor greenColor];
    } else if(student.averageGrade >= 3.0) {
        cell.detailTextLabel.textColor = [UIColor orangeColor];
    } else {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    Group* sourceGroup = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    Student* sourceStudent = [sourceGroup.students objectAtIndex:sourceIndexPath.row];
    
    NSMutableArray* tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
    
    if(sourceIndexPath.section == destinationIndexPath.section) {
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
        sourceGroup.students = [NSArray arrayWithArray:tempArray];
    } else {
        [tempArray removeObject:sourceStudent];
        sourceGroup.students = [NSArray arrayWithArray:tempArray];
    
        Group* destinationGroup = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        
        NSMutableArray* destinationTempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        [destinationTempArray insertObject:sourceStudent atIndex:destinationIndexPath.row];
        destinationGroup.students = [NSArray arrayWithArray:destinationTempArray];
    }
    
}



@end
