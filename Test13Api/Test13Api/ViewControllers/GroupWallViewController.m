//
//  GroupWallViewControllerTableViewController.m
//  Test13Api
//
//  Created by Andriy Bas on 4/25/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "GroupWallViewController.h"
#import "VKPost.h"
#import "ServerManager.h"
#import "VKPostCell.h"


@interface GroupWallViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray* wallPosts;
@property (strong, nonatomic) ServerManager* serverManager;

@end

@implementation GroupWallViewController

static NSString* postCellIdentifier = @"postCell";

const NSInteger PAGE_COUNT = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Wall";
    self.wallPosts = [NSMutableArray array];
    self.serverManager = [ServerManager sharedManager];
    self.tableView.delegate = self;
    
    
    UIBarButtonItem* barButtonItemPost = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addWallPost:)];
    self.navigationItem.rightBarButtonItem = barButtonItemPost;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshWall) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    [self.tableView registerClass:[VKPostCell class] forCellReuseIdentifier:postCellIdentifier];
    
    [self loadPosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wallPosts.count + 1;
}

- (void) loadPosts {

    [self.serverManager getGroupWall:@"-58860049" withOffset:self.wallPosts.count count:PAGE_COUNT onSuccess:^(NSArray *posts) {
        
        NSMutableArray* indexPathes = [NSMutableArray array];
        for(int i = (int)self.wallPosts.count; i < (int)(self.wallPosts.count + posts.count); i++) {
            [indexPathes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [self.wallPosts addObjectsFromArray:posts];
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPathes withRowAnimation:YES];
        [self.tableView endUpdates];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self showErrorMessage:[error localizedDescription]];
        
    }];
}

- (void) showErrorMessage:(NSString*) errorMsg {
    [[[UIAlertView alloc]
      initWithTitle:@"Ooops"
      message:errorMsg
      delegate:nil
      cancelButtonTitle:@"OK"
      otherButtonTitles: nil]
     show];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == self.wallPosts.count) {
        static NSString* identifier = @"wallCell";
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
         cell.textLabel.text = @"Load More";
        cell.imageView.image = nil;
        return cell;
    } else {
        
        VKPostCell* postCell = [self.tableView dequeueReusableCellWithIdentifier:postCellIdentifier];
        if(!postCell) {
            postCell = [[VKPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postCellIdentifier];
        }
        
        VKPost* post = [self.wallPosts objectAtIndex:indexPath.row];
        postCell.postTextLabel.text = post.text;
//        [postCell layoutSubviews];
//        [postCell layoutIfNeeded];
        
        return postCell;
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

#pragma mark - Actions

- (void) addWallPost:(UIBarButtonItem*) sender {
    
    [[ServerManager sharedManager] postText:@"Test Text" onGroupWall:@"-58860049" onSuccess:^(id response) {
        NSLog(@"Success");
    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self showErrorMessage:[error localizedDescription]];
    }];
}


#pragma mark UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == self.wallPosts.count) {
        return 44.0F;
    } else {
        VKPost* post = [self.wallPosts objectAtIndex:indexPath.row];
        return [VKPostCell heightForText:post.text];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == self.wallPosts.count) {
        [self loadPosts];
    }
}

#pragma mark - Private Methods

- (void) refreshWall {
    [self.serverManager getGroupWall:@"-58860049" withOffset:0 count:self.wallPosts.count onSuccess:^(NSArray *posts) {
        
        [self.wallPosts removeAllObjects];
        [self.wallPosts addObjectsFromArray:posts];
        [self.tableView reloadData];
        
        [self.refreshControl endRefreshing];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self showErrorMessage:[error localizedDescription]];
        
    }];
}


@end
