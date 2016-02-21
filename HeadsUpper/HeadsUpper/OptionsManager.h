//
//  OptionsManager.h
//  HeadsUpper
//
//  Created by Natalia Estrella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//@protocol OptionsDelegate <NSObject>
//
//-(void)updateOption:(NSString *) option;
//
//@end


@interface OptionsManager : NSObject
//@property (nonatomic, weak) id<OptionsDelegate> optionsManagerDelegate;

@property (nonatomic) NSString *categoryName;
@property (nonatomic) NSArray *categoryOptions;
@property (nonatomic) NSString *selection;

@end
