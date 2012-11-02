//
//  PasswordWindow.h
//  Pecunia
//
//  Created by Frank Emminghaus on 23.05.09.
//  Copyright 2009 Frank Emminghaus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BWGradientBox;

@interface PasswordWindow : NSWindowController {

	IBOutlet NSTextField	*inputText;
	IBOutlet NSTextField	*inputField;
    IBOutlet NSButton       *savePasswordButton;
	
	NSAttributedString      *text;
	NSString                *title;
	NSString                *result;
    IBOutlet BWGradientBox  *topGradient;
    IBOutlet BWGradientBox  *backgroundGradient;
    NSTimer                 *shakeTimer;

	BOOL		savePassword;
	BOOL		active;
    BOOL        hidePasswortSave;
    BOOL        retry;
    
    int         shakeCount;
}

-(id)initWithText: (NSString* )x title: (NSString *)y;
-(void)controlTextDidEndEditing:(NSNotification *)aNotification;
-(void)windowWillClose:(NSNotification *)aNotification;
-(void)windowDidLoad;
-(void)closeWindow;
-(NSString*)result;
-(BOOL)shouldSavePassword;
-(void)retry;
-(void)disablePasswordSave;

@end
