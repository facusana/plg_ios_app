//
//  FixtureViewController.m
//  Per La Gloria
//
//  Created by Sergey Shatalov on 13.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "FixtureViewController.h"
#import "APIRequestManager.h"
#import "FixtureMatchInfo.h"
#import "UIImageView+WebCache.h"

@import M13ProgressSuite;

@interface FixtureViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *team1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *team2ImageView;
@property (weak, nonatomic) IBOutlet UILabel *team1NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *team2NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfMatchLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourOfMatchLabel;
@property (weak, nonatomic) IBOutlet UILabel *fieldNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *headingLabel;
@property (strong, nonatomic) IBOutlet M13ProgressViewBar *progressViewBar;

@end
@implementation FixtureViewController

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
    [APIRequestManager getFixtureMatchInfoForTeam:teamID WithCompletion:^(FixtureMatchInfo *fixtureMatchInfo, NSError *error) {
        if (!error) {
            //We loaded needed info so let's unhide our view's subviews
            for (UIView *subview in [self.view subviews])
                [subview setHidden:NO];
            //Home and away team labels set
            self.team1NameLabel.text = fixtureMatchInfo.homeTeam.name.length ? fixtureMatchInfo.homeTeam.name : @"No hay datos de equipo";
            self.team2NameLabel.text = fixtureMatchInfo.awayTeam.name.length ? fixtureMatchInfo.awayTeam.name : @"No hay datos de equipo";
            //Home and away team images set
            [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                         forHTTPHeaderField:@"Accept"];
            NSURL *url;
            if (fixtureMatchInfo.homeTeam.id) {
                url = [NSURL URLWithString:[[kAPIServerHostUrl stringByAppendingString:kAPIloadTeamImageUrl] stringByAppendingString:fixtureMatchInfo.homeTeam.id.stringValue]];
                [self.team1ImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"shirt"]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (!error) {
                        [UIView transitionWithView:self.team1ImageView
                                          duration:0.3
                                           options:UIViewAnimationOptionTransitionCrossDissolve
                                        animations:^{
                                            self.team1ImageView.image = image;
                                        }
                                        completion:NULL];
                    }
                }];
            }
            if (fixtureMatchInfo.awayTeam.id) {
                url = [NSURL URLWithString:[[kAPIServerHostUrl stringByAppendingString:kAPIloadTeamImageUrl] stringByAppendingString:fixtureMatchInfo.awayTeam.id.stringValue]];
                [self.team2ImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"shirt"]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (!error) {
                        [UIView transitionWithView:self.team2ImageView
                                          duration:0.3
                                           options:UIViewAnimationOptionTransitionCrossDissolve
                                        animations:^{
                                            self.team2ImageView.image = image;
                                        }
                                        completion:NULL];
                    }
                }];
            }
            //Other fixture info set
            NSString *dateString = [fixtureMatchInfo.fixtureDate.date componentsSeparatedByString:@"T"][0];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-mm-dd"];
            NSDate *date = [formatter dateFromString:dateString];
            [formatter setDateFormat:@"dd/mm/yyyy"];
            dateString = [formatter stringFromDate:date];
            NSString *time = fixtureMatchInfo.hour;
            self.hourOfMatchLabel.text = time ? time : @"--:--:--";
            self.dateOfMatchLabel.text = dateString ? dateString : @"--/--/----";
            self.dateNumberLabel.text = fixtureMatchInfo.fixtureDate.dateNumber ? fixtureMatchInfo.fixtureDate.dateNumber : @"Fecha: -";
            
            self.fieldNumberLabel.text = ![fixtureMatchInfo.fieldNumber isKindOfClass:[NSNull class]] ?
            [NSString stringWithFormat:@"Cancha: %@", fixtureMatchInfo.fieldNumber] : @"Cancha: -";
            self.headingLabel.text = fixtureMatchInfo.heading ? fixtureMatchInfo.heading : @"PRÓXIMO PARTIDO";
        }
        else
            [self displayErrorAlertAndRetry];
        [self.progressViewBar setHidden:YES];
    }];
}

@end
