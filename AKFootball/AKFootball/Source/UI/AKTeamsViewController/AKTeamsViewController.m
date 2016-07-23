//
//  AKTeamsViewController.m
//  AKFootball
//
//  Created by Admin on 01.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKTeamsViewController.h"
#import "AKTeamsViewCell.h"
#import "AKTeamsView.h"
#import "AKLeague.h"
#import "AKTeamContext.h"
#import "AKDispatch.h"
#import "AKMatchesViewController.h"
#import "AKFootballConstants.h"

#import "AKTabBarViewController.h"

@interface AKTeamsViewController ()
@property (nonatomic, readonly) AKTeamsView             *rootView;
@property (nonatomic, strong)   NSArray                 *teamsArray;
@property (nonatomic, strong)   AKTabBarViewController  *tabBarController;

@end

@implementation AKTeamsViewController

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AKTabBarViewController *tabBarController = [AKTabBarViewController new];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    
    CGRect rect = CGRectMake(0, screenSize.height - 50, screenSize.width, 50);
    tabBarController.view.frame = rect;

    [self addChildViewController:tabBarController];
    [self.rootView.tabBarView addSubview:tabBarController.view];
    [tabBarController didMoveToParentViewController:self];
    
    if (self.context.state == kAKModelLoadingState) {
        [self.rootView showLoadingViewWithDefaultMessageAnimated:YES];
    }
}

//- (void)presentDetailController:(AKTabBarViewController *)detailVC{
//    
//    //0. Remove the current Detail View Controller showed
//    if (self.self.tabBarController){
//        [self removeCurrentDetailViewController];
//    }
//    
//    //1. Add the detail controller as child of the container
//    [self addChildViewController:detailVC];
//    
//    //2. Define the detail controller's view size
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    CGRect screenBound = [[UIScreen mainScreen] bounds];
//    CGSize screenSize = screenBound.size;
//    
//    CGRect rect = CGRectMake(0, screenSize.height - 50, screenSize.width, 50);
//    detailVC.view.frame = rect;
//
//    //3. Add the Detail controller's view to the Container's detail view and save a reference to the detail View Controller
//    [self.rootView addSubview:detailVC.view];
//    self.tabBarController = detailVC;
//    
//    //4. Complete the add flow calling the function didMoveToParentViewController
//    [detailVC didMoveToParentViewController:self];
//    
//}
//
//- (void)removeCurrentDetailViewController{
//    
//    //1. Call the willMoveToParentViewController with nil
//    //   This is the last method where your detailViewController can perform some operations before neing removed
//    [self.tabBarController willMoveToParentViewController:nil];
//    
//    //2. Remove the DetailViewController's view from the Container
//    [self.tabBarController.view removeFromSuperview];
//    
//    //3. Update the hierarchy"
//    //   Automatically the method didMoveToParentViewController: will be called on the detailViewController)
//    [self.tabBarController removeFromParentViewController];
//}

#pragma mark -
#pragma mark Accessors

AKRootViewAndReturnIfNil(AKTeamsView)

- (void)setLeague:(AKLeague *)league {
    if (_league != league) {
        _league = league;
        
        self.context = [[AKTeamContext alloc] initWithID:_league.ID];
    }
}

- (NSString *)navigationItemTitle {
    return kAKTeamsNavigationItemTitle;
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teamsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTeamsViewCell *cell = [tableView dequeueCellFromNibWithClass:[AKTeamsViewCell class]];
    [cell fillWithModel:self.teamsArray[indexPath.row]];
    
    return cell;
}
///////////////////////need to delete whet tab bar will ready
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKMatchesViewController *controller = [AKMatchesViewController new];
    controller.league = self.league;
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Public

- (void)contextDidLoadWithObject:(NSSet *)teams {
    self.teamsArray = [teams allObjects];
    AKTeamsView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.rootView removeLoadingViewAnimated:YES];
}

- (void)contextDidFailToLoad:(NSSet *)teams {
    [super contextDidFailToLoad:teams];
    self.teamsArray = [teams allObjects];
    AKTeamsView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.rootView removeLoadingViewAnimated:YES];
}

@end
