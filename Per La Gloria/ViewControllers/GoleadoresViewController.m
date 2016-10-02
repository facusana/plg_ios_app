//
//  GoleadoresViewController.m
//  Per La Gloria
//
//  Created by Sergey Shatalov on 14.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "GoleadoresViewController.h"
#import "GoleadoresCell.h"
#import "APIRequestManager.h"
#import "Player.h"

@import M13ProgressSuite;

@interface GoleadoresViewController() <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *scoresArray;
@property (strong, nonatomic) IBOutlet M13ProgressViewBar *progressViewBar;

@end

@implementation GoleadoresViewController

- (NSMutableArray *)scoresArray {
    if (!_scoresArray) _scoresArray = [[NSMutableArray alloc] init];
    return _scoresArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.progressViewBar setHidden:YES];
    [self.progressViewBar setIndeterminate:YES];
    [self.progressViewBar setShowPercentage:NO];
    [self updateData];
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

- (void)updateData {
    [self.progressViewBar setHidden:NO];
    NSNumber *teamID = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTeamID"];
    [APIRequestManager getScoresForTeam:teamID WithCompletion:^(NSArray *scoresArray, NSError *error) {
        if (!error) {
            self.scoresArray = [NSMutableArray arrayWithArray:scoresArray];
            [self.tableView reloadData];
        }
        else
            [self displayErrorAlertAndRetry];
        [self.progressViewBar setHidden:YES];
    }];
}

#pragma mark TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.scoresArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Player *currentPlayer = self.scoresArray[indexPath.row];
    GoleadoresCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoleadoresCell" forIndexPath:indexPath];
    cell.numberLabel.text = @(indexPath.row + 1).stringValue;
    cell.playerLabel.text = currentPlayer.playerName;
    cell.teamLabel.text = currentPlayer.teamName;
    cell.goalsLabel.text = currentPlayer.goals.stringValue;
    return cell;
}
@end
