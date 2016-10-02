//
//  TeamSelectionViewController.m
//  Per La Glory
//
//  Created by Sergey Shatalov on 07.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "TeamSelectionViewController.h"
#import "StatisticsViewController.h"
#import "APIRequestManager.h"
#import "TeamSelectionTableViewCell.h"
#import "TeamSelectionItem.h"
#import "UIImageView+WebCache.h"
@import M13ProgressSuite;

@interface TeamSelectionViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet M13ProgressViewBar *progressViewBar;

@property (strong, nonatomic) IBOutlet UIStackView *selectionStepsStackView;
@property (strong, nonatomic) NSNumber *currentSelectionStep;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *tableViewCells;
@property (nonatomic) BOOL readyToProceedToTheNextStep;
@end

@implementation TeamSelectionViewController

- (NSMutableArray *)tableViewCells {
    if (!_tableViewCells) _tableViewCells = [[NSMutableArray alloc] init];
    return _tableViewCells;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}

- (NSNumber *)currentSelectionStep {
    if (!_currentSelectionStep) _currentSelectionStep = @(1);
    return _currentSelectionStep;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.progressViewBar setHidden:YES];
    [self.progressViewBar setIndeterminate:YES];
    [self.progressViewBar setShowPercentage:NO];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self updateSelectedStepStack];
    [self updateDataArray];
}

- (IBAction)nextStepButtonClicked:(UIBarButtonItem *)sender {
    if (self.readyToProceedToTheNextStep) {
        if (self.currentSelectionStep.integerValue <= [[self.selectionStepsStackView arrangedSubviews] count]) {
            self.currentSelectionStep = @(self.currentSelectionStep.integerValue + 1);
            [self updateSelectedStepStack];
            self.readyToProceedToTheNextStep = NO;
            [self updateDataArray];
        }
        else {
            [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"teamAlreadySelected"];
            
            for (TeamSelectionItem *dataItem in self.dataArray)
            {
                if (dataItem.isSelected) {
                    [[NSUserDefaults standardUserDefaults] setObject:dataItem.id forKey:@"selectedTeamID"];
                    [[NSUserDefaults standardUserDefaults] setObject:dataItem.name forKey:@"selectedTeamName"];
                }
            }
            
            [self performSegueWithIdentifier:@"fromTeamSelectionToStatisticsSegue" sender:self];
        }
    }
}

- (void)updateSelectedStepStack {
    for (UIStackView *selectionStepStackView in [self.selectionStepsStackView arrangedSubviews]) {
        if ([self.selectionStepsStackView.arrangedSubviews indexOfObject:selectionStepStackView] >= self.currentSelectionStep.integerValue)
            [selectionStepStackView setHidden:YES];
        else
            [selectionStepStackView setHidden:NO];
    }
}

- (void)updateDataArray {
    [self.progressViewBar setHidden:NO];
    switch (self.currentSelectionStep.integerValue) {
        case 1: {
            [APIRequestManager getCustomersWithCompletion:^(NSArray *customersArray, NSError *error) {
                if (!error) {
                    self.dataArray = [NSMutableArray arrayWithArray:customersArray];
                    [self.tableView reloadData];
                }
                else
                    [self displayErrorAlertAndRetry];
                
                [self.progressViewBar setHidden:YES];
            }];
        }
            break;
        case 2: {
            for (TeamSelectionTableViewCell *someCell in self.tableViewCells) {
                [someCell.checkButton setTintColor:[UIColor lightGrayColor]];
                [someCell.titleLabel setText:@""];
                [self.tableView setHidden:YES];
            }
            for (TeamSelectionItem *dataItem in self.dataArray) {
                if (dataItem.isSelected) {
                    [APIRequestManager getTournamentsForCustomer:dataItem.id WithCompletion:^(NSArray *tournamentsArray, NSError *error) {
                        if (!error) {
                            self.dataArray = [NSMutableArray arrayWithArray:tournamentsArray];
                            [self.tableView reloadData];
                            [self.tableView setHidden:NO];
                        }
                        else
                            [self displayErrorAlertAndRetry];
                        
                        [self.progressViewBar setHidden:YES];
                    }];
                    break;
                }
            }
        }
            break;
        case 3: {
            for (TeamSelectionTableViewCell *someCell in self.tableViewCells) {
                [someCell.checkButton setTintColor:[UIColor lightGrayColor]];
                [someCell.titleLabel setText:@""];
                [self.tableView setHidden:YES];
            }
            for (TeamSelectionItem *dataItem in self.dataArray) {
                if (dataItem.isSelected) {
                    [APIRequestManager getDivisionsForTournament:dataItem.id WithCompletion:^(NSArray *tournamentsArray, NSError *error) {
                        if (!error) {
                            self.dataArray = [NSMutableArray arrayWithArray:tournamentsArray];
                            [self.tableView reloadData];
                            [self.tableView setHidden:NO];
                        }
                        else
                            [self displayErrorAlertAndRetry];
                        
                        [self.progressViewBar setHidden:YES];
                    }];
                    break;
                }
            }
        }
            break;
        case 4: {
            for (TeamSelectionTableViewCell *someCell in self.tableViewCells) {
                [someCell.checkButton setTintColor:[UIColor lightGrayColor]];
                [someCell.titleLabel setText:@""];
                [self.tableView setHidden:YES];
            }
            for (TeamSelectionItem *dataItem in self.dataArray) {
                if (dataItem.isSelected) {
                    [[NSUserDefaults standardUserDefaults] setObject:dataItem.id forKey:@"selectedDivision"];
                    [APIRequestManager getTeamsForDivision:dataItem.id WithCompletion:^(NSArray *customersArray, NSError *error) {
                        if (!error) {
                            self.dataArray = [NSMutableArray arrayWithArray:customersArray];
                            [self.tableView reloadData];
                            [self.tableView setHidden:NO];
                        }
                        else
                            [self displayErrorAlertAndRetry];
                        
                        [self.progressViewBar setHidden:YES];
                    }];
                    break;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)displayErrorAlertAndRetry {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Comprueba tu conexión a internet" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* actionCancel = [UIAlertAction actionWithTitle:@"Cerrar" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [self updateDataArray];
                                                         }];
    
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TeamSelectionItem *dataItem = [self.dataArray objectAtIndex:indexPath.row];
    TeamSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teamSelectionTableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = dataItem.name;
    [self.tableViewCells addObject:cell];
    cell.cellImageView.image = nil;
    if (self.currentSelectionStep.integerValue == 1) {
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                     forHTTPHeaderField:@"Accept"];
        NSURL *url = [NSURL URLWithString:[[kAPIServerHostUrl stringByAppendingString:kAPIloadCustomerImageByCustomerIdUrl] stringByAppendingString:dataItem.id.stringValue]];
        [cell.cellImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                [UIView transitionWithView:cell.cellImageView
                                  duration:0.3
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    cell.cellImageView.image = image;
                                }
                                completion:NULL];
            }
            else {
            }   
        }];
    }
    else if (self.currentSelectionStep.integerValue == 4) {
        [cell.checkButton setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    if (self.currentSelectionStep.integerValue != 1) {
        [[[cell.imageAndLabelStackView arrangedSubviews] firstObject] setHidden:YES];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (TeamSelectionTableViewCell *someCell in self.tableViewCells)
        [someCell.checkButton setTintColor:[UIColor lightGrayColor]];
    for (TeamSelectionItem *dataItem in self.dataArray)
        dataItem.isSelected = NO;
    TeamSelectionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    TeamSelectionItem *dataItem = [self.dataArray objectAtIndex:indexPath.row];
    dataItem.isSelected = YES;
    [cell.checkButton setTintColor:self.view.tintColor];
    self.readyToProceedToTheNextStep = YES;
    
    if ([self.selectionStepsStackView.arrangedSubviews count] >  self.currentSelectionStep.integerValue - 1) {
        UIStackView *currentStackView = [self.selectionStepsStackView.arrangedSubviews objectAtIndex:self.currentSelectionStep.integerValue - 1];
        UILabel *titleLabel = [currentStackView.arrangedSubviews lastObject];
        titleLabel.text = cell.titleLabel.text;
    }
}

@end
