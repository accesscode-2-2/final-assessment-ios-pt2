//
//  OptionsManager.m
//  HeadsUpper
//
//  Created by Natalia Estrella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "OptionsManager.h"

@interface OptionsManager ()

@end

@implementation OptionsManager

-(void)saveSelection {
    [[NSUserDefaults standardUserDefaults] setObject:self.selection forKey:self.categoryName];
    
    
}

-(void)loadDefautls {
    NSString *selection = [[NSUserDefaults standardUserDefaults] objectForKey:self.categoryName];
    if (selection != nil) {
        self.selection = selection;
    }
}
@end
