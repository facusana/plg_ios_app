//
//  StatisticsViewController.m
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "StatisticsViewController.h"
#import "StatisticsCell.h"
#import "APIRequestManager.h"
#import "Team.h"

@import M13ProgressSuite;

@interface StatisticsViewController() <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet M13ProgressViewBar *progressViewBar;
@property (weak, nonatomic) IBOutlet UITableView *statisticsTableView;
@property (strong, nonatomic) NSMutableArray *teamsArray;
@end

@implementation StatisticsViewController

- (NSMutableArray *)teamsArray {
    if (!_teamsArray) _teamsArray = [[NSMutableArray alloc] init];
    return _teamsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.progressViewBar setHidden:YES];
    [self.progressViewBar setIndeterminate:YES];
    [self.progressViewBar setShowPercentage:NO];
    NSString *teamName = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTeamName"] uppercaseString];
    NSNumber *teamID = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTeamID"];
    if (teamID && teamName ) {
        [self updateData];
        [self.tabBarController setTitle:teamName];
    }
    else
        [self.tabBarController performSegueWithIdentifier:@"fromStatisticsToTeamSelectionSegue" sender:self];
}

- (void)updateData {
    [self.progressViewBar setHidden:NO];
    NSNumber *teamID = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTeamID"];
    [APIRequestManager getStatisticsForTeam:teamID WithCompletion:^(NSArray *teamsArray, NSError *error) {
        if (!error) {
            self.teamsArray = [NSMutableArray arrayWithArray:teamsArray];
            [self.statisticsTableView reloadData];
        }
        else
            [self displayErrorAlertAndRetry];
        [self.progressViewBar setHidden:YES];
    }];
}

- (void)displayErrorAlertAndRetry {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Comprueba tu conexión a internet" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* actionCancel = [UIAlertAction actionWithTitle:@"Cerrar" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [self updateData];
                                                         }];
    
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark TableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teamsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *teamID = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTeamID"];
    StatisticsCell *cell;
    if (self.teamsArray.count){
        Team *currentTeam = [self.teamsArray objectAtIndex:indexPath.row];
        if (currentTeam.id.integerValue == teamID.integerValue) {
            StatisticsCell *selectedCell = [tableView dequeueReusableCellWithIdentifier:@"SelectedStatisticsCell" forIndexPath:indexPath];
            [selectedCell updateWithTeam:currentTeam withPosition:indexPath.row + 1];
            return selectedCell;
        }
        else
            cell = [tableView dequeueReusableCellWithIdentifier:@"StatisticsCell" forIndexPath:indexPath];
        [cell updateWithTeam:currentTeam withPosition:indexPath.row + 1];
    }
    return cell;
}



@end
