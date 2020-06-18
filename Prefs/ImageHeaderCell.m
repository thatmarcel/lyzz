#import "ImageHeaderCell.h"

@implementation ImageHeaderCell
    @synthesize headerImageView;

    - (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier specifier: specifier];

	    if (self) {
			UIImage *image = [[UIImage alloc] initWithContentsOfFile: [[NSBundle bundleWithPath: @"/Library/PreferenceBundles/LyzzPrefs.bundle"] pathForResource: @"banner" ofType: @"jpg"]];
			self.headerImageView = [[UIImageView alloc] initWithImage: image];
            self.headerImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width / 4);
			[self addSubview: self.headerImageView];
	    }

	    return self;
	}

    - (instancetype) initWithSpecifier:(PSSpecifier *)specifier {
        self = [self initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ImageHeaderCell" specifier: specifier];
        return self;
    }

	- (CGFloat) preferredHeightForWidth:(CGFloat)width {
	    return [UIScreen mainScreen].bounds.size.width / 4;
	}
@end
