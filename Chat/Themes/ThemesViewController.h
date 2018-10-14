//
//  ThemesViewController.h
//  Chat
//
//  Created by Dmitry Bakulin on 11.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemesViewControllerDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface ThemesViewController : UIViewController 

@property (weak, nonatomic) id <ThemesViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
