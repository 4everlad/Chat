//
//  ThemesViewController.m
//  Chat
//
//  Created by Dmitry Bakulin on 11.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

#import "ThemesViewController.h"
#import "Themes.h"
#import "ThemesViewControllerDelegate.h"


@interface ThemesViewController ()

@property (retain, nonatomic) IBOutlet UIButton *theme1Button;
@property (retain, nonatomic) IBOutlet UIButton *theme2Button;
@property (retain, nonatomic) IBOutlet UIButton *theme3Button;

@end

@implementation ThemesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _theme1Button.tag = 1;
    _theme2Button.tag = 2;
    _theme3Button.tag = 3;
    
    // Do any additional setup after loading the view.
}


-(IBAction)selectTheme:(UIControl *)sender {
    Themes * myTheme = [[Themes alloc] init];
    switch (sender.tag) {
        case 1:
            self.view.backgroundColor = myTheme.theme1;
            [self.delegate themesViewController: self didSelectTheme:myTheme.theme1];
            break;
        case 2:
            self.view.backgroundColor = myTheme.theme2;
            [self.delegate themesViewController: self didSelectTheme:myTheme.theme2];
            break;
        case 3:
            self.view.backgroundColor = myTheme.theme3;
            [self.delegate themesViewController: self didSelectTheme: myTheme.theme3];
            break;
        default:
            printf("wrong tag");
            break;
    }
    [myTheme release];
}

- (IBAction)closeThemesButton:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_theme1Button release];
    [_theme2Button release];
    [_theme3Button release];
    [super dealloc];
}
@end
