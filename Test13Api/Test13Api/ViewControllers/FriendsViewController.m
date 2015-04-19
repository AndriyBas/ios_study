//
//  FriendsViewController.m
//  Test13Api
//
//  Created by Andriy Bas on 4/19/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "FriendsViewController.h"
#import "ServerManager.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"


@interface FriendsViewController () <UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray* friendsArray;

@end

@implementation FriendsViewController

static const NSInteger DEFAULT_PAGE_SIZE = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"My Friends";
    self.friendsArray = [NSMutableArray array];
//    [self loadFriends];
    
    [self loginUser];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) loginUser {
    [[ServerManager sharedManager] authorizeUser:^(User *user) {
        NSLog(@"%@", user);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void) showLoader {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void) hideLoader {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - API

-(void) loadFriends {
    
    [self showLoader];
    
        [[ServerManager sharedManager]
         getFriendsWithOffset:[self.friendsArray count]
                        count:DEFAULT_PAGE_SIZE
                    onSuccess:^(NSArray *friendsArray) {
    
                        [self.friendsArray addObjectsFromArray:friendsArray];
                        NSMutableArray* newPaths = [NSMutableArray array];
                        for(int i = (int)self.friendsArray.count - (int)friendsArray.count; i < (int) self.friendsArray.count; i++) {
                            [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                        }
    
                        [self.tableView beginUpdates];
                        [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
                        [self.tableView endUpdates];
    
                        [self hideLoader];
                    }
                    onFailure:^(NSError *error, NSInteger statusCode) {
    
                        [self hideLoader];
    
                        [[[UIAlertView alloc] initWithTitle:@"Oops"
                                                    message:[NSString stringWithFormat:@"Error loading friends, statusCode : %ld", statusCode]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil] show];
                    }];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendsArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"FriendCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    if(indexPath.row == [self.friendsArray count]) {
        cell.textLabel.text = @"Load more";
        cell.imageView.image = nil;
        cell.detailTextLabel.text = nil;
    } else {
        User* user = [self.friendsArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        cell.detailTextLabel.text = user.domain;
        
        __weak UITableViewCell* weakCell = cell;
        
        NSURLRequest* request = [NSURLRequest requestWithURL:user.imageURL];
        [cell.imageView  setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            weakCell.imageView.image = image;
            [weakCell layoutSubviews];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == [self.friendsArray count]) {
        [self loginUser];
//        [self loadFriends];
    }
}

@end
