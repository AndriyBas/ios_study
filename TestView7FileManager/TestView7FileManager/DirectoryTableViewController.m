//
//  DirectoryTableViewController.m
//  TestView7FileManager
//
//  Created by Andriy Bas on 2/8/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "DirectoryTableViewController.h"

@interface DirectoryTableViewController ()

@property (strong, nonatomic) NSString* path;
@property (strong, nonatomic) NSArray* contents;

@end

@implementation DirectoryTableViewController


- (instancetype) initWithFolderPath:(NSString*) path {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self) {
        self.path = path;
        
        NSError* error = nil;
        self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error];
     
        if(error) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = [self.path lastPathComponent];
    
    if([self.navigationController.viewControllers indexOfObject:self] > 1) {
        UIBarButtonItem* homeButton = [[UIBarButtonItem alloc] initWithTitle:@"To Root" style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(actionHomeFolder:)];
        
        self.navigationItem.rightBarButtonItem = homeButton;
    }
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"path = %@", self.path);
    NSLog(@"contents count = %ld", self.contents.count);
    NSLog(@"index on stack = %ld", [self.navigationController.viewControllers indexOfObject:self]);
}

- (void) dealloc {
    NSLog(@"dealloc for path : %@", self.path);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL) isDirectoryAtIndexPath:(NSIndexPath*) indexPath {
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];
    
    BOOL isDirectory = NO;
    
    NSString* filePath = [self.path stringByAppendingPathComponent:fileName];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return fileExists && isDirectory;
}

#pragma mark - Actions

-(void) actionHomeFolder:(UIBarButtonItem*) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifier = @"FileCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];
    
    cell.textLabel.text = fileName;
   
    if([self isDirectoryAtIndexPath:indexPath]) {
        cell.imageView.image = [UIImage imageNamed:@"ic_folder.png"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"ic_file.png"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if([self isDirectoryAtIndexPath:indexPath]) {
        NSString* fileName = [self.contents objectAtIndex:indexPath.row];
        NSString* folderPath = [self.path stringByAppendingPathComponent:fileName];
        
        DirectoryTableViewController* folderViewController = [[DirectoryTableViewController alloc] initWithFolderPath:folderPath];
        
        [self.navigationController pushViewController:folderViewController animated:YES];
        
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
