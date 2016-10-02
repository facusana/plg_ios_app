//
//  MapViewController.m
//  Per La Gloria
//
//  Created by Sergey Shatalov on 12.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "MapViewController.h"
#import "APIRequestManager.h"
#import "UIImageView+WebCache.h"

@import M13ProgressSuite;

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (strong, nonatomic) IBOutlet M13ProgressViewBar *progressViewBar;

@end
@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.progressViewBar setHidden:YES];
    [self.progressViewBar setIndeterminate:YES];
    [self.progressViewBar setShowPercentage:NO];
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                 forHTTPHeaderField:@"Accept"];
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
    NSNumber *teamID = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTeamID"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    NSURL *url = [NSURL URLWithString:[[kAPIServerHostUrl stringByAppendingString:kAPIloadFixtureMatchMapImageUrl] stringByAppendingString:teamID.stringValue]];
    
    [self.mapImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIImage * portraitImage = [[UIImage alloc] initWithCGImage: image.CGImage
                                                             scale: 1.0
                                                       orientation: UIImageOrientationLeft];
        if (!error) {
            [UIView transitionWithView:self.mapImageView
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                self.mapImageView.image = portraitImage;
                            }
                            completion:NULL];
        }
        else
            [self displayErrorAlertAndRetry];
            }];
}

@end
