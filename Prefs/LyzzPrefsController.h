#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Cephei/HBPreferences.h>

#import <spawn.h>
#import <signal.h>

#import "LyzzHBAppearanceSettings.h"

@interface LyzzPrefsController : HBRootListController {
    UITableView * _table;
}

- (void) respring;

@end
