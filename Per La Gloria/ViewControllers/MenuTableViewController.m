//
//  MenuTableViewController.m
//  Per La Gloria
//
//  Created by Sergey Shatalov on 14.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "MenuTableViewController.h"
#import "FixtureMatchInfo.h"
#import "APIRequestManager.h"

@interface MenuTableViewController () <UITableViewDelegate, UITableViewDataSource>

#define kGMapsAppBaseURL @"comgooglemaps://?daddr="
#define kGMapsWebBaseURL @"http://maps.google.com/maps?daddr="

@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *teamName = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTeamName"] uppercaseString];
    self.teamNameLabel.text = teamName;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        NSNumber *teamID = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTeamID"];
        [APIRequestManager getFixtureMatchInfoForTeam:teamID WithCompletion:^(FixtureMatchInfo *fixtureMatchInfo, NSError *error) {
            NSString *latitudeLongitudeString = [NSString stringWithFormat:@"%f,%f", fixtureMatchInfo.latitude.doubleValue, fixtureMatchInfo.longitude.doubleValue];
            NSURL *navURL;
            if ([[UIApplication sharedApplication] canOpenURL:
                 [NSURL URLWithString:@"comgooglemaps://"]])
                navURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kGMapsAppBaseURL, latitudeLongitudeString]];
            else
                navURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kGMapsWebBaseURL, latitudeLongitudeString]];
            [[UIApplication sharedApplication] openURL:navURL];
        }];
    }
}

@end
