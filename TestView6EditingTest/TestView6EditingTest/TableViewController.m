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
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupsArray = [NSMutableArray array];
    
    for(int i = 0; i < (5 + arc4random() % 5); i++) {
        Group* group = [[Group alloc] init];
        group.name = [self nameForGroup:i];
        NSMutableArray* students = [NSMutableArray array];
        for(int j = 0; j < (arc4random() % 6 + 5); j++) {
            [students addObject:[Student randomStudent]];
        }
        group.students = [NSArray arrayWithArray:students];
        
        [self.groupsArray addObject:group];
    }
    
    [self.tableView reloadData];
    
    self.navigationItem.title = @"Students";
    UIBarButtonItem* editBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionEditBarButton:)];
    [self.navigationItem setRightBarButtonItem:editBarButton animated:YES];
    
    UIBarButtonItem* addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAddSectionBarButton:)];
    [self.navigationItem setLeftBarButtonItem:addBarButton animated:YES];
}

#pragma mark - Private methods

-(NSString*) nameForGroup:(NSInteger) index {
    return [NSString stringWithFormat:@"Group IO-%ld", 20 + index];
}

#pragma mark - Actions
- (void) actionEditBarButton:(UIBarButtonItem*) sender {
    BOOL isEditing = !self.tableView.editing;
    [self.tableView setEditing:isEditing animated:YES];
    
    UIBarButtonSystemItem barButtonItem = UIBarButtonSystemItemEdit;
    if(isEditing) {
        barButtonItem = UIBarButtonSystemItemDone;
    }
    
    UIBarButtonItem* editBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:barButtonItem target:self action:@selector(actionEditBarButton:)];
    [self.navigationItem setRightBarButtonItem:editBarButton animated:YES];
}

- (void) actionAddSectionBarButton:(UIBarButtonItem*) sender {
    
    Group* newGroup = [[Group alloc] init];
    newGroup.name = [self nameForGroup:self.groupsArray.count];
    
    newGroup.students = @[[Student randomStudent], [Student randomStudent]];
    [self.groupsArray insertObject:newGroup atIndex:0];
    
    [self.tableView beginUpdates];
    
//    [self.tableView reloadData];
    
    NSIndexSet* set = [NSIndexSet indexSetWithIndex:0];
    
    [self.tableView insertSections:set withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.tableView endUpdates];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
    
    
//    NSIndexPath* indexPath = [[NSIndexPath alloc] initWithIndexes:self.groupsArray.count - 1 length:1];

//    [self.tableView scrollToRowAtIndexPath:nil atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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
//        return UITableViewCellEditingStyleNone;
//    }
    
    if(0 == indexPath.row) {
        return UITableViewCellEditingStyleNone;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row > 0;
}

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if(proposedDestinationIndexPath.row == 0) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:1 inSection:proposedDestinationIndexPath.section];
        return indexPath;
    }
    return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
    if(0 == indexPath.row) {
        Group* group = [self.groupsArray objectAtIndex:indexPath.section];
        NSMutableArray* arr = nil;
        if(group.students) {
            arr = [NSMutableArray arrayWithArray:group.students];
        } else {
            arr = [NSMutableArray array];
        }
        [arr insertObject:[Student randomStudent] atIndex:0];
        group.students = [NSArray  arrayWithArray:arr];
        
        [self.tableView beginUpdates];
        
        NSIndexPath* path = [NSIndexPath indexPathForItem:1 inSection:indexPath.section];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.tableView endUpdates];
        
//        [self.tableView reloadData];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
        });
        
        NSLog(@"didSelect");
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Exclude";
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
    return group.students.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString* studentIdentifier = @"Student.Cell";
    static NSString* addIdentifier = @"Add.Cell";
    
    if(0 == indexPath.row) {
        UITableViewCell* addCell = [tableView dequeueReusableCellWithIdentifier:addIdentifier];
        if(!addCell) {
            addCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addIdentifier];
        }
        addCell.textLabel.textColor = [UIColor cyanColor];
        addCell.textLabel.text = @"Add Student";
        return addCell;
    }
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:studentIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentIdentifier];
    }
    
    Group* group = [self.groupsArray objectAtIndex:indexPath.section];
    Student* student = [group.students objectAtIndex:indexPath.row - 1];
    
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
    return indexPath.row > 0;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
//    if(destinationIndexPath.row == 0) {
//        [self.tableView reloadData];
//        return;
//    }
    
    NSInteger destinationIndexRow = destinationIndexPath.row - 1;
    
    Group* sourceGroup = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    Student* sourceStudent = [sourceGroup.students objectAtIndex:sourceIndexPath.row - 1];
    
    NSMutableArray* tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
    
    if(sourceIndexPath.section == destinationIndexPath.section) {
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row - 1 withObjectAtIndex:destinationIndexRow];
        sourceGroup.students = [NSArray arrayWithArray:tempArray];
    } else {
        [tempArray removeObject:sourceStudent];
        sourceGroup.students = [NSArray arrayWithArray:tempArray];
    
        Group* destinationGroup = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        
        NSMutableArray* destinationTempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        [destinationTempArray insertObject:sourceStudent atIndex:destinationIndexRow];
        destinationGroup.students = [NSArray arrayWithArray:destinationTempArray];
    }
    
//    if(destinationIndexPath.row != destinationIndexRow) {
//        [self.tableView reloadData];
//    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(UITableViewCellEditingStyleDelete == editingStyle) {
        Group* group = [self.groupsArray objectAtIndex:indexPath.section];
        NSMutableArray* arr = [NSMutableArray arrayWithArray:group.students];
        [arr removeObjectAtIndex:indexPath.row - 1];
        group.students = [NSArray arrayWithArray:arr];
        
        [self.tableView beginUpdates];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        [self.tableView endUpdates];
        
    }
}



@end
