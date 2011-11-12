//
//  CallbackParser.m
//  Client
//
//  Created by Frank Emminghaus on 14.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CallbackParser.h"
#import "HBCIBridge.h"
#import "CallbackData.h"


@implementation CallbackParser


-(id)initWithParent: (HBCIBridge*)par command:(NSString*)cmd
{
	self = [super init ];
	if(self == nil) return nil;
	data = [[CallbackData alloc ] init ];
	data.command = cmd;
	parent = par;
	return self;
}

-(void)dealloc
{
	[data dealloc ];
	[super dealloc ];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	currentValue = [[[NSMutableString alloc ] init ] autorelease ];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [currentValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString: @"callback" ]) {
		[parser setDelegate: parent ];
		 
		// do command handling here.
		NSString *result = [parent callbackWithData: data ]; 
		
		NSPipe *pipe = [parent outPipe ];
		result = [result stringByAppendingString: @"\n" ];
		[[pipe fileHandleForWriting ] writeData: [result dataUsingEncoding: NSUTF8StringEncoding ] ];
		[self autorelease ];
		return;
	}
	[data setValue: currentValue forKey:elementName ];
}

@end