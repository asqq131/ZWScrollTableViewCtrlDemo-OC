//
//  UIAlertView+AssociateObj.m
//  efangxue_teacher
//
//  Created by mac on 16/2/26.
//  Copyright © 2016年 macmini. All rights reserved.
//

#import "UIAlertView+AssociateObj.h"
#import <objc/runtime.h>

@implementation UIAlertView (AssociateObj)

static char identifierKey;

- (void)setIdentifierKey:(NSString *)identifier {
    objc_setAssociatedObject(self, &identifierKey, identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)getIdentifierKey {
    return objc_getAssociatedObject(self, &identifierKey);
}

@end
