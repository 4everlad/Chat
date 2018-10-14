//
//  ThemesViewControllerDelegate.h
//  Chat
//
//  Created by Dmitry Bakulin on 12.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

#ifndef ThemesViewControllerDelegate_h
#define ThemesViewControllerDelegate_h


#endif /* ThemesViewControllerDelegate_h */

@class ThemesViewController;

@protocol ThemesViewControllerDelegate <NSObject>

@required - (void) themesViewController: (ThemesViewController*) controller
               didSelectTheme: (UIColor*)selectedTheme;

@end
