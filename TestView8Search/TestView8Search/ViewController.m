//
//  ViewController.m
//  TestView8Search
//
//  Created by Andriy Bas on 2/14/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Random.h"
#import "NameSection.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray* namesArray;
@property (strong, nonatomic) NSMutableArray* sectionsArray;

@property (assign, nonatomic) NSInteger namesCount;

@property (strong, nonatomic) NSOperationQueue* operationQueue;
@property (strong, nonatomic) NSOperation* currentOperation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.namesCount = 320000;
    NSMutableArray* names = [NSMutableArray arrayWithCapacity:self.namesCount];
    for (int i = 0; i < self.namesCount; i++) {
        [names addObject:[[NSString randomString] capitalizedString]];
    }
    
    [names sortUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        return [obj1 compare:obj2];
    }];
     
    self.namesArray = names;
//    self.operationQueue = [[NSOperationQueue alloc] init];
    [self generateSectionsAsync:self.namesArray withFilter:@""];
    
    self.nameSearchBar.delegate = self;
    
    
}

- (NSMutableArray*) generateSectionsFromArray:(NSArray*) array withFilter:(NSString*) filterString {
    
    NSMutableArray * sectionsArray = [NSMutableArray array];
    NSString* currentLetter = nil;
    
    for(NSString* s in array) {
        
        if( filterString != nil
           && filterString.length > 0
           && NSNotFound == [s rangeOfString:filterString options:NSCaseInsensitiveSearch].location) {
            continue;
        }
        
        NSString* firstLetter = [s substringToIndex:1];
        
        NameSection* section = nil;
        if([firstLetter isEqualToString:currentLetter]) {
            section = [sectionsArray lastObject];
        } else {
            section = [[NameSection alloc] init];
            section.sectionName = firstLetter;
            section.itemsArray = [NSMutableArray array];
            [sectionsArray addObject:section];
        }
        
        [section.itemsArray addObject:s];
        
        currentLetter = firstLetter;
    }
    
    return sectionsArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) generateSectionsAsync:(NSArray*) array withFilter:(NSString*) filterString {
    
//    if(self.currentOperation) {
//       [self.currentOperation cancel];
//        NSLog(@"canceled");
//    }
    
    if(self.currentOperation)
       [self.currentOperation cancel];
    
    if(self.operationQueue)
        [self.operationQueue cancelAllOperations];
    
    __weak ViewController* weakSelf = self;
    
    NSOperationQueue* q = [[NSOperationQueue alloc] init];
    
    NSOperation* operation = [NSBlockOperation blockOperationWithBlock:^{
        NSMutableArray* sectionArray =  [weakSelf generateSectionsFromArray:array withFilter:filterString];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
           
            if(weakSelf && ![operation isCancelled]) {
                NSLog(@"finished for filter : %@", filterString);
                weakSelf.sectionsArray = sectionArray;
                [weakSelf.tableView reloadData];
            }
        }];
    }];
    
    self.currentOperation = operation;
    
    [q addOperation:operation];
    self.operationQueue = q;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {              // Default is 1 if not implemented
    return self.sectionsArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {    // fixed font style. use custom view (UILabel) if you want something different
    NameSection* nameSection = [self.sectionsArray objectAtIndex:section];
    return nameSection.sectionName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NameSection* nameSection = [self.sectionsArray objectAtIndex:section];
    return nameSection.itemsArray.count;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSMutableArray* names = [NSMutableArray arrayWithCapacity:self.sectionsArray.count];
    
    for(NameSection* sec in self.sectionsArray) {
      
        NSString* currentName = sec.sectionName;// stringByAppendingString:@"__"];
        [names addObject:currentName];
    }
    
    return names;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* nameIdentifier = @"name";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:nameIdentifier];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: nameIdentifier];
    }
    
    NameSection* nameSection = [self.sectionsArray objectAtIndex:indexPath.section];
    NSString* name = [nameSection.itemsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = name;
    
    return cell;
}

#pragma mark - UISearchBarDelegate


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.nameSearchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.nameSearchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    NSLog(@"textDidChange");
    
    [self generateSectionsAsync:self.namesArray withFilter:self.nameSearchBar.text];
    
}


@end
