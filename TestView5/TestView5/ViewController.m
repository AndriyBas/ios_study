//
//  ViewController.m
//  TestView5
//
//  Created by Andriy Bas on 1/28/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    familyNames = [UIFont familyNames];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 20);
    
    self.tableView.contentInset = inset;
    self.tableView.scrollIndicatorInsets = inset;
    
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

NSArray* familyNames;


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"numberOfRowsInSection");
    
    NSString* familyName = [familyNames objectAtIndex:section];
    
    NSArray* fontNames = [UIFont fontNamesForFamilyName:familyName];
    
    return fontNames.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [familyNames objectAtIndex:section];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"cell";
    
    NSLog(@"cellForRowAtIndexPath {%ld, %ld}", indexPath.section, indexPath.row);
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell) {
    
        NSLog(@"new cell created : %ld, %ld", indexPath.section, indexPath.row);
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSString* familyName = [familyNames objectAtIndex:indexPath.section];
    NSArray* fontNames = [UIFont fontNamesForFamilyName:familyName];
    NSString* fontName = [fontNames objectAtIndex:indexPath.row];
    
    cell.textLabel.text = fontName;
    
    UIFont* font = [UIFont fontWithName:fontName size:16.0F];
    
    cell.textLabel.font = font;
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSLog(@"numberOfSectionsInTableView");
    
    return familyNames.count;
}

@end
