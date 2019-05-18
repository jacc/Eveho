#import <headers.h>


%hook PackageListViewController
- (void)viewDidLoad{
	%orig;
    if ([self.title isEqualToString:@"Packages"]) {
        UIBarButtonItem *exportButton([[UIBarButtonItem alloc] initWithTitle:@"Export" style:UIBarButtonItemStylePlain target:self action:@selector(exportButtonClicked:)]);
        [[self navigationItem] setLeftBarButtonItem:exportButton];
    }
}

%new
-(void)exportButtonClicked:(UIButton*)button{
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Export"
                           message:@"Would you like to export your packages list? This will copy all package names and their versions to your clipboard."
                           preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes, copy." style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {[self copyPackages];}];
	UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"No, cancel." style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction * action) {}];

	[alert addAction:defaultAction];
	[alert addAction:cancelAction];
	[self presentViewController:alert animated:YES completion:nil];
}
%new
-(void)copyPackages {
		NSMutableString *bodyFromArray = [[NSMutableString alloc] init];
		NSArray *packages = MSHookIvar<NSArray *>(self, "_packages");
		for (Package* object in packages)
		{
			NSString *packageName = MSHookIvar<NSString *>(object, "_name");
			NSString *packageVersion = MSHookIvar<NSString *>(object, "_version");
			[bodyFromArray appendString:[NSString stringWithFormat:@"%@: %@\n", packageName, packageVersion]];
		}
		[bodyFromArray deleteCharactersInRange:NSMakeRange([bodyFromArray length]-1, 1)];
		UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
		pasteboard.string = bodyFromArray;
}
%end

#import <headers.h>


%hook SourcesViewController
- (void)viewDidLoad{
	%orig;
    if ([self.title isEqualToString:@"Sources"]) {
        UIBarButtonItem *exportButton([[UIBarButtonItem alloc] initWithTitle:@"Export" style:UIBarButtonItemStylePlain target:self action:@selector(exportButtonClicked:)]);
        [[self navigationItem] setLeftBarButtonItem:exportButton];
    }
}

%new
-(void)exportButtonClicked:(UIButton*)button{
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Export"
                           message:@"Would you like to export your source list? This will copy all source URLs to your clipboard."
                           preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes, copy." style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {[self copySources];}];
	UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"No, cancel." style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction * action) {}];

	[alert addAction:defaultAction];
	[alert addAction:cancelAction];
	[self presentViewController:alert animated:YES completion:nil];
}
%new
-(void)copySources {
		NSMutableString *bodyFromArray = [[NSMutableString alloc] init];
		NSArray *sources = MSHookIvar<NSArray *>(self, "_sortedRepoList");
		for (Source* object in sources)
		{
			NSString *URL = MSHookIvar<NSString *>(object, "_rawURL");
			[bodyFromArray appendString:[NSString stringWithFormat:@"%@\n", URL]];
		}
		[bodyFromArray deleteCharactersInRange:NSMakeRange([bodyFromArray length]-1, 1)];
		UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
		pasteboard.string = bodyFromArray;
}
%end

