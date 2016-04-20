//
//  UIAlertView+AssociateObj.h
//  efangxue_teacher
//
//  Created by mac on 16/2/26.
//  Copyright © 2016年 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (AssociateObj)

- (void)setIdentifierKey:(NSString *)identifier;

- (NSString *)getIdentifierKey;

@end
