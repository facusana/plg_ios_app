//
//  TabBarController.m
//  Per La Gloria
//
//  Created by Sergey Shatalov on 14.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "TabBarController.h"

@implementation TabBarController

- (IBAction)optionsButtonClicked:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:
                                nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* actionSelectTeam = [UIAlertAction actionWithTitle:@"Seleccionar nuevo equipo" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 [self performSegueWithIdentifier:@"fromStatisticsToTeamSelectionSegue" sender:self];
                                                             }];
    UIAlertAction* actionCancel = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                         }];
    [alert addAction:actionSelectTeam];
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
