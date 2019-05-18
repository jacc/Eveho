#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface Package : NSObject {
    NSString *_name;
    NSString *_version;
}
@end

@interface Source : NSObject {
    NSString *_rawURL;
}
@end

@interface PackageViewController : UIViewController
@property (nonatomic, retain) Source* package;
@end

@interface FeaturedViewController : UIViewController
@end

@interface SourcesViewController : UIViewController
-(void)copySources;
@property (nonatomic, retain) Source* sources;
@end

@interface PackageListViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	NSArray *_packages;
}

-(void)copyPackages;
@end

@interface UIView (Internal)
-(id)_viewControllerForAncestor;
@end